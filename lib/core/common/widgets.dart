import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_scanner/core/constants/constants.dart';
import 'package:pdf_scanner/features/auth/auth_providers.dart';
import 'package:pdf_scanner/theme/pallet.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  void signInWithGoogle(WidgetRef ref) {
    // Implement Google Sign-In logic here
    ref.read(authControllerProvider).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
        icon: Image.asset(
          Constants.googlePath,
          height: 24,
        ),
        onPressed: () => signInWithGoogle(ref),
        label: const Text(
          'Sign in with Google',
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Pallete.greyColor,
          foregroundColor: Pallete.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
