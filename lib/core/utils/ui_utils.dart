import 'package:flutter/material.dart';
import 'package:pdf_scanner/core/logs/app_logger.dart';

void showSnackbar({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
  Color? textColor,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor ?? Colors.white),
        ),
        backgroundColor: backgroundColor ?? Colors.black87,
        duration: const Duration(seconds: 3),
      ),
    );
}
