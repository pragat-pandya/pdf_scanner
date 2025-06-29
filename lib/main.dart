import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_scanner/core/logs/app_logger.dart';
import 'package:pdf_scanner/features/auth/screens/login_screen.dart';
import 'package:pdf_scanner/router.dart';
import 'package:pdf_scanner/theme/pallet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:routemaster/routemaster.dart';
import 'firebase_options.dart';

void main() {
  runZonedGuarded(() async {
    // Ensure that plugin services are initialized before using Firebase
    WidgetsFlutterBinding.ensureInitialized();

    // Set up Flutter error handler
    FlutterError.onError = (details) {
      AppLogger().handleFlutterError(details);
    };

    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    AppLogger().info('Firebase initialized successfully');

    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  }, (error, stackTrace) {
    AppLogger().handleError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PDF Scanner',
      debugShowCheckedModeBanner: false,
      theme: Pallete.darkModeAppTheme,
      routerDelegate:
          RoutemasterDelegate(routesBuilder: (context) => loggedOutRoutes),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
