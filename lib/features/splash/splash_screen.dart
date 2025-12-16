// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_explorer/features/github_repository/presentation/bloc/repository_list/repository_list_bloc.dart';
import 'package:flutter_github_explorer/features/github_repository/presentation/bloc/repository_list/repository_list_event.dart';
import 'package:flutter_github_explorer/router.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for first frame to be rendered, then access context
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    debugPrint('========== Splash: Starting initialization ==========');

    // Now it's safe to use context
    context.read<RepositoryListBloc>().add(LoadRepositoriesWithSavedSort());
    context.read<RepositoryListBloc>().add(const LoadRepositories());
    // context.read<ThemeBloc>().add(const LoadTheme());

    // Wait for splash duration
    await Future.delayed(const Duration(seconds: 2));

    debugPrint('========== Splash: Navigating to Home ==========');
    if (mounted) {
      context.go(AppRoutes.repositoryListPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
