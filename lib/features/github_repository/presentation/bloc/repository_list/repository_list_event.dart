import 'package:equatable/equatable.dart';

abstract class RepositoryListEvent extends Equatable {
  const RepositoryListEvent();

  @override
  List<Object> get props => [];
}

class LoadRepositories extends RepositoryListEvent {
  const LoadRepositories();

  @override
  List<Object> get props => [];
}

class RefreshRepositories extends RepositoryListEvent {}

class SortRepositories extends RepositoryListEvent {
  final String sortBy;

  const SortRepositories(this.sortBy);

  @override
  List<Object> get props => [sortBy];
}

class LoadRepositoriesWithSavedSort extends RepositoryListEvent {}
