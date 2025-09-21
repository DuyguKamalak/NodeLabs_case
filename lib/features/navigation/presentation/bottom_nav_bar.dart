import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/responsive_utils.dart';

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
    return ResponsiveUtils.responsiveBuilder(
      builder: (context, deviceType) {
        final navHeight = ResponsiveUtils.getBottomNavHeight(context);
        final horizontalPadding = ResponsiveUtils.getPagePadding(context);
        final bottomPadding = MediaQuery.of(context).padding.bottom;
        final isDesktop = ResponsiveUtils.isDesktop(context);

        return Container(
          width: double.infinity,
          height: navHeight + bottomPadding + (isDesktop ? 0 : 20.h),
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
          child: ResponsiveUtils.constrainedContainer(
            context: context,
            child: Padding(
              padding: EdgeInsets.only(
                left: horizontalPadding.left,
                right: horizontalPadding.right,
                top: 0,
                bottom: bottomPadding + (isDesktop ? 0 : 0),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _buildNavContent(context, deviceType),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavContent(
      BuildContext context, ResponsiveDeviceType deviceType) {
    final isDesktop = ResponsiveUtils.isDesktop(context);

    if (isDesktop) {
      // Desktop: Show as a horizontal row with more spacing
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavItem(
            context,
            NavItem.home,
            'Anasayfa',
            'assets/icons/icon/Component/Components/Home-fill.svg',
            'assets/icons/icon/Component/Components/Home.svg',
          ),
          SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context, 32)),
          _buildNavItem(
            context,
            NavItem.profile,
            'Profil',
            'assets/icons/icon/Component/Components/Profile-fill.svg',
            'assets/icons/icon/Component/Components/Profile.svg',
          ),
        ],
      );
    } else {
      // Mobile and tablet: Centered layout with equal spacing
      return Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNavItem(
              context,
              NavItem.home,
              'Anasayfa',
              'assets/icons/icon/Component/Components/Home-fill.svg',
              'assets/icons/icon/Component/Components/Home.svg',
            ),
            SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context, 24)),
            _buildNavItem(
              context,
              NavItem.profile,
              'Profil',
              'assets/icons/icon/Component/Components/Profile-fill.svg',
              'assets/icons/icon/Component/Components/Profile.svg',
            ),
          ],
        ),
      );
    }
  }

  Widget _buildNavItem(
    BuildContext context,
    NavItem item,
    String label,
    String activeIconPath,
    String inactiveIconPath,
  ) {
    final isActive = currentIndex == item;
    final deviceType = ResponsiveUtils.getDeviceType(context);

    // Responsive dimensions
    final buttonHeight = ResponsiveUtils.isMobile(context) ? 48.h : 56.h;
    final horizontalPadding = ResponsiveUtils.getResponsiveSpacing(context, 16);
    final verticalPadding = ResponsiveUtils.getResponsiveSpacing(context, 12);
    final iconSize = ResponsiveUtils.getResponsiveIconSize(context, 24);
    final fontSize = ResponsiveUtils.getResponsiveFontSize(context, 14);
    final borderRadius = ResponsiveUtils.getResponsiveBorderRadius(context, 42);
    final iconTextSpacing = ResponsiveUtils.getResponsiveSpacing(context, 10);

    // Responsive button width based on device type
    final buttonWidth = switch (deviceType) {
      ResponsiveDeviceType.mobile => 140.w,
      ResponsiveDeviceType.tablet => 160.w,
      ResponsiveDeviceType.desktop ||
      ResponsiveDeviceType.largeDesktop =>
        180.w,
    };

    return GestureDetector(
      onTap: () => onTap(item),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: buttonWidth,
        height: buttonHeight,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          gradient: isActive
              ? const RadialGradient(
                  center: Alignment(0.0, -0.67), // 50% 16.67% position
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
                  width: ResponsiveUtils.isMobile(context) ? 1.w : 1.5.w,
                ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isActive ? activeIconPath : inactiveIconPath,
              width: iconSize,
              height: iconSize,
              colorFilter: ColorFilter.mode(
                isActive
                    ? Colors.white
                    : const Color(0xFFFFFFFF).withOpacity(0.6),
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: iconTextSpacing),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize,
                  color: isActive
                      ? Colors.white
                      : const Color(0xFFFFFFFF).withOpacity(0.6),
                  height: 1.2,
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
