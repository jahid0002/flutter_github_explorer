// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_github_explorer/features/github_repository/domain/usecases/get_repositories.dart';
// import 'package:flutter_github_explorer/features/github_repository/presentation/bloc/repository_list/repository_list_event.dart';
// import 'package:flutter_github_explorer/features/github_repository/presentation/bloc/repository_list/repository_list_state.dart';

// class RepositoryListBloc
//     extends Bloc<RepositoryListEvent, RepositoryListState> {
//   final GetRepositories getRepositories;

//   RepositoryListBloc({required this.getRepositories})
//       : super(RepositoryListInitial()) {
//     on<LoadRepositories>((event, emit) async {
//       debugPrint('===================>> Load Repositories in bloc 00');
//       emit(RepositoryListLoading());
//       debugPrint('===================>> Load Repositories in bloc 11111');
//       final failureOrRepositories = await getRepositories();
//       debugPrint('===================>> Load Repositories in bloc 222');
//       failureOrRepositories.fold(
//         (failure) => emit(RepositoryListError(message: failure.message)),
//         (repositories) => emit(RepositoryListLoaded(repositories)),
//       );
//     });
//   }
// }
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_explorer/core/network/network_info.dart';
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
  }

  // Main handler for LoadRepositories event
  Future<void> _onLoadRepositories(
      LoadRepositories event, Emitter<RepositoryListState> emit) async {
    debugPrint('===================>> Load Repositories in bloc START');
    emit(RepositoryListLoading());

    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      // Network available, try fetching from remote
      final result = await getRepositories();

      await result.fold(
        (failure) async {
          // If remote fails, try local fallback
          final localData = await _getRepositoriesLocalFallback();
          if (localData.isNotEmpty) {
            emit(RepositoryListLoaded(localData));
          } else {
            emit(RepositoryListError(message: failure.message));
          }
        },
        (repositories) async {
          emit(RepositoryListLoaded(repositories));
        },
      );
    } else {
      // No network, always fallback to local
      final localData = await _getRepositoriesLocalFallback();
      if (localData.isNotEmpty) {
        emit(RepositoryListLoaded(localData));
      } else {
        emit(const RepositoryListError(
            message: 'No internet connection and no local data.'));
      }
    }

    debugPrint('===================>> Load Repositories in bloc END');
  }

  // Helper: get local repositories safely
  Future<List<RepositoryEntity>> _getRepositoriesLocalFallback() async {
    try {
      final result = await getRepositories();
      return result.fold(
        (_) => [],
        (repositories) => repositories,
      );
    } catch (_) {
      return [];
    }
  }
}
