import 'dart:convert';

import 'package:flutter/rendering.dart';
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
// import 'dart:convert';

// import 'package:flutter/widgets.dart';
// import 'package:flutter_github_explorer/core/error/exceptions.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../models/repository_model.dart';

// abstract class RepositoryLocalDatasource {
//   /// Save or update repository list in local storage
//   Future<void> cacheRepositories(List<RepositoryModel> repositories);

//   /// Get repository list from local storage
//   Future<List<RepositoryModel>> getRepositories();

//   /// Check if local data exists
//   Future<bool> hasRepositories();

//   /// Clear cached data
//   Future<void> clearCache();
// }

// class RepositoryLocalDatasourceImpl implements RepositoryLocalDatasource {
//   final SharedPreferences sharedPreferences;

//   static const String _cachedRepoKey = 'CACHED_REPOSITORIES';

//   RepositoryLocalDatasourceImpl(this.sharedPreferences);

//   @override
//   Future<void> cacheRepositories(List<RepositoryModel> repositories) async {
//     debugPrint(
//         '====================>> Caching ${repositories.length} repositories');

//     try {
//       // Convert entire list to a single JSON string
//       final jsonString = jsonEncode(
//         repositories.map((repo) => repo.toJson()).toList(),
//       );

//       debugPrint(
//           '====================>> Cache size: ${jsonString.length} chars');

//       final success = await sharedPreferences.setString(
//         _cachedRepoKey,
//         jsonString,
//       );

//       if (success) {
//         debugPrint('====================>> ✅ Cache saved successfully');
//       } else {
//         debugPrint('====================>> ❌ Cache save failed');
//         throw CacheException();
//       }
//     } catch (e) {
//       debugPrint('====================>> ❌ Cache exception: $e');
//       throw CacheException();
//     }
//   }

//   @override
//   Future<List<RepositoryModel>> getRepositories() async {
//     debugPrint('====================>> Reading from cache...');

//     try {
//       // First try to get as String (new format)
//       String? jsonString = sharedPreferences.getString(_cachedRepoKey);

//       // If not found, try old format (List<String>)
//       if (jsonString == null) {
//         debugPrint(
//             '====================>> String format not found, checking old format...');
//         final oldFormatList = sharedPreferences.getStringList(_cachedRepoKey);

//         if (oldFormatList != null && oldFormatList.isNotEmpty) {
//           debugPrint(
//               '====================>> 🔄 Found old format! Converting ${oldFormatList.length} items...');

//           // Convert old format to new format
//           final repositories = oldFormatList
//               .map((jsonStr) => RepositoryModel.fromJson(jsonDecode(jsonStr)))
//               .toList();

//           // Save in new format for next time
//           jsonString = jsonEncode(
//             repositories.map((repo) => repo.toJson()).toList(),
//           );
//           await sharedPreferences.setString(_cachedRepoKey, jsonString);

//           debugPrint(
//               '====================>> ✅ Migration successful! Returning ${repositories.length} repos');
//           return repositories;
//         }
//       }

//       if (jsonString == null || jsonString.isEmpty) {
//         debugPrint('====================>> ❌ No cached data found');
//         throw CacheException();
//       }

//       debugPrint(
//           '====================>> Found cache: ${jsonString.length} chars');

//       final List<dynamic> jsonList = jsonDecode(jsonString);

//       final repositories = jsonList
//           .map((json) => RepositoryModel.fromJson(json as Map<String, dynamic>))
//           .toList();

//       debugPrint(
//           '====================>> ✅ Retrieved ${repositories.length} cached repositories');

//       return repositories;
//     } catch (e) {
//       debugPrint('====================>> ❌ Error reading cache: $e');
//       throw CacheException();
//     }
//   }

//   @override
//   Future<bool> hasRepositories() async {
//     try {
//       // Check new format (String)
//       final jsonString = sharedPreferences.getString(_cachedRepoKey);
//       if (jsonString != null && jsonString.isNotEmpty) {
//         debugPrint('====================>> ✅ Cache exists (new format)');
//         return true;
//       }

//       // Check old format (List<String>)
//       final oldFormatList = sharedPreferences.getStringList(_cachedRepoKey);
//       if (oldFormatList != null && oldFormatList.isNotEmpty) {
//         debugPrint(
//             '====================>> ✅ Cache exists (old format - will auto-migrate)');
//         return true;
//       }

//       debugPrint('====================>> ❌ No cache found');
//       return false;
//     } catch (e) {
//       debugPrint('====================>> ❌ Error checking cache: $e');
//       return false;
//     }
//   }

//   @override
//   Future<void> clearCache() async {
//     debugPrint('====================>> Clearing cache...');

//     try {
//       final success = await sharedPreferences.remove(_cachedRepoKey);

//       if (success) {
//         debugPrint('====================>> ✅ Cache cleared');
//       } else {
//         debugPrint('====================>> ❌ Failed to clear cache');
//       }
//     } catch (e) {
//       debugPrint('====================>> ❌ Error clearing cache: $e');
//     }
//   }
// }
