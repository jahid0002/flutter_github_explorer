import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_explorer/features/theme/bloc/theme_bloc.dart';
import 'package:flutter_github_explorer/features/theme/bloc/theme_event.dart';
import 'package:flutter_github_explorer/features/theme/bloc/theme_state.dart';

import 'injection_container.dart' as di;
import 'router.dart';
import 'core/theme/app_theme.dart';
import 'features/github_repository/presentation/bloc/repository_list/repository_list_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
          lazy: false,
          create: (_) => di.sl<RepositoryListBloc>(),
        ),
        BlocProvider<ThemeBloc>(
          lazy: false,
          create: (_) => di.sl<ThemeBloc>()..add(const LoadTheme()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final isDarkMode = state is ThemeLoaded && state.isDarkMode;

          return MaterialApp.router(
            title: 'GitHub Explorer',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<RepositoryListBloc>(
//           lazy: false,
//           create: (_) => di.sl<RepositoryListBloc>(),
//         ),
//         BlocProvider<ThemeBloc>(
//           // lazy: false,
//           create: (_) => di.sl<ThemeBloc>(),
//         ),
//       ],
//       child: MaterialApp.router(
//         title: 'GitHub Explorer',
//         debugShowCheckedModeBanner: false,

//         // Themes
//         theme: AppTheme.lightTheme,
//         darkTheme: AppTheme.darkTheme,
//         themeMode: ThemeMode.system,

//         // Router
//         routerConfig: router,
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_github_explorer/features/github_repository/presentation/bloc/repository_list/repository_list_event.dart';

// import 'injection_container.dart' as di;
// import 'router.dart';
// import 'core/theme/app_theme.dart';
// import 'features/github_repository/presentation/bloc/repository_list/repository_list_bloc.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

  

//   // Setup dependency injection
//   await di.init();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<RepositoryListBloc>(
//           create: (_) => di.sl<RepositoryListBloc>()..add(LoadRepositories()),
//         ),
//         // BlocProvider<RepositoryDetailsBloc>(
//         //   create: (_) => di.sl<RepositoryDetailsBloc>(),
//         // ),
//         // BlocProvider<ThemeBloc>(
//         //   create: (_) => di.sl<ThemeBloc>(),
//         // ),
//       ],
//       child: MaterialApp.router(
//         title: 'GitHub Explorer',
//         theme: AppTheme.lightTheme,
//         darkTheme: AppTheme.darkTheme,
//         themeMode: ThemeMode.system,
//         routerConfig: router,
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }
