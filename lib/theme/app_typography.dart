import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  // Drawer Header Styles
  static const TextStyle drawerHeaderTitle = TextStyle(
    color: AppColors.textLight,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );

  static const TextStyle drawerHeaderSubtitle = TextStyle(
    color: Colors.white70,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
  );

  // Section Title Styles
  static const TextStyle sectionTitle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    fontSize: 16,
    letterSpacing: 0.15,
  );

  // List Item Styles
  static const TextStyle listItem = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );

  // Button Text Style
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
    letterSpacing: 0.5,
  );
}