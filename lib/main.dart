import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_scanner/core/common/widgets.dart';
import 'package:pdf_scanner/core/logs/app_logger.dart';
import 'package:pdf_scanner/features/auth/auth_providers.dart';
import 'package:pdf_scanner/features/auth/screens/login_screen.dart';
import 'package:pdf_scanner/models/user_model.dart';
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

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;
  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;

    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
    // AppLogger().info('User data fetched: ${userModel?.name}');
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) => MaterialApp.router(
            title: 'PDF Scanner',
            debugShowCheckedModeBanner: false,
            theme: Pallete.darkModeAppTheme,
            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              if (data != null) {
                getData(ref, data);
                if (userModel != null) {
                  // AppLogger().info('User is logged in: ${userModel!.name}');
                  return loggedInRoutes;
                } else {
                  // AppLogger().warning('User data is null');
                  return loggedOutRoutes; // Fallback to logged-out routes
                }
              } else {
                return loggedInRoutes;
              }
            }),
            routeInformationParser: const RoutemasterParser(),
          ),
          error: (error, stackTrace) => ErrorText(
            errorMessage: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
