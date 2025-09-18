import 'package:flutter/material.dart';

/// Uygulama padding değerleri
class AppPaddings {
  AppPaddings._();

  // General Paddings
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Specific Paddings
  static const double page = 20.0;
  static const double card = 16.0;
  static const double button = 16.0;
  static const double input = 16.0;

  // EdgeInsets
  static const EdgeInsets zero = EdgeInsets.zero;
  static const EdgeInsets all4 = EdgeInsets.all(xs);
  static const EdgeInsets all8 = EdgeInsets.all(sm);
  static const EdgeInsets all16 = EdgeInsets.all(md);
  static const EdgeInsets all24 = EdgeInsets.all(lg);
  static const EdgeInsets all32 = EdgeInsets.all(xl);

  // Horizontal Paddings
  static const EdgeInsets horizontal4 = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets horizontal8 = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontal16 = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets horizontal24 = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets horizontal32 = EdgeInsets.symmetric(horizontal: xl);

  // Vertical Paddings
  static const EdgeInsets vertical4 = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets vertical8 = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets vertical16 = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets vertical24 = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets vertical32 = EdgeInsets.symmetric(vertical: xl);

  // Page Paddings
  static const EdgeInsets pageAll = EdgeInsets.all(page);
  static const EdgeInsets pageHorizontal =
      EdgeInsets.symmetric(horizontal: page);
  static const EdgeInsets pageVertical = EdgeInsets.symmetric(vertical: page);
}
