import 'package:flutter/material.dart';

class AppColors {
  // Prevent instantiation
  AppColors._();

  // Light Theme Colors
  static const Color primaryLight = Color(0xFF2196F3);
  static const Color secondaryLight = Color(0xFF03A9F4);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color surfaceLight = Colors.white;
  static const Color errorLight = Color(0xFFD32F2F);
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);

  // Dark Theme Colors
  static const Color primaryDark = Color(0xFF90CAF9);
  static const Color secondaryDark = Color(0xFF81D4FA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color errorDark = Color(0xFFEF5350);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  // Common Colors (Both Themes)
  static const Color starColor = Color(0xFFFFC107);
  static const Color forkColor = Color(0xFF4CAF50);
  static const Color languageColor = Color(0xFF2196F3);
  static const Color updateColor = Color(0xFF9E9E9E);

  // Status Colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color infoColor = Color(0xFF2196F3);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF2196F3),
    Color(0xFF1976D2),
  ];

  static const List<Color> darkGradient = [
    Color(0xFF1E1E1E),
    Color(0xFF121212),
  ];
}
