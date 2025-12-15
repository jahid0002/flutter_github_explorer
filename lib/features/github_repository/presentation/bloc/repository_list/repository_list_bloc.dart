import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/usecases/get_repositories.dart';
import 'package:flutter_github_explorer/features/github_repository/presentation/bloc/repository_list/repository_list_event.dart';
import 'package:flutter_github_explorer/features/github_repository/presentation/bloc/repository_list/repository_list_state.dart';

class RepositoryListBloc
    extends Bloc<RepositoryListEvent, RepositoryListState> {
  final GetRepositories getRepositories;

  RepositoryListBloc({required this.getRepositories})
      : super(RepositoryListInitial()) {
    on<LoadRepositories>((event, emit) async {
      emit(RepositoryListLoading());
      final failureOrRepositories = await getRepositories();
      debugPrint('===================>> Load Repositories in bloc');
      failureOrRepositories.fold(
        (failure) => emit(RepositoryListError(message: failure.message)),
        (repositories) => emit(RepositoryListLoaded(repositories)),
      );
    });
  }
}
