import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_github_explorer/core/error/failures.dart';
import 'package:flutter_github_explorer/core/network/network_info.dart';
import 'package:flutter_github_explorer/features/github_repository/data/datasources/repository_local_datasource.dart';
import 'package:flutter_github_explorer/features/github_repository/data/datasources/repository_remote_datasource.dart';
import 'package:flutter_github_explorer/features/github_repository/data/models/repository_model.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/entities/repository.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/repositories/repository_repository.dart';

class RepositoryRepositoryImpl implements RepositoryRepository {
  final RepositoryRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;
  final RepositoryLocalDatasource localDatasource;

  RepositoryRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, List<RepositoryEntity>>> getRepositories() async {
    debugPrint('===================>> Repository Repository Impl');

    if (await networkInfo.isConnected) {
      final remoteResult = await remoteDatasource.fetchRepositories();

      return await remoteResult.fold(
        (failure) async {
          if (await localDatasource.hasRepositories()) {
            final localData = await localDatasource.getRepositories();
            return Right(localData);
          }
          return Left(failure);
        },
        (remoteData) async {
          await localDatasource
              .cacheRepositories(remoteData as List<RepositoryModel>);
          return Right(remoteData);
        },
      );
    } else {
      if (await localDatasource.hasRepositories()) {
        final localData = await localDatasource.getRepositories();
        return Right(localData);
      }
      return const Left(NetworkFailure());
    }
  }
  // @override
  // Future<Either<Failure, List<RepositoryEntity>>> getRepositories() async {
  //   debugPrint('===================>> Repository Repository Impl');

  //   if (await networkInfo.isConnected) {
  //     final remoteResult = await remoteDatasource.fetchRepositories();
  //     debugPrint('===================>> Get Remote Data');
  //     await localDatasource.cacheRepositories(remoteResult.fold(
  //         (l) => Left(l),
  //         (repositories) => Right(
  //             repositories.map((repo) => repo as RepositoryModel).toList())));

  //     return remoteResult;
  //   } else {
  //     if (await localDatasource.hasRepositories() == false) {
  //       debugPrint('No local data available');
  //       return const Left(NoDataFailure());
  //     }
  //     final localResult = await localDatasource.getRepositories();
  //     debugPrint(
  //         'Returning local data with ${localResult.length} repositories');
  //     return Right(localResult);
  //   }
  // }
  // Implementation details...
}
