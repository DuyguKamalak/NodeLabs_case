import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/register_page.dart';
import '../../features/navigation/presentation/main_navigation_page.dart';
import 'app_routes.dart';

/// Uygulama router konfigürasyonu
class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  /// GoRouter instance
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    routes: [
      // Auth Routes
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),

      // Main Navigation
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const MainNavigationPage(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundView(),
  );

  /// Router instance
  static GoRouter get instance => router;

  /// Current location
  static String get currentLocation =>
      router.routerDelegate.currentConfiguration.fullPath;

  /// Go to route
  static void go(String location) => router.go(location);

  /// Push route
  static void push(String location) => router.push(location);

  /// Pop route
  static void pop() => router.pop();

  /// Can pop
  static bool canPop() => router.canPop();

  /// Replace route
  static void replace(String location) => router.replace(location);

  /// Go to home
  static void goToHome() => go(AppRoutes.home);

  /// Go to login
  static void goToLogin() => go(AppRoutes.login);

  /// Go to profile
  static void goToProfile() => go(AppRoutes.profile);

  /// Logout and go to login
  static void logout() {
    go(AppRoutes.login);
  }
}

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 100),
            SizedBox(height: 16),
            Text('404 - Page Not Found', style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text('The page you are looking for does not exist.'),
          ],
        ),
      ),
    );
  }
}