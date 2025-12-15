import 'package:equatable/equatable.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/entities/repository.dart';

abstract class RepositoryListState extends Equatable {
  const RepositoryListState();

  @override
  List<Object> get props => [];
}

class RepositoryListInitial extends RepositoryListState {}

class RepositoryListLoading extends RepositoryListState {}

class RepositoryListLoaded extends RepositoryListState {
  final List<RepositoryEntity> repositories;

  const RepositoryListLoaded(this.repositories);

  @override
  List<Object> get props => [repositories];
}

class RepositoryListError extends RepositoryListState {
  final String message;

  const RepositoryListError({required this.message});

  @override
  List<Object> get props => [message];
}
