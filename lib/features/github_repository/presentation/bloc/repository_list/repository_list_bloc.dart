import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_explorer/core/network/network_info.dart';
import 'package:flutter_github_explorer/core/utils/constants.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/entities/repository.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/usecases/get_repositories.dart';
import 'repository_list_event.dart';
import 'repository_list_state.dart';

class RepositoryListBloc
    extends Bloc<RepositoryListEvent, RepositoryListState> {
  final GetRepositories getRepositories;
  final NetworkInfo networkInfo;

  RepositoryListBloc({
    required this.getRepositories,
    required this.networkInfo,
  }) : super(RepositoryListInitial()) {
    on<LoadRepositories>(_onLoadRepositories);
    on<SortRepositories>(_onSortRepositories);
  }

  Future<void> _onLoadRepositories(
      LoadRepositories event, Emitter<RepositoryListState> emit) async {
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

  void _onSortRepositories(
      SortRepositories event, Emitter<RepositoryListState> emit) {
    if (state is RepositoryListLoaded) {
      final currentState = state as RepositoryListLoaded;
      final sortedRepos =
          List<RepositoryEntity>.from(currentState.repositories);

      if (event.sortBy == Constants.sortByStars) {
        sortedRepos.sort((a, b) => b.stars.compareTo(a.stars));
      } else if (event.sortBy == Constants.sortByForks) {
        sortedRepos.sort((a, b) => b.forks.compareTo(a.forks));
      }

      emit(RepositoryListLoaded(sortedRepos));
    }
  }
}
