import 'dart:convert';

import 'package:flutter_github_explorer/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/repository_model.dart';

abstract class RepositoryLocalDatasource {
  /// Save or update repository list in local storage
  Future<void> cacheRepositories(List<RepositoryModel> repositories);

  /// Get repository list from local storage
  Future<List<RepositoryModel>> getRepositories();

  /// Check if local data exists
  Future<bool> hasRepositories();
}

class RepositoryLocalDatasourceImpl implements RepositoryLocalDatasource {
  final SharedPreferences sharedPreferences;

  static const String _cachedRepoKey = 'CACHED_REPOSITORIES';

  RepositoryLocalDatasourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheRepositories(List<RepositoryModel> repositories) async {
    try {
      final jsonList =
          repositories.map((repo) => jsonEncode(repo.toJson())).toList();

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

    return jsonList
        .map((jsonString) => RepositoryModel.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  @override
  Future<bool> hasRepositories() async {
    final jsonList = sharedPreferences.getStringList(_cachedRepoKey);
    return jsonList != null && jsonList.isNotEmpty;
  }
}
