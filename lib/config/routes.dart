import 'package:go_router/go_router.dart';

import '../features/home/screen/home_screen.dart';
import '../features/list_attendance/screen/list_attendance_screen.dart';
import '../features/auth/screen/login_screen.dart';
import '../features/splash_screen/splash_screen.dart';
import '../features/home/screen/admin_home_screen.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/admin-home',
  routes: <GoRoute>[
    GoRoute(
      path: '/splash-screen',
      name: 'splash-screen',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'menu',
          name: 'menu',
          builder: (context, state) {
            return const ListAttendanceScreen();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/admin-home',
      name: 'admin-home',
      builder: (context, state) => const AdminHomeScreen(),
    ),
  ],
);
