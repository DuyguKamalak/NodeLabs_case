import 'package:flutter/material.dart';

/// NodeLabs Case - Design System Colors
/// Verilen renk paleti ve gradient'lere göre düzenlenmiş
class AppColors {
  AppColors._();

  //  BRAND COLORS
  /// Primary brand color
  static const Color primary = Color(0xFFE50914); // #E50914
  /// Primary dark brand color
  static const Color primaryDark = Color(0xFF6F060B); // #6F060B
  /// Secondary brand color
  static const Color secondary = Color(0xFF5949E6); // #5949E6

  // WHITE TONES (Opacity variations)
  /// White with 90% opacity
  static const Color white90 = Color(0xE6FFFFFF); // 90% #FFFFFF
  /// White with 80% opacity
  static const Color white80 = Color(0xCCFFFFFF); // 80% #FFFFFF
  /// White with 70% opacity
  static const Color white70 = Color(0xB3FFFFFF); // 70% #FFFFFF
  /// White with 60% opacity
  static const Color white60 = Color(0x99FFFFFF); // 60% #FFFFFF
  /// White with 50% opacity
  static const Color white50 = Color(0x80FFFFFF); // 50% #FFFFFF
  /// White with 40% opacity
  static const Color white40 = Color(0x66FFFFFF); // 40% #FFFFFF
  /// White with 30% opacity
  static const Color white30 = Color(0x4DFFFFFF); // 30% #FFFFFF
  /// White with 20% opacity
  static const Color white20 = Color(0x33FFFFFF); // 20% #FFFFFF
  /// White with 10% opacity
  static const Color white10 = Color(0x1AFFFFFF); // 10% #FFFFFF
  /// White with 5% opacity
  static const Color white5 = Color(0x0DFFFFFF); // 5% #FFFFFF

  //  ALERT & STATUS COLORS
  /// Success color for positive actions
  static const Color success = Color(0xFF00C247); // #00C247
  /// Info color for informational messages
  static const Color info = Color(0xFF004CE8); // #004CE8
  /// Warning color for warning messages
  static const Color warning = Color(0xFFFFBE16); // #FFBE16
  /// Error color for error messages
  static const Color error = Color(0xFFF47171); // #F47171

  //  OTHERS
  /// Pure white
  static const Color white = Color(0xFFFFFFFF); // #FFFFFF
  /// Pure black
  static const Color black = Color(0xFF000000); // #000000

  // COMMON UI COLORS (derived from design system)
  /// Main background color (from gradient base)
  static const Color background = Color(0xFF090909); // #090909
  /// Dark background color
  static const Color backgroundDark = Color(0xFF000000); // #000000
  /// Surface color for cards and containers
  static const Color surface = Color(0xFF1A1A1A);

  /// Dark surface color
  static const Color surfaceDark = Color(0xFF0F0F0F);

  /// Border color
  static const Color border = Color(0xFF333333);

  /// Grey color
  static const Color grey = Color(0xFF9E9E9E);

  //  BUTTON COLORS
  /// Disabled button color
  static const Color buttonDisabled = Color(0xFF4D4D4D);

  //  SPLASH COLORS
  /// Splash bottom color
  static const Color splashBottom = Color(0xFF090909); // #090909
  /// Splash top color
  static const Color splashTop = Color(0xFF3F0306); // #3F0306

  // TEXT COLORS (using white tones)
  /// Primary text color
  static const Color textPrimary = white; // #FFFFFF
  /// Secondary text color
  static const Color textSecondary = white60; // 60% white
  /// Tertiary text color
  static const Color textTertiary = white40; // 40% white
  /// Disabled text color
  static const Color textDisabled = white30; // 30% white

  // GRADIENTS

  /// Background gradient: linear-gradient(0deg, #090909 40%, #3F0306 100%)
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.4, 1.0],
    colors: [
      Color(0xFF090909), // #090909 at 40%
      Color(0xFF3F0306), // #3F0306 at 100%
    ],
  );

  /// Popular Card gradient: radial-gradient(144.56% 76.1% at 26.44% 15.22%, #5949E6 0%, #E50914 100%)
  static const RadialGradient popularCardGradient = RadialGradient(
    center: Alignment(-0.4712, -0.6956), // 26.44% x, 15.22% y
    radius: 1.0, // 144.56% coverage
    colors: [
      secondary, // #5949E6 at 0%
      primary, // #E50914 at 100%
    ],
    stops: [0.0, 1.0],
  );

  /// Normal Card gradient: radial-gradient(144.56% 76.1% at 26.44% 15.22%, #6F060B 0%, #E50914 100%)
  static const RadialGradient normalCardGradient = RadialGradient(
    center: Alignment(-0.4712, -0.6956), // 26.44% x, 15.22% y
    radius: 1.0, // 144.56% coverage
    colors: [
      primaryDark, // #6F060B at 0%
      primary, // #E50914 at 100%
    ],
    stops: [0.0, 1.0],
  );

  /// Active Navigation gradient: radial-gradient(144.56% 76.1% at 26.44% 15.22%, #6F060B 0%, #E50914 100%)
  static const RadialGradient activeNavGradient = RadialGradient(
    center: Alignment(-0.4712, -0.6956), // 26.44% x, 15.22% y
    radius: 1.0, // 144.56% coverage
    colors: [
      primaryDark, // #6F060B at 0%
      primary, // #E50914 at 100%
    ],
    stops: [0.0, 1.0],
  );

  //  LEGACY ALIASES (for backward compatibility)
  /// App background gradient (same as backgroundGradient)
  static const LinearGradient appBackgroundGradient = backgroundGradient;

  /// Button radial gradient (same as activeNavGradient)
  static const RadialGradient buttonRadialGradient = activeNavGradient;

  /// Navbar bottom gradient for fade effect
  static const LinearGradient navbarBottomGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.29],
    colors: [
      Color(0x00090909), // Transparent
      Color(0xFF090909), // #090909
    ],
  );

  //  UTILITY COLORS
  /// Transparent color
  static const Color transparent = Colors.transparent;

  /// Shadow color
  static const Color shadow = Color(0x29000000);

  /// Focus color (same as primary)
  static const Color focus = primary;

  // ADDITIONAL COLORS FOUND IN CODE
  /// Apple red color for buttons
  static const Color appleRed = Color(0xFFFF3B30); // #FF3B30
  /// Bright red for gradients
  static const Color brightRed = Color(0xFFFF1B1B); // #FF1B1B
  /// Dark red for gradients
  static const Color darkRed = Color(0xFF8D0000); // #8D0000
  /// White with 5% opacity
  static const Color white5Opacity = Color(0x0DFFFFFF); // 5% #FFFFFF
  /// White with 6% opacity
  static const Color white6Opacity = Color(0x0FFFFFFF); // 6% #FFFFFF
  /// White with 8% opacity
  static const Color white8Opacity = Color(0x14FFFFFF); // 8% #FFFFFF
  /// White with 7% opacity
  static const Color white7Opacity = Color(0x12FFFFFF); // 7% #FFFFFF
}
