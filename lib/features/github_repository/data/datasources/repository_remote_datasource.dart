// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_github_explorer/core/error/failures.dart';
import 'package:flutter_github_explorer/core/utils/constants.dart';
import 'package:flutter_github_explorer/features/github_repository/data/models/repository_model.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/entities/repository.dart';
import 'package:http/http.dart' as http;

abstract class RepositoryRemoteDatasource {
  Future<Either<Failure, List<RepositoryEntity>>> fetchRepositories();
}

class RepositoryRemoteDatasourceImpl implements RepositoryRemoteDatasource {
  final http.Client client;

  RepositoryRemoteDatasourceImpl(this.client);

  @override
  Future<Either<Failure, List<RepositoryEntity>>> fetchRepositories() async {
    final url = Uri.parse(
      Constants.baseUrl + Constants.searchRepositoriesEndpoint,
    );

    try {
      final response = await client.get(
        url,
        headers: {
          'Accept': 'application/vnd.github+json',
        },
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body) as Map<String, dynamic>;
        final List items = decoded['items'];

        final repositories = items
            .map(
              (json) => RepositoryModel.fromJson(json),
            )
            .toList();

        return Right(repositories);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
