import 'package:pdf_scanner/features/auth/repository/auth_repository.dart';

class AuthController {
  /// A controller for handling authentication operations.
  /// It uses an instance of [AuthRepository] to perform sign-in operations.
  /// This controller can be used in a Flutter application to manage user authentication.
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  void signInWithGoogle() {
    _authRepository.signInWithGoogle();
  }
}
