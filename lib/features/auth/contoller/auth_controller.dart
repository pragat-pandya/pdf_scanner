import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_scanner/core/utils/ui_utils.dart';
import 'package:pdf_scanner/features/auth/auth_providers.dart';
import 'package:pdf_scanner/features/auth/repository/auth_repository.dart';

class AuthController {
  /// A controller for handling authentication operations.
  /// It uses an instance of [AuthRepository] to perform sign-in operations.
  /// This controller can be used in a Flutter application to manage user authentication.
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref;

  void signInWithGoogle(BuildContext context) async {
    final user = await _authRepository.signInWithGoogle();

    user.fold(
      (l) => showSnackbar(context: context, message: l.message),
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }
}
