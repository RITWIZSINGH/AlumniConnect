import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF42A5F5);

  // Background Colors
  static const Color background = Colors.white;
  static const Color surfaceLight = Color(0xFFF5F5F5);
  
  // Border & Divider Colors
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFBDBDBD);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFFFFFFF);
  
  // State Colors
  static const Color selected = Color(0xFFE3F2FD);
  static const Color hover = Color(0xFFBBDEFB);
  
  // Shadow Colors
  static Color shadowLight = Colors.black.withValues(alpha: .1);
  static Color shadowMedium = Colors.black.withValues(alpha: .15);
}