import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_explorer/core/utils/constants.dart';
import 'package:flutter_github_explorer/features/theme/bloc/theme_event.dart';
import 'package:flutter_github_explorer/features/theme/bloc/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences preferences;
  ThemeBloc({required this.preferences}) : super(const ThemeInitial()) {
    on<LoadTheme>((_loadTheme));
    on<ToggleTheme>((_toggleTheme));
  }

  Future<void> _loadTheme(
    LoadTheme event,
    Emitter<ThemeState> emit,
  ) async {
    // emit(const ThemeInitial());
    debugPrint('===================>> Load Theme');
    bool? isDarkMode = preferences.getBool(Constants.theme);

    if (isDarkMode != null) {
      emit(ThemeLoaded(isDarkMode: isDarkMode));
    } else {
      await preferences.setBool(Constants.theme, false);
      emit(const ThemeLoaded(isDarkMode: false));
    }

    debugPrint('===================>> isDarkMode: $isDarkMode');
  }

  Future<void> _toggleTheme(
    ToggleTheme event,
    Emitter<ThemeState> emit,
  ) async {
    debugPrint('===================>> Toggle Theme');
    if (state is ThemeLoaded) {
      final currentState = state as ThemeLoaded;
      final newIsDarkMode = !currentState.isDarkMode;
      debugPrint('===================>> New isDarkMode: $newIsDarkMode');
      await preferences.setBool(Constants.theme, newIsDarkMode);
      emit(ThemeLoaded(isDarkMode: newIsDarkMode));
    }
    // Implement toggling theme logic here
  }
}
