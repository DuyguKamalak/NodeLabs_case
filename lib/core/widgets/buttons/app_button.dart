import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// Modern ve temiz tasarımlı button widget'ı
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final Widget? icon;
  final bool isLoading;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 56.h,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    switch (type) {
      case AppButtonType.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            disabledBackgroundColor: AppColors.buttonDisabled,
            disabledForegroundColor: AppColors.textDisabled,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 16.h,
            ),
          ),
          child: _buildButtonContent(),
        );

      case AppButtonType.secondary:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.white,
            disabledForegroundColor: AppColors.textDisabled,
            side: const BorderSide(
              color: AppColors.border,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 16.h,
            ),
          ),
          child: _buildButtonContent(),
        );

      case AppButtonType.tertiary:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.white,
            disabledForegroundColor: AppColors.textDisabled,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 16.h,
            ),
          ),
          child: _buildButtonContent(),
        );
    }
  }

  Widget _buildButtonContent() {
    return Builder(
      builder: (context) {
        if (isLoading) {
          return SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                type == AppButtonType.primary
                    ? AppColors.white
                    : AppColors.primary,
              ),
            ),
          );
        }

        if (icon != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              icon!,
              SizedBox(width: 8.w),
              Text(
                text,
                style: AppTextStyles.buttonLarge(context).copyWith(
                  color: _getTextColor(),
                ),
              ),
            ],
          );
        }

        return Text(
          text,
          style: AppTextStyles.buttonLarge(context).copyWith(
            color: _getTextColor(),
          ),
        );
      },
    );
  }

  Color _getTextColor() {
    if (isLoading) return AppColors.textDisabled;

    switch (type) {
      case AppButtonType.primary:
        return AppColors.white;
      case AppButtonType.secondary:
      case AppButtonType.tertiary:
        return AppColors.white;
    }
  }
}

enum AppButtonType {
  primary,
  secondary,
  tertiary,
}
