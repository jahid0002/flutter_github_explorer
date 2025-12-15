import 'package:dartz/dartz.dart';
import 'package:flutter_github_explorer/core/error/failures.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/entities/repository.dart';

abstract class RepositoryRepository {
  Future<Either<Failure, List<RepositoryEntity>>> getRepositories();
}
