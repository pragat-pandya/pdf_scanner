// LOGGED OUT ROUTES

import 'package:flutter/material.dart';
import 'package:pdf_scanner/features/auth/home/screens/home_screen.dart';
import 'package:pdf_scanner/features/auth/screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoutes = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: LoginScreen()),
    // '/login': (_) => const MaterialPage(child: LoginScreen()),
    // '/register': (_) => const MaterialPage(child: RegisterScreen()),
    // '/forgot-password': (_) =>
    // const MaterialPage(child: ForgotPasswordScreen()),
    // '/reset-password': (_) => const MaterialPage(child: ResetPasswordScreen()),
  },
);

// LOGGED IN ROUTES
final loggedInRoutes = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: HomeScreen()),
    // '/home': (_) => const MaterialPage(child: HomeScreen()),
    // '/profile': (_) => const MaterialPage(child: ProfileScreen()),
    // '/settings': (_) => const MaterialPage(child: SettingsScreen()),
    // '/notifications': (_) => const MaterialPage(child: NotificationsScreen()),
  },
);
