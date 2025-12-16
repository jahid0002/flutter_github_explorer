// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_explorer/features/github_repository/presentation/widgets/theme_button.dart';
import 'package:flutter_github_explorer/features/theme/bloc/theme_bloc.dart';
import 'package:flutter_github_explorer/features/theme/bloc/theme_event.dart';
import 'package:flutter_github_explorer/features/theme/bloc/theme_state.dart';

import '../bloc/repository_list/repository_list_bloc.dart';
import '../bloc/repository_list/repository_list_event.dart';
import '../bloc/repository_list/repository_list_state.dart';
import '../widgets/repository_card.dart';
import '../widgets/sort_button.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class RepositoryListPage extends StatefulWidget {
  const RepositoryListPage({super.key});

  @override
  State<RepositoryListPage> createState() => _RepositoryListPageState();
}

class _RepositoryListPageState extends State<RepositoryListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Premium App Bar with Gradient
          _buildSliverAppBar(context),

          // Main Content
          BlocBuilder<RepositoryListBloc, RepositoryListState>(
            builder: (context, state) {
              if (state is RepositoryListLoading) {
                return const SliverFillRemaining(
                  child: LoadingWidget(
                    message: 'Loading top Flutter repositories...',
                  ),
                );
              } else if (state is RepositoryListLoaded) {
                return _buildLoadedContent(context, state);
              } else if (state is RepositoryListError) {
                return SliverFillRemaining(
                  child: ErrorDisplayWidget(
                    message: state.message,
                    onRetry: () {
                      debugPrint(
                          '===================>> Retry Load Repositories');
                      context
                          .read<RepositoryListBloc>()
                          .add(const LoadRepositories());
                    },
                  ),
                );
              }
              return const SliverFillRemaining(
                child: SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: 120,
      collapsedHeight: 70,
      floating: true,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'GitHub Flutter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.primaryColor,
                theme.primaryColor.withOpacity(0.8),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Decorative circles
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                left: -30,
                bottom: -30,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        BlocBuilder<RepositoryListBloc, RepositoryListState>(
          builder: (context, state) {
            if (state is RepositoryListLoaded) {
              return SortButton(
                currentSort: state.currentSort,
                onSortChanged: (sortBy) {
                  context.read<RepositoryListBloc>().add(
                        SortRepositories(sortBy),
                      );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const SizedBox(width: 8),
        BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          if (state is ThemeLoaded) {
            return ThemeToggleButton(
              isDarkMode: state.isDarkMode,
              onToggle: () {
                context.read<ThemeBloc>().add(const ToggleTheme());
              },
            );
          } else {
            return const SizedBox.shrink();
          }
          // return const SizedBox.shrink();
        }),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildLoadedContent(BuildContext context, RepositoryListLoaded state) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == 0) {
              // Stats header
              return _buildStatsHeader(state.repositories.length);
            }

            final repository = state.repositories[index - 1];
            return AnimatedOpacity(
              duration: Duration(milliseconds: 300 + (index * 50)),
              opacity: 1.0,
              child: RepositoryCard(
                repository: repository,
                onTap: () {
                  //  context.push('/details/${repository.id}');
                },
              ),
            );
          },
          childCount: state.repositories.length + 1,
        ),
      ),
    );
  }

  Widget _buildStatsHeader(int count) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.shade100,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.code,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top $count Repositories',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Most starred Flutter projects on GitHub',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
