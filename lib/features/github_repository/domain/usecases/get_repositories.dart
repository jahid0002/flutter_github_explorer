import 'package:dartz/dartz.dart';
import 'package:flutter_github_explorer/core/error/failures.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/entities/repository.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/repositories/repository_repository.dart';

class GetRepositories {
  final RepositoryRepository repository;

  const GetRepositories(this.repository);

  Future<Either<Failure, List<RepositoryEntity>>> call() async {
    return await repository.getRepositories();
  }
}
