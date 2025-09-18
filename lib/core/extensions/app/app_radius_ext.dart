import 'package:flutter/material.dart';

/// Widget border radius extensions
extension WidgetBorderRadiusExtension on Widget {
  /// Widget'a ClipRRect ile border radius ekler
  Widget clipRRect({BorderRadius? borderRadius, double? radius}) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
      child: this,
    );
  }

  /// Widget'a tüm köşelerden eşit border radius ekler
  Widget clipRadius(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }

  /// Widget'a üst köşelerden border radius ekler
  Widget clipTopRadius(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
      child: this,
    );
  }

  /// Widget'a alt köşelerden border radius ekler
  Widget clipBottomRadius(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      ),
      child: this,
    );
  }

  /// Widget'a sol köşelerden border radius ekler
  Widget clipLeftRadius(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
      ),
      child: this,
    );
  }

  /// Widget'a sağ köşelerden border radius ekler
  Widget clipRightRadius(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      ),
      child: this,
    );
  }

  /// Widget'a belirli köşelerden border radius ekler
  Widget clipOnlyRadius({
    double topLeft = 0.0,
    double topRight = 0.0,
    double bottomLeft = 0.0,
    double bottomRight = 0.0,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
      ),
      child: this,
    );
  }
}
