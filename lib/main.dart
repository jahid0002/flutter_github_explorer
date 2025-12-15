import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;
import 'router.dart';
import 'core/theme/app_theme.dart';
import 'features/github_repository/presentation/bloc/repository_list/repository_list_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive

  // Setup dependency injection
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RepositoryListBloc>(
          create: (_) => di.sl<RepositoryListBloc>(),
        ),
        // BlocProvider<RepositoryDetailsBloc>(
        //   create: (_) => di.sl<RepositoryDetailsBloc>(),
        // ),
        // BlocProvider<ThemeBloc>(
        //   create: (_) => di.sl<ThemeBloc>(),
        // ),
      ],
      child: MaterialApp.router(
        title: 'GitHub Explorer',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
