import 'package:flutter/material.dart';

/// Uygulama border radius değerleri
class AppRadius {
  AppRadius._();

  // Radius Values
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double circular = 50.0;

  // BorderRadius
  static const BorderRadius zero = BorderRadius.zero;
  static const BorderRadius all4 = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius all8 = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius all12 = BorderRadius.all(Radius.circular(md));
  static const BorderRadius all16 = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius all24 = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius all32 = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius allCircular =
      BorderRadius.all(Radius.circular(circular));

  // Top Radius
  static const BorderRadius topSmall = BorderRadius.only(
    topLeft: Radius.circular(sm),
    topRight: Radius.circular(sm),
  );
  static const BorderRadius topMedium = BorderRadius.only(
    topLeft: Radius.circular(md),
    topRight: Radius.circular(md),
  );
  static const BorderRadius topLarge = BorderRadius.only(
    topLeft: Radius.circular(lg),
    topRight: Radius.circular(lg),
  );

  // Bottom Radius
  static const BorderRadius bottomSmall = BorderRadius.only(
    bottomLeft: Radius.circular(sm),
    bottomRight: Radius.circular(sm),
  );
  static const BorderRadius bottomMedium = BorderRadius.only(
    bottomLeft: Radius.circular(md),
    bottomRight: Radius.circular(md),
  );
  static const BorderRadius bottomLarge = BorderRadius.only(
    bottomLeft: Radius.circular(lg),
    bottomRight: Radius.circular(lg),
  );

  // Specific Use Cases
  static const BorderRadius button = all12;
  static const BorderRadius card = all16;
  static const BorderRadius bottomSheet = topLarge;
  static const BorderRadius dialog = all16;
  static const BorderRadius input = all8;
}
