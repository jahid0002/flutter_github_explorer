import 'package:flutter_github_explorer/features/github_repository/presentation/screens/repository_list_page.dart';
import 'package:flutter_github_explorer/features/settings/splash_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutes {
  AppRoutes._();

  static const String repositoryListPage = '/';
  static const String splashScreen = '/Splash';
}

final router = GoRouter(
  initialLocation: AppRoutes.splashScreen,
  routes: [
    GoRoute(
      path: AppRoutes.repositoryListPage,
      builder: (context, state) => const RepositoryListPage(),
    ),

    GoRoute(
      path: AppRoutes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),
    // GoRoute(
    //   path: '/details/:id',
    //   builder: (context, state) {
    //     final id = int.parse(state.pathParameters['id']!);
    //     return RepositoryDetailsPage(repositoryId: id);
    //   },
    // ),
  ],
);
