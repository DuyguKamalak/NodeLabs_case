import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

enum NavItem {
  home,
  profile,
}

class CustomBottomNavBar extends StatelessWidget {
  final NavItem currentIndex;
  final Function(NavItem) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppColors.navBarBackground,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            NavItem.home,
            'Ana Sayfa',
            'assets/icons/Active=Home.svg',
            'assets/icons/Components/Home.svg',
          ),
          _buildNavItem(
            context,
            NavItem.profile,
            'Profil',
            'assets/icons/Active=Profile.svg',
            'assets/icons/Components/Profile.svg',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    NavItem item,
    String label,
    String activeIconPath,
    String inactiveIconPath,
  ) {
    final isActive = currentIndex == item;

    return GestureDetector(
      onTap: () => onTap(item),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 8.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: SvgPicture.asset(
                isActive ? activeIconPath : inactiveIconPath,
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  isActive ? AppColors.navBarActive : AppColors.navBarInactive,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: isActive
                    ? AppColors.navBarActive
                    : AppColors.navBarInactive,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
