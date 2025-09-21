import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import '../utils/responsive_utils.dart';

/// Uygulama tipografi stilleri - Instrument Sans
class AppTextStyles {
  AppTextStyles._();

  // Base Font Family
  static String get fontFamily => GoogleFonts.instrumentSans().fontFamily!;

  // Responsive Heading Styles
  static TextStyle h1(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 48),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle h2(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 40),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle h3(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 32),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle h4(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 24),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle h5(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 20),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle h6(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.2,
      );

  // Responsive Body XLarge Styles
  static TextStyle bodyXLargeBold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodyXLargeSemibold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodyXLargeMedium(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodyXLarge(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // Responsive Body Large Styles
  static TextStyle bodyLargeBold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodyLargeSemibold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodyLargeMedium(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodyLarge(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // Responsive Body Normal/Medium Styles
  static TextStyle bodyMediumBold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodyMediumSemibold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodyMediumMedium(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodyMedium(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // Responsive Body Small Styles
  static TextStyle bodySmallBold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodySmallSemibold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodySmallMedium(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodySmall(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // Responsive Body XSmall Styles
  static TextStyle bodyXSmallBold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 10),
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodyXSmallSemibold(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 10),
        fontWeight: FontWeight.w600, // Semibold
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodyXSmallMedium(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 10),
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle bodyXSmall(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 10),
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // Legacy styles for backward compatibility - now require context
  static TextStyle body(BuildContext context) => bodyMedium(context);
  static TextStyle caption(BuildContext context) => bodyXSmall(context);

  // Responsive Button Styles
  static TextStyle buttonLarge(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.2,
      );

  static TextStyle buttonMedium(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.2,
      );

  static TextStyle buttonSmall(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.2,
      );

  // Responsive Link Styles
  static TextStyle link(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
        height: 1.2,
        decoration: TextDecoration.underline,
      );

  // Responsive Message Styles
  static TextStyle error(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
        fontWeight: FontWeight.w400,
        color: AppColors.error,
        height: 1.2,
      );

  static TextStyle success(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
        fontWeight: FontWeight.w400,
        color: AppColors.success,
        height: 1.2,
      );

  static TextStyle warning(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
        fontWeight: FontWeight.w400,
        color: AppColors.warning,
        height: 1.2,
      );

  static TextStyle info(BuildContext context) => GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
        fontWeight: FontWeight.w400,
        color: AppColors.info,
        height: 1.2,
      );

  // Responsive Label Styles
  static TextStyle labelLarge(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle labelMedium(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle labelSmall(BuildContext context) =>
      GoogleFonts.instrumentSans(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 10),
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.2,
      );
}
