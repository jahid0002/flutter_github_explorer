import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:flutter_github_explorer/core/error/exceptions.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/repository_model.dart';

abstract class RepositoryLocalDatasource {
  Future<void> cacheRepositories(List<RepositoryModel> repositories);
  Future<List<RepositoryModel>> getRepositories();
  Future<bool> hasRepositories();
}

class RepositoryLocalDatasourceImpl implements RepositoryLocalDatasource {
  final SharedPreferences sharedPreferences;

  static const String _cachedRepoKey = 'CACHED_REPOSITORIES';

  RepositoryLocalDatasourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheRepositories(List<RepositoryModel> repositories) async {
    debugPrint('====================>> Caching repositories locally');
    try {
      final jsonList =
          repositories.map((repo) => jsonEncode(repo.toJson())).toList();

      debugPrint('====================>> JSON List: $jsonList');

      final success = await sharedPreferences.setStringList(
        _cachedRepoKey,
        jsonList,
      );

      if (!success) {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<RepositoryModel>> getRepositories() async {
    final jsonList = sharedPreferences.getStringList(_cachedRepoKey);

    if (jsonList == null || jsonList.isEmpty) {
      throw CacheException();
    }

    List<RepositoryModel> result = jsonList
        .map((jsonString) => RepositoryModel.fromJson(jsonDecode(jsonString)))
        .toList();
    debugPrint('====================>> Retrieved $result cached repositories');
    return result;
  }

  @override
  Future<bool> hasRepositories() async {
    debugPrint('====================>> Checking local cached repositories');
    final jsonList = sharedPreferences.getStringList(_cachedRepoKey);
    return jsonList != null && jsonList.isNotEmpty;
  }
}
