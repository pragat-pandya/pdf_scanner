import 'package:flutter/material.dart';
import 'package:pdf_scanner/core/logs/app_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DebugLogScreen extends StatelessWidget {
  const DebugLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TalkerScreen(
      talker: AppLogger().talker,
      theme: const TalkerScreenTheme(
        backgroundColor: Colors.black,
        textColor: Colors.white,
        cardColor: Color(0xFF1E1E1E),
        logColors: {
          'error': Colors.redAccent,
          'warning': Colors.orangeAccent,
          'info': Colors.cyanAccent,
          'debug': Colors.blueAccent,
        },
      ),
    );
  }
}
