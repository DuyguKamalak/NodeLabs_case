import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import '../utils/responsive_utils.dart';

/// NodeLabs Case - Typography System
/// Instrument Sans font family with complete weight and size variations
/// Based on provided design system specifications
class AppTextStyles {
  AppTextStyles._();

  // 📝 BASE FONT FAMILY
  /// Primary font family: Instrument Sans
  static String get fontFamily => GoogleFonts.instrumentSans().fontFamily!;

  // 📖 HEADING STYLES

  /// Heading 1 - Bold / 48px
  static TextStyle h1(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 48),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
        letterSpacing: 0,
      );

  /// Heading 2 - Bold / 40px
  static TextStyle h2(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 40),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
        letterSpacing: 0,
      );

  /// Heading 3 - Bold / 32px
  static TextStyle h3(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 32),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
        letterSpacing: 0,
      );

  /// Heading 4 - Bold / 24px
  static TextStyle h4(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 24),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
        letterSpacing: 0,
      );

  /// Heading 5 - Bold / 20px
  static TextStyle h5(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 20),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
        letterSpacing: 0,
      );

  /// Heading 6 - Bold / 18px
  static TextStyle h6(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
        letterSpacing: 0,
      );

  // 📄 BODY XLARGE STYLES (18px)

  /// Body XLarge - Bold / 18px
  static TextStyle bodyXLargeBold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body XLarge - Semibold / 18px
  static TextStyle bodyXLargeSemibold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body XLarge - Medium / 18px
  static TextStyle bodyXLargeMedium(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body XLarge - Regular / 18px
  static TextStyle bodyXLarge(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  // 📄 BODY LARGE STYLES (16px)

  /// Body Large - Bold / 16px
  static TextStyle bodyLargeBold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body Large - Semibold / 16px
  static TextStyle bodyLargeSemibold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body Large - Medium / 16px
  static TextStyle bodyLargeMedium(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body Large - Regular / 16px
  static TextStyle bodyLarge(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  // 📄 BODY MEDIUM STYLES (14px)

  /// Body Medium - Bold / 14px
  static TextStyle bodyMediumBold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body Medium - Semibold / 14px
  static TextStyle bodyMediumSemibold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body Medium - Medium / 14px
  static TextStyle bodyMediumMedium(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body Medium - Regular / 14px
  static TextStyle bodyMedium(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  // 📄 BODY SMALL STYLES (12px)

  /// Body Small - Bold / 12px
  static TextStyle bodySmallBold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body Small - Semibold / 12px
  static TextStyle bodySmallSemibold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body Small - Medium / 12px
  static TextStyle bodySmallMedium(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body Small - Regular / 12px
  static TextStyle bodySmall(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  // 📄 BODY XSMALL STYLES (10px)

  /// Body XSmall - Bold / 10px
  static TextStyle bodyXSmallBold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 10),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body XSmall - Semibold / 10px
  static TextStyle bodyXSmallSemibold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 10),
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body XSmall - Medium / 10px
  static TextStyle bodyXSmallMedium(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 10),
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  /// Body XSmall - Regular / 10px
  static TextStyle bodyXSmall(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 10),
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
        letterSpacing: 0,
      );

  // 🔗 LEGACY ALIASES (for backward compatibility)
  /// Default body text style (bodyMedium)
  static TextStyle body(BuildContext context) => bodyMedium(context);

  /// Caption text style (bodyXSmall)
  static TextStyle caption(BuildContext context) => bodyXSmall(context);

  // 🔘 SPECIALIZED STYLES

  /// Button text styles
  static TextStyle buttonLarge(BuildContext context) =>
      bodyLargeSemibold(context).copyWith(color: AppColors.white);

  static TextStyle buttonMedium(BuildContext context) =>
      bodyMediumSemibold(context).copyWith(color: AppColors.white);

  static TextStyle buttonSmall(BuildContext context) =>
      bodySmallSemibold(context).copyWith(color: AppColors.white);

  /// Link style with underline
  static TextStyle link(BuildContext context) =>
      bodyMediumMedium(context).copyWith(
        color: AppColors.primary,
        decoration: TextDecoration.underline,
      );

  /// Alert message styles
  static TextStyle error(BuildContext context) => bodySmall(context).copyWith(
        color: AppColors.error,
      );

  static TextStyle success(BuildContext context) => bodySmall(context).copyWith(
        color: AppColors.success,
      );

  static TextStyle warning(BuildContext context) => bodySmall(context).copyWith(
        color: AppColors.warning,
      );

  static TextStyle info(BuildContext context) => bodySmall(context).copyWith(
        color: AppColors.info,
      );

  /// Label styles
  static TextStyle labelLarge(BuildContext context) =>
      bodyMediumMedium(context);

  static TextStyle labelMedium(BuildContext context) =>
      bodySmallMedium(context);

  static TextStyle labelSmall(BuildContext context) =>
      bodyXSmallMedium(context);
}
