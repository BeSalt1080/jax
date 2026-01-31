import 'package:go_router/go_router.dart';
import 'package:jax/screens/merge_view_screen.dart';
import '../screens/home_screen.dart';
import '../screens/merge_screen.dart';
import '../screens/split_screen.dart';
import '../screens/compress_screen.dart';
import '../screens/organize_screen.dart';
import '../screens/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/merge', builder: (context, state) => const MergeScreen()),
    GoRoute(
      path: '/merge-view',
      builder: (context, state) =>
          MergeViewScreen(initialPaths: state.extra as List<String>?),
    ),
    GoRoute(path: '/split', builder: (context, state) => const SplitScreen()),
    GoRoute(
      path: '/compress',
      builder: (context, state) => const CompressScreen(),
    ),
    GoRoute(
      path: '/organize',
      builder: (context, state) => const OrganizeScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
