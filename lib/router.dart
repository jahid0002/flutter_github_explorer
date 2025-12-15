import 'package:flutter_github_explorer/features/github_repository/presentation/screens/repository_list_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RepositoryListPage(),
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
