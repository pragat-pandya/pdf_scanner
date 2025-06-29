import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_scanner/core/logs/app_logger.dart';
import 'package:pdf_scanner/core/utils/ui_utils.dart';
import 'package:pdf_scanner/features/auth/auth_providers.dart';
import 'package:pdf_scanner/features/auth/repository/auth_repository.dart';

// EXTENDING A StateNotifier
// This allows us to manage state and notify listeners when the state changes.
// In this case, we are extending it with a boolean state to indicate loading status.

class AuthController extends StateNotifier<bool> {
  /// A controller for handling authentication operations.
  /// It uses an instance of [AuthRepository] to perform sign-in operations.
  /// This controller can be used in a Flutter application to manage user authentication.
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  void signInWithGoogle(BuildContext context) async {
    state = true; // Set loading state to true
    final user = await _authRepository.signInWithGoogle();
    state = false; // Set loading state to false after operation
    user.fold(
      (l) {
        showSnackbar(
          context: context,
          message: l.message,
        );
        AppLogger().error(
          "Error signing in with Google: ${l.stackTrace?.toString() ?? l.message}",
        );
        _ref.read(userProvider.notifier).update((state) => null);
        return;
      },
      (userModel) {
        AppLogger().success(
          "User signed in: ${userModel.email}",
        );
        _ref.read(userProvider.notifier).update((state) => userModel);
      },
    );
  }
}
