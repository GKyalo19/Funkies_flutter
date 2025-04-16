import 'package:funkies_flutter/pages/about_us.dart';
import 'package:funkies_flutter/pages/events_page.dart';
import 'package:funkies_flutter/pages/home_page.dart';
import 'package:funkies_flutter/auth/log_in.dart';
import 'package:funkies_flutter/auth/sign_up.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MyHomePage()
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => AboutUs(),
    ),
    GoRoute(
      path: '/events',
      builder: (context, state) => EventsPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => EventsPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LogIn(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignUp(),
    ),
  ]
);
