import 'package:flutter/material.dart';

/// NodeLabs Case - Güncellenmiş renk paleti
class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFFE50914); // Brand Primary
  static const Color primaryDark = Color(0xFF6F060B); // Brand Primary Dark
  static const Color secondary = Color(0xFF5949E6); // Brand Secondary

  // White Tones (Opacity based)
  static const Color white90 = Color(0xE6FFFFFF); // 90%
  static const Color white80 = Color(0xCCFFFFFF); // 80%
  static const Color white70 = Color(0xB3FFFFFF); // 70%
  static const Color white60 = Color(0x99FFFFFF); // 60%
  static const Color white50 = Color(0x80FFFFFF); // 50%
  static const Color white40 = Color(0x66FFFFFF); // 40%
  static const Color white30 = Color(0x4DFFFFFF); // 30%
  static const Color white20 = Color(0x33FFFFFF); // 20%
  static const Color white10 = Color(0x1AFFFFFF); // 10%
  static const Color white5 = Color(0x0DFFFFFF); // 5%

  // Alert & Status Colors
  static const Color success = Color(0xFF00C247); // Success
  static const Color info = Color(0xFF004CE8); // Info
  static const Color warning = Color(0xFFFFBE16); // Warning
  static const Color error = Color(0xFFF47171); // Error

  // Others
  static const Color white = Color(0xFFFFFFFF); // White
  static const Color black = Color(0xFF000000); // Black
  static const Color grey = Color(0xFF9E9E9E); // Grey

  // Background Colors
  static const Color background = Color(0xFF000000);
  static const Color backgroundDark = Color(0xFF000000);
  static const Color backgroundSecondary = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color surfaceSecondary = Color(0xFF2A2A2A);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);
  static const Color textTertiary = Color(0xFF808080);
  static const Color textDisabled = Color(0xFF4D4D4D);

  // Button Colors
  static const Color buttonPrimary = Color(0xFFE50914);
  static const Color buttonSecondary = Color(0xFF2A2A2A);
  static const Color buttonTertiary = Color(0xFF000000);
  static const Color buttonDisabled = Color(0xFF4D4D4D);

  // Border Colors
  static const Color border = Color(0xFF333333);
  static const Color borderFocused = Color(0xFFE50914);
  static const Color borderError = Color(0xFFF47171);

  // Card Colors
  static const Color cardBackground = Color(0xFF1A1A1A);
  static const Color cardBorder = Color(0xFF333333);

  // Favorite/Like Colors
  static const Color favorite = Color(0xFFE50914);
  static const Color favoriteInactive = Color(0xFF4D4D4D);

  // Bottom Sheet Colors
  static const Color bottomSheetBackground = Color(0xFF1A1A1A);
  static const Color bottomSheetHandle = Color(0xFF4D4D4D);

  // Navigation Colors
  static const Color navBarBackground = Color(0xFF000000);
  static const Color navBarActive = Color(0xFFE50914);
  static const Color navBarInactive = Color(0xFF808080);

  // Splash Screen
  static const Color splashBottom = Color(0xFF090909);
  static const Color splashTop = Color(0xFF3F0306);

  // Utility Colors
  static const Color transparent = Colors.transparent;
  static const Color shadow = Color(0x29000000);

  // Figma UI Colors (additional)
  static const Color black5 = Color(0x0D000000); // #0000000D (%5 opak)
  static const Color darkGray = Color(0xFF090909); // #090909

  // App Background Gradient
  static const LinearGradient appBackgroundGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      splashBottom, // #090909
      splashTop, // #3F0306
    ],
    stops: [0.4, 1.0],
  );

  // Popular Card Gradient
  static const LinearGradient popularCardGradient = LinearGradient(
    begin: Alignment(0.2644, 0.1522),
    end: Alignment(1.0, 1.0),
    colors: [
      secondary, // #5949E6
      primary, // #E50914
    ],
    stops: [0.0, 1.0],
  );

  // Normal Card Gradient
  static const LinearGradient normalCardGradient = LinearGradient(
    begin: Alignment(0.2644, 0.1522),
    end: Alignment(1.0, 1.0),
    colors: [
      primaryDark, // #6F060B
      primary, // #E50914
    ],
    stops: [0.0, 1.0],
  );

  // Active Nav Gradient
  static const LinearGradient activeNavGradient = LinearGradient(
    begin: Alignment(0.2644, 0.1522),
    end: Alignment(1.0, 1.0),
    colors: [
      primaryDark, // #6F060B
      primary, // #E50914
    ],
    stops: [0.0, 1.0],
  );

  // Figma Gradients

  // Navbar Bottom Gradient (linear-gradient(180deg, rgba(9, 9, 9, 0) 0%, #090909 29%))
  static const LinearGradient navbarBottomGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.29],
    colors: [
      Color(0x00090909), // rgba(9, 9, 9, 0) - şeffaf
      Color(0xFF090909), // #090909 - %29'da koyu
    ],
  );

  // Button Radial Gradient (radial-gradient(58.74% 83.33% at 50% 16.67%, #E50914 0%, #7F050B 100%))
  static const RadialGradient buttonRadialGradient = RadialGradient(
    center: Alignment(0.0, -0.6667), // 50% x, 16.67% y pozisyonu
    radius: 0.83, // %83.33 yarıçap
    colors: [
      Color(0xFFE50914), // #E50914 merkezde
      Color(0xFF7F050B), // #7F050B kenarlarda
    ],
    stops: [0.0, 1.0],
  );
}
