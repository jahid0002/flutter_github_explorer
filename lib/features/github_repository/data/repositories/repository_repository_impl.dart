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
  @override
  Future<Either<Failure, List<RepositoryEntity>>> getRepositories() async {
    debugPrint('===================>> Repository Impl: Checking network...');

    try {
      final isConnected = await networkInfo.isConnected;
      debugPrint('===================>> Network connected: $isConnected');

      if (isConnected) {
        // Try remote first
        debugPrint('===================>> Fetching from remote...');
        final remoteResult = await remoteDatasource.fetchRepositories();

        return await remoteResult.fold(
          (failure) async {
            debugPrint(
                '===================>> Remote failed: ${failure.message}');
            debugPrint('===================>> Trying local cache...');

            // Fallback to local
            if (await localDatasource.hasRepositories()) {
              final localData = await localDatasource.getRepositories();
              debugPrint(
                  '===================>> Loaded ${localData.length} from cache');
              return Right(localData);
            }

            debugPrint('===================>> No cache available');
            return Left(failure);
          },
          (remoteData) async {
            debugPrint(
                '===================>> Remote success: ${remoteData.length} repos');
            // Cache the data
            await localDatasource
                .cacheRepositories(remoteData as List<RepositoryModel>);
            debugPrint('===================>> Data cached successfully');
            return Right(remoteData);
          },
        );
      } else {
        // Offline - use cache
        debugPrint('===================>> Offline mode, using cache...');

        if (await localDatasource.hasRepositories()) {
          final localData = await localDatasource.getRepositories();
          debugPrint(
              '===================>> Loaded ${localData.length} from cache');
          return Right(localData);
        }

        debugPrint('===================>> No cache available in offline mode');
        return const Left(NetworkFailure());
      }
    } catch (e) {
      debugPrint('===================>> Exception in repository: $e');
      return const Left(ServerFailure());
    }
  }
}
