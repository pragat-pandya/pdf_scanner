import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_scanner/core/providers/firebase_providers.dart';
import 'package:pdf_scanner/features/auth/contoller/auth_controller.dart';
import 'package:pdf_scanner/features/auth/repository/auth_repository.dart';

/// Providers for authentication features in the PDF Scanner app.

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
