import 'package:dartz/dartz.dart';
import 'package:flutter_github_explorer/core/error/failures.dart';
import 'package:flutter_github_explorer/core/network/network_info.dart';
import 'package:flutter_github_explorer/features/github_repository/data/datasources/repository_remote_datasource.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/entities/repository.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/repositories/repository_repository.dart';

class RepositoryRepositoryImpl implements RepositoryRepository {
  final RepositoryRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  RepositoryRepositoryImpl(
      {required this.remoteDatasource, required this.networkInfo});
  @override
  Future<Either<Failure, List<RepositoryEntity>>> getRepositories() async {
    if (await networkInfo.isConnected) {
      return remoteDatasource.fetchRepositories();
    } else {
      return Future.value(const Left(NetworkFailure()));
    }
  }
  // Implementation details...
}
