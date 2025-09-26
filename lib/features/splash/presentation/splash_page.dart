import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_paddings.dart';

class SplashPage extends StatelessWidget {
  static const String routePath = '/';
  static const String routeName = 'splash';

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background linear gradient
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
          ),
          // Top shine blur
          Positioned(
            top: -120.h,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 340.w,
                height: 340.w,
                child: ClipOval(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: 50.6,
                      sigmaY: 50.6,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: 0.9,
                          colors: [
                            AppColors.brightRed.withOpacity(0.8),
                            AppColors.brightRed.withOpacity(0.4),
                            AppColors.darkRed.withOpacity(0.0),
                          ],
                          stops: const [0.0, 0.25, 1.0],
                          tileMode: TileMode.clamp,
                        ),
                      ),
                      foregroundDecoration: const BoxDecoration(
                        color: AppColors.white5Opacity,
                        backgroundBlendMode: BlendMode.softLight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Center logo and text
          Align(
            alignment: Alignment(0, 0.08.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/Icon.svg',
                  width: 78.w,
                  height: 78.w,
                ),
                SizedBox(height: AppPaddings.md.h),
                Text(
                  AppStrings.appName,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h6(context).copyWith(
                    fontSize: 33.32.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    letterSpacing: 0,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
