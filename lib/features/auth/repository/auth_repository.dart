import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pdf_scanner/core/constants/constants.dart';
import 'package:pdf_scanner/core/logs/app_logger.dart';
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

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      AppLogger().success(
        "User signed in: ${userCredential.user?.email}",
      );
      // print("User signed in: ${userCredential.user?.email}");
      // UserModel userModel = UserModel(
      //   name: userCredential.user?.displayName ?? '',
      //   email: userCredential.user?.email ?? '',
      //   profilePic: userCredential.user?.photoURL ?? Constants.avatarDefault,
      //   banner: Constants.bannerDefault,
      //   uid: userCredential.user?.uid ?? '',
      //   isAuthenticated: true,
      //   isPremium: false,
      //   coins: 0,
      //   awards: [],
      // );
    } catch (E) {
      AppLogger().error("Error signing in with Google: $E");
    }
  }
}
