import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_scanner/core/providers/firebase_providers.dart';
import 'package:pdf_scanner/features/auth/contoller/auth_controller.dart';
import 'package:pdf_scanner/features/auth/repository/auth_repository.dart';
import 'package:pdf_scanner/models/user_model.dart';

/// Providers for authentication features in the PDF Scanner app.

final userProvider = StateProvider<UserModel?>((ref) => null);

/// Provides an instance of [AuthRepository] that handles authentication operations.
/// It uses Firebase Firestore, Firebase Auth, and Google Sign-In.
final authRepositoryProvider = Provider((ref) => AuthRepository(
      firestore: ref.watch(firestoreProvider),
      auth: ref.watch(authProvider),
      googleSignIn: ref.watch(googelSignInProvider),
    ));

/// Controller for handling authentication operations.
/// It uses the [AuthRepository] to perform sign-in operations.
final authControllerProvider = Provider(
    (ref) => AuthController(authRepository: ref.watch(authRepositoryProvider)));





//**
//  REF.READ / REF.WRITE is equivqlent here because we are using them inside a read-only provider.
//  This means that the provider is read-only and does not allow writing to it.

//  If you need to write to the provider, you should use a StateNotifier or a StateProvider
//  that allows for state management and updates.

// ALWAYS STICK TO REF.READ whenever outside the BuildContext.
//
// */