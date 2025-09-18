import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../enums/assets/app_icons.dart';

/// AppIcons enum extensions
extension AppIconsExtension on AppIcons {
  /// SVG icon widget döndürür
  Widget svg({
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    String? semanticsLabel,
  }) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      fit: fit,
      alignment: alignment,
      semanticsLabel: semanticsLabel,
    );
  }

  /// Icon widget döndürür (SVG olmayan iconlar için)
  Widget icon({
    double? size,
    Color? color,
  }) {
    return Image.asset(
      path,
      width: size,
      height: size,
      color: color,
      fit: BoxFit.contain,
    );
  }

  /// IconButton widget döndürür
  Widget iconButton({
    required VoidCallback onPressed,
    double? size,
    Color? color,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    String? tooltip,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: svg(
        width: iconSize ?? size,
        height: iconSize ?? size,
        color: color,
      ),
      iconSize: size,
      padding: padding ?? const EdgeInsets.all(8.0),
      tooltip: tooltip,
    );
  }

  /// Circular IconButton widget döndürür
  Widget circularIconButton({
    required VoidCallback onPressed,
    double? size,
    Color? color,
    Color? backgroundColor,
    double? radius,
    String? tooltip,
  }) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(radius ?? 24),
        child: Container(
          width: (radius ?? 24) * 2,
          height: (radius ?? 24) * 2,
          alignment: Alignment.center,
          child: svg(
            width: size ?? 24,
            height: size ?? 24,
            color: color,
          ),
        ),
      ),
    );
  }

  /// Icon data döndürür (Flutter Material Icons ile uyumlu kullanım için)
  IconData get iconData {
    // Bu method SVG iconları için kullanılamaz
    // Material Icons kullanımı için alternatif mapping gerekebilir
    throw UnimplementedError('SVG icons cannot be converted to IconData');
  }

  /// Asset path döndürür
  String get assetPath => path;

  /// Icon ismini döndürür
  String get iconName => name;
}
