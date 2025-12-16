import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_explorer/core/network/network_info.dart';

import 'package:flutter_github_explorer/core/utils/constants.dart';
import 'package:flutter_github_explorer/core/utils/sort_preference_manager.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/entities/repository.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/usecases/get_repositories.dart';
import 'repository_list_event.dart';
import 'repository_list_state.dart';

class RepositoryListBloc
    extends Bloc<RepositoryListEvent, RepositoryListState> {
  final GetRepositories getRepositories;
  final NetworkInfo networkInfo;
  final SortPreferenceManager sortPreferenceManager;

  RepositoryListBloc({
    required this.getRepositories,
    required this.networkInfo,
    required this.sortPreferenceManager,
  }) : super(RepositoryListInitial()) {
    on<LoadRepositories>(_onLoadRepositories);
    on<LoadRepositoriesWithSavedSort>(_onLoadRepositoriesWithSavedSort);
    on<SortRepositories>(_onSortRepositories);
  }

  Future<void> _onLoadRepositoriesWithSavedSort(
    LoadRepositoriesWithSavedSort event,
    Emitter<RepositoryListState> emit,
  ) async {
    debugPrint('===================>> Loading with saved sort preference');

    // First load the repositories (existing logic)
    await _onLoadRepositories(LoadRepositories(), emit);

    // Then apply saved sort if data loaded successfully
    if (state is RepositoryListLoaded) {
      final savedSort = await sortPreferenceManager.getSortPreference();
      debugPrint('===================>> Applying saved sort: $savedSort');
      add(SortRepositories(savedSort));
    }
  }

  Future<void> _onLoadRepositories(
    LoadRepositories event,
    Emitter<RepositoryListState> emit,
  ) async {
    debugPrint('===================>> Load Repositories START');
    emit(RepositoryListLoading());

    try {
      final result = await getRepositories();

      result.fold(
        (failure) {
          debugPrint('===================>> Error: ${failure.message}');
          emit(RepositoryListError(message: failure.message));
        },
        (repositories) {
          debugPrint(
              '===================>> Loaded ${repositories.length} repos');
          emit(RepositoryListLoaded(repositories));
        },
      );
    } catch (e) {
      debugPrint('===================>> Exception: $e');
      emit(RepositoryListError(message: 'Unexpected error: $e'));
    }
  }

  Future<void> _onSortRepositories(
    SortRepositories event,
    Emitter<RepositoryListState> emit,
  ) async {
    if (state is RepositoryListLoaded) {
      final currentState = state as RepositoryListLoaded;
      final sortedRepos =
          List<RepositoryEntity>.from(currentState.repositories);

      debugPrint('===================>> Sorting by: ${event.sortBy}');

      if (event.sortBy == Constants.sortByStars) {
        sortedRepos.sort((a, b) {
          final aStars = a.stargazersCount ?? 0;
          final bStars = b.stargazersCount ?? 0;
          return bStars.compareTo(aStars);
        });
      }

      /// 🕒 Sort by Updated At
      else if (event.sortBy == Constants.sortByUpdated) {
        sortedRepos.sort((a, b) {
          final aUpdated = DateTime.tryParse(a.updatedAt ?? '') ??
              DateTime.fromMillisecondsSinceEpoch(0);
          final bUpdated = DateTime.tryParse(b.updatedAt ?? '') ??
              DateTime.fromMillisecondsSinceEpoch(0);
          return bUpdated.compareTo(aUpdated);
        });
      }

      await sortPreferenceManager.setSortPreference(event.sortBy);
      debugPrint(
          '===================>> Saved sort preference: ${event.sortBy}');

      emit(RepositoryListLoaded(
        sortedRepos,
        currentSort: event.sortBy,
      ));
    }
  }
}
