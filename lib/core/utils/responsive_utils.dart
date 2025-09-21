import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Cihaz tipleri
enum ResponsiveDeviceType {
  mobile,
  tablet,
  desktop,
  largeDesktop,
}

/// Responsive tasarım için yardımcı sınıf
class ResponsiveUtils {
  ResponsiveUtils._();

  // Breakpoint değerleri
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 900;
  static const double _desktopBreakpoint = 1200;

  /// Cihaz tipini döndürür
  static ResponsiveDeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < _mobileBreakpoint) {
      return ResponsiveDeviceType.mobile;
    } else if (width < _tabletBreakpoint) {
      return ResponsiveDeviceType.tablet;
    } else if (width < _desktopBreakpoint) {
      return ResponsiveDeviceType.desktop;
    } else {
      return ResponsiveDeviceType.largeDesktop;
    }
  }

  /// Mobil cihaz kontrolü
  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == ResponsiveDeviceType.mobile;
  }

  /// Tablet kontrolü
  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == ResponsiveDeviceType.tablet;
  }

  /// Desktop kontrolü
  static bool isDesktop(BuildContext context) {
    final deviceType = getDeviceType(context);
    return deviceType == ResponsiveDeviceType.desktop || 
           deviceType == ResponsiveDeviceType.largeDesktop;
  }

  /// Mobil veya tablet kontrolü
  static bool isMobileOrTablet(BuildContext context) {
    final deviceType = getDeviceType(context);
    return deviceType == ResponsiveDeviceType.mobile || 
           deviceType == ResponsiveDeviceType.tablet;
  }

  /// Ekran genişliğine göre responsive padding
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case ResponsiveDeviceType.mobile:
        return EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h);
      case ResponsiveDeviceType.tablet:
        return EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h);
      case ResponsiveDeviceType.desktop:
        return EdgeInsets.symmetric(horizontal: 48.w, vertical: 24.h);
      case ResponsiveDeviceType.largeDesktop:
        return EdgeInsets.symmetric(horizontal: 64.w, vertical: 32.h);
    }
  }

  /// Sayfa padding'i
  static EdgeInsets getPagePadding(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case ResponsiveDeviceType.mobile:
        return EdgeInsets.symmetric(horizontal: 20.w);
      case ResponsiveDeviceType.tablet:
        return EdgeInsets.symmetric(horizontal: 40.w);
      case ResponsiveDeviceType.desktop:
        return EdgeInsets.symmetric(horizontal: 60.w);
      case ResponsiveDeviceType.largeDesktop:
        return EdgeInsets.symmetric(horizontal: 80.w);
    }
  }

  /// Grid sütun sayısı
  static int getGridColumns(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case ResponsiveDeviceType.mobile:
        return 2;
      case ResponsiveDeviceType.tablet:
        return 3;
      case ResponsiveDeviceType.desktop:
        return 4;
      case ResponsiveDeviceType.largeDesktop:
        return 5;
    }
  }

  /// Maksimum genişlik sınırı
  static double getMaxContentWidth(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case ResponsiveDeviceType.mobile:
        return double.infinity;
      case ResponsiveDeviceType.tablet:
        return 800.w;
      case ResponsiveDeviceType.desktop:
        return 1200.w;
      case ResponsiveDeviceType.largeDesktop:
        return 1400.w;
    }
  }

  /// Responsive font size
  static double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case ResponsiveDeviceType.mobile:
        return baseFontSize.sp;
      case ResponsiveDeviceType.tablet:
        return (baseFontSize * 1.1).sp;
      case ResponsiveDeviceType.desktop:
        return (baseFontSize * 1.2).sp;
      case ResponsiveDeviceType.largeDesktop:
        return (baseFontSize * 1.3).sp;
    }
  }

  /// Responsive icon size
  static double getResponsiveIconSize(BuildContext context, double baseIconSize) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case ResponsiveDeviceType.mobile:
        return baseIconSize.w;
      case ResponsiveDeviceType.tablet:
        return (baseIconSize * 1.2).w;
      case ResponsiveDeviceType.desktop:
        return (baseIconSize * 1.4).w;
      case ResponsiveDeviceType.largeDesktop:
        return (baseIconSize * 1.6).w;
    }
  }

  /// Responsive border radius
  static double getResponsiveBorderRadius(BuildContext context, double baseRadius) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case ResponsiveDeviceType.mobile:
        return baseRadius.r;
      case ResponsiveDeviceType.tablet:
        return (baseRadius * 1.1).r;
      case ResponsiveDeviceType.desktop:
        return (baseRadius * 1.2).r;
      case ResponsiveDeviceType.largeDesktop:
        return (baseRadius * 1.3).r;
    }
  }

  /// Bottom navigation yüksekliği
  static double getBottomNavHeight(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case ResponsiveDeviceType.mobile:
        return 80.h;
      case ResponsiveDeviceType.tablet:
        return 90.h;
      case ResponsiveDeviceType.desktop:
        return 100.h;
      case ResponsiveDeviceType.largeDesktop:
        return 110.h;
    }
  }

  /// App bar yüksekliği
  static double getAppBarHeight(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case ResponsiveDeviceType.mobile:
        return 56.h;
      case ResponsiveDeviceType.tablet:
        return 64.h;
      case ResponsiveDeviceType.desktop:
        return 72.h;
      case ResponsiveDeviceType.largeDesktop:
        return 80.h;
    }
  }

  /// Card yüksekliği
  static double getCardHeight(BuildContext context, double baseHeight) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case ResponsiveDeviceType.mobile:
        return baseHeight.h;
      case ResponsiveDeviceType.tablet:
        return (baseHeight * 1.1).h;
      case ResponsiveDeviceType.desktop:
        return (baseHeight * 1.2).h;
      case ResponsiveDeviceType.largeDesktop:
        return (baseHeight * 1.3).h;
    }
  }

  /// Responsive spacing
  static double getResponsiveSpacing(BuildContext context, double baseSpacing) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case ResponsiveDeviceType.mobile:
        return baseSpacing.h;
      case ResponsiveDeviceType.tablet:
        return (baseSpacing * 1.2).h;
      case ResponsiveDeviceType.desktop:
        return (baseSpacing * 1.4).h;
      case ResponsiveDeviceType.largeDesktop:
        return (baseSpacing * 1.6).h;
    }
  }

  /// Container genişliği sınırı ile merkezleme
  static Widget constrainedContainer({
    required BuildContext context,
    required Widget child,
    double? maxWidth,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? getMaxContentWidth(context),
      ),
      child: child,
    );
  }

  /// Responsive LayoutBuilder wrapper
  static Widget responsiveBuilder({
    required Widget Function(BuildContext context, ResponsiveDeviceType deviceType) builder,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = getDeviceType(context);
        return builder(context, deviceType);
      },
    );
  }
}

/// Responsive widget extension
extension ResponsiveExtension on Widget {
  /// Widget'ı responsive container ile sarmala
  Widget responsive(BuildContext context, {double? maxWidth}) {
    return ResponsiveUtils.constrainedContainer(
      context: context,
      maxWidth: maxWidth,
      child: this,
    );
  }

  /// Sadece belirli cihaz tiplerinde göster
  Widget showOn(BuildContext context, List<ResponsiveDeviceType> deviceTypes) {
    final currentType = ResponsiveUtils.getDeviceType(context);
    if (deviceTypes.contains(currentType)) {
      return this;
    }
    return const SizedBox.shrink();
  }

  /// Belirli cihaz tiplerinde gizle
  Widget hideOn(BuildContext context, List<ResponsiveDeviceType> deviceTypes) {
    final currentType = ResponsiveUtils.getDeviceType(context);
    if (deviceTypes.contains(currentType)) {
      return const SizedBox.shrink();
    }
    return this;
  }
}