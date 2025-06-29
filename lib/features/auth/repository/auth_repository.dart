import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pdf_scanner/core/constants/constants.dart';
import 'package:pdf_scanner/core/failure.dart';
import 'package:pdf_scanner/core/logs/app_logger.dart';
import 'package:pdf_scanner/core/type_defs.dart';
import 'package:pdf_scanner/models/user_model.dart';

class AuthRepository {
  /// A repository for handling authentication operations.
  /// It uses Firebase Firestore, Firebase Auth, and Google Sign-In.
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _firestore = firestore,
        _auth = auth,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        AppLogger().error("User document does not exist for UID: $uid");
        return UserModel(
          name: 'Guest',
          email: '',
          profilePic: Constants.avatarDefault,
          banner: Constants.bannerDefault,
          uid: uid,
          isAuthenticated: false,
          isPremium: false,
          coins: 0,
          awards: [],
        );
      }
    });
  }

  FutureEither<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      AppLogger()
          .info("User Credentials Obtained for ${userCredential.user?.email}");

      UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        AppLogger().info("New user created: ${userCredential.user?.email}");
        userModel = UserModel(
          name: userCredential.user?.displayName ?? '',
          email: userCredential.user?.email ?? '',
          profilePic: userCredential.user?.photoURL ?? Constants.avatarDefault,
          banner: Constants.bannerDefault,
          uid: userCredential.user!.uid,
          isAuthenticated: true,
          isPremium: false,
          coins: 0,
          awards: [],
        );

        await _users
            .doc(userCredential.user!.uid)
            .set(
              userModel.toMap(),
            )
            .then((_) {
          AppLogger().success("User data saved successfully.");
        }).catchError((error) {
          AppLogger().error("Error saving user data: $error");
        });
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
        AppLogger()
            .info("Existing user signed in: ${userCredential.user!.email}");
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      AppLogger().error("Firebase Exception: $e");
      throw e.message!;
    } catch (E) {
      AppLogger().error("Error signing in with Google: $E");
      return left(
        Failure(
          "Error signing in with Google: ${E.toString()}",
          stackTrace: StackTrace.current,
        ),
      );
    }
  }
}
