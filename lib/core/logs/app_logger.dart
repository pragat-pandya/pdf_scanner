import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();

  final Talker talker = TalkerFlutter.init(
    settings: TalkerSettings(
      colors: {
        'debug': AnsiPen()..blue(),
        'info': AnsiPen()..green(),
        'warning': AnsiPen()..yellow(),
        'error': AnsiPen()..red(),
      },
    ),
  );

  factory AppLogger() {
    return _instance;
  }

  AppLogger._internal();

  void debug(String message) => talker.debug(message);

  void info(String message) => talker.info(message);

  void success(String message) {
    talker.info("✅ $message");
  }

  void warning(String message) => talker.warning(message);

  void error(String message, [Object? err, StackTrace? stack]) =>
      talker.error(message, err, stack);

  void handleFlutterError(FlutterErrorDetails details) {
    talker.handle(details.exception, details.stack ?? StackTrace.current);
  }

  void handleError(Object error, StackTrace stackTrace) {
    talker.handle(error, stackTrace);
  }
}
