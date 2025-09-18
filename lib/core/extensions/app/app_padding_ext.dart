import 'package:flutter/material.dart';

/// Widget padding extensions
extension WidgetPaddingExtension on Widget {
  /// Widget'a padding ekler
  Widget padding(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  /// Widget'a tüm taraflardan eşit padding ekler
  Widget paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  /// Widget'a yatay padding ekler
  Widget paddingHorizontal(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value),
      child: this,
    );
  }

  /// Widget'a dikey padding ekler
  Widget paddingVertical(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value),
      child: this,
    );
  }

  /// Widget'a belirli taraflardan padding ekler
  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  /// Widget'a sol padding ekler
  Widget paddingLeft(double value) {
    return paddingOnly(left: value);
  }

  /// Widget'a sağ padding ekler
  Widget paddingRight(double value) {
    return paddingOnly(right: value);
  }

  /// Widget'a üst padding ekler
  Widget paddingTop(double value) {
    return paddingOnly(top: value);
  }

  /// Widget'a alt padding ekler
  Widget paddingBottom(double value) {
    return paddingOnly(bottom: value);
  }
}
