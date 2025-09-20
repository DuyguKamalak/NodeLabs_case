import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    // Get screen width and calculate responsive dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    const designWidth = 402.0;
    final scaleFactor = screenWidth / designWidth;
    final navHeight = (100 * scaleFactor).clamp(80.0, 120.0);

    return Container(
      width: screenWidth,
      height: navHeight, // Responsive height based on 402x100 design
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.20],
          colors: [
            Color.fromRGBO(9, 9, 9, 0), // rgba(9, 9, 9, 0) 0%
            Color(0xFF090909), // #090909 20%
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          bottom: MediaQuery.of(context).padding.bottom + 20.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNavItem(
              context,
              NavItem.home,
              'Anasayfa',
              'assets/icons/icon/Component/Components/Home-fill.svg',
              'assets/icons/icon/Component/Components/Home.svg',
            ),
            _buildNavItem(
              context,
              NavItem.profile,
              'Profil',
              'assets/icons/icon/Component/Components/Profile-fill.svg',
              'assets/icons/icon/Component/Components/Profile.svg',
            ),
          ],
        ),
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
    final screenWidth = MediaQuery.of(context).size.width;
    const designWidth = 402.0;
    final scaleFactor = screenWidth / designWidth;

    // Calculate responsive button dimensions
    final buttonWidth = (169 * scaleFactor).clamp(140.0, 190.0);
    final buttonHeight = (48 * scaleFactor).clamp(40.0, 56.0);

    return GestureDetector(
      onTap: () => onTap(item),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: buttonWidth, // Responsive width
        height: buttonHeight, // Responsive height
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          gradient: isActive
              ? const RadialGradient(
                  center: Alignment(0.0, -0.67), // 50% 16.67% pozisyonu
                  radius: 0.83, // 83.33% radius
                  colors: [
                    Color(0xFFE50914), // #E50914 0%
                    Color(0xFF7F050B), // #7F050B 100%
                  ],
                )
              : null,
          color: isActive ? null : Colors.transparent,
          border: isActive
              ? null
              : Border.all(
                  color: const Color(0x33FFFFFF), // #FFFFFF33 (20% opacity)
                  width: 1.w,
                ),
          borderRadius: BorderRadius.circular(42.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isActive ? activeIconPath : inactiveIconPath,
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(
                isActive
                    ? Colors.white
                    : const Color(0xFFFFFFFF).withOpacity(0.6),
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 10.w), // 10px gap
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: isActive
                      ? Colors.white
                      : const Color(0xFFFFFFFF).withOpacity(0.6),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
