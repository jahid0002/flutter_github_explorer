import 'package:equatable/equatable.dart';

abstract class RepositoryListEvent extends Equatable {
  const RepositoryListEvent();

  @override
  List<Object> get props => [];
}

// class GetAllRepositoryEvent extends RepositoryListEvent {
//   final List<RepositoryModel> repositories;

//   const GetAllRepositoryEvent(this.repositories);

//   @override
//   List<Object> get props => [repositories];
// }

class LoadRepositories extends RepositoryListEvent {}

class RefreshRepositories extends RepositoryListEvent {}

class SortRepositories extends RepositoryListEvent {
  final String sortBy;

  const SortRepositories(this.sortBy);

  @override
  List<Object> get props => [sortBy];
}
