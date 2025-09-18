import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Uygulama tipografi stilleri - Instrument Sans
class AppTextStyles {
  AppTextStyles._();

  // Base Font Family
  static String get fontFamily => GoogleFonts.instrumentSans().fontFamily!;

  // Heading Styles
  static TextStyle get h1 => GoogleFonts.instrumentSans(
        fontSize: 48,
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get h2 => GoogleFonts.instrumentSans(
        fontSize: 40,
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get h3 => GoogleFonts.instrumentSans(
        fontSize: 32,
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get h4 => GoogleFonts.instrumentSans(
        fontSize: 24,
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get h5 => GoogleFonts.instrumentSans(
        fontSize: 20,
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get h6 => GoogleFonts.instrumentSans(
        fontSize: 18,
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
      );

  // Body XLarge Styles
  static TextStyle get bodyXLargeBold => GoogleFonts.instrumentSans(
        fontSize: 18,
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodyXLargeSemibold => GoogleFonts.instrumentSans(
        fontSize: 18,
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodyXLargeMedium => GoogleFonts.instrumentSans(
        fontSize: 18,
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodyXLarge => GoogleFonts.instrumentSans(
        fontSize: 18,
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // Body Large Styles
  static TextStyle get bodyLargeBold => GoogleFonts.instrumentSans(
        fontSize: 16,
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodyLargeSemibold => GoogleFonts.instrumentSans(
        fontSize: 16,
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodyLargeMedium => GoogleFonts.instrumentSans(
        fontSize: 16,
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodyLarge => GoogleFonts.instrumentSans(
        fontSize: 16,
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // Body Normal/Medium Styles
  static TextStyle get bodyMediumBold => GoogleFonts.instrumentSans(
        fontSize: 14,
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodyMediumSemibold => GoogleFonts.instrumentSans(
        fontSize: 14,
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodyMediumMedium => GoogleFonts.instrumentSans(
        fontSize: 14,
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodyMedium => GoogleFonts.instrumentSans(
        fontSize: 14,
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // Body Small Styles
  static TextStyle get bodySmallBold => GoogleFonts.instrumentSans(
        fontSize: 12,
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodySmallSemibold => GoogleFonts.instrumentSans(
        fontSize: 12,
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodySmallMedium => GoogleFonts.instrumentSans(
        fontSize: 12,
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodySmall => GoogleFonts.instrumentSans(
        fontSize: 12,
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // Body XSmall Styles
  static TextStyle get bodyXSmallBold => GoogleFonts.instrumentSans(
        fontSize: 10,
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodyXSmallSemibold => GoogleFonts.instrumentSans(
        fontSize: 10,
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodyXSmallMedium => GoogleFonts.instrumentSans(
        fontSize: 10,
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get bodyXSmall => GoogleFonts.instrumentSans(
        fontSize: 10,
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // Legacy styles for backward compatibility
  static TextStyle get body => bodyMedium;
  static TextStyle get caption => bodyXSmall;

  // Button Styles
  static TextStyle get buttonLarge => GoogleFonts.instrumentSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.2,
      );

  static TextStyle get buttonMedium => GoogleFonts.instrumentSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.2,
      );

  static TextStyle get buttonSmall => GoogleFonts.instrumentSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.2,
      );

  // Link Styles
  static TextStyle get link => GoogleFonts.instrumentSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
        height: 1.2,
        decoration: TextDecoration.underline,
      );

  // Error Styles
  static TextStyle get error => GoogleFonts.instrumentSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.error,
        height: 1.2,
      );

  // Success Styles
  static TextStyle get success => GoogleFonts.instrumentSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.success,
        height: 1.2,
      );

  // Warning Styles
  static TextStyle get warning => GoogleFonts.instrumentSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.warning,
        height: 1.2,
      );

  // Info Styles
  static TextStyle get info => GoogleFonts.instrumentSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.info,
        height: 1.2,
      );

  // Label Styles
  static TextStyle get labelLarge => GoogleFonts.instrumentSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get labelMedium => GoogleFonts.instrumentSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get labelSmall => GoogleFonts.instrumentSans(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.2,
      );
}
