// lib/core/preferences/sort_preference_manager.dart

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SortPreferenceManager {
  final SharedPreferences sharedPreferences;

  static const String _sortPreferenceKey = 'SORT_PREFERENCE';
  static const String _defaultSort = 'stars'; // Default to stars

  SortPreferenceManager(this.sharedPreferences);

  /// Get saved sort preference
  Future<String> getSortPreference() async {
    try {
      final sortBy = sharedPreferences.getString(_sortPreferenceKey);
      debugPrint(
          '====================>> Got sort preference: ${sortBy ?? _defaultSort}');
      return sortBy ?? _defaultSort;
    } catch (e) {
      debugPrint('====================>> Error getting sort preference: $e');
      return _defaultSort;
    }
  }

  /// Save sort preference
  Future<void> setSortPreference(String sortBy) async {
    try {
      await sharedPreferences.setString(_sortPreferenceKey, sortBy);
      debugPrint('====================>>  Saved sort preference: $sortBy');
    } catch (e) {
      debugPrint('====================>>  Error saving sort preference: $e');
    }
  }

  /// Clear sort preference (optional)
  Future<void> clearSortPreference() async {
    try {
      await sharedPreferences.remove(_sortPreferenceKey);
      debugPrint('====================>>  Cleared sort preference');
    } catch (e) {
      debugPrint('====================>>  Error clearing sort preference: $e');
    }
  }
}
