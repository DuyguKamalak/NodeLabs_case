import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../enums/assets/app_images.dart';

/// AppImages enum extensions
extension AppImagesExtension on AppImages {
  /// Image widget döndürür
  Widget image({
    double? width,
    double? height,
    BoxFit? fit,
    Alignment alignment = Alignment.center,
    Color? color,
    BlendMode? colorBlendMode,
    String? semanticLabel,
    bool excludeFromSemantics = false,
  }) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
    );
  }

  /// Container background image döndürür
  Widget backgroundImage({
    required Widget child,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Alignment alignment = Alignment.center,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcOver,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(path),
          fit: fit,
          alignment: alignment,
          colorFilter:
              color != null ? ColorFilter.mode(color, colorBlendMode) : null,
        ),
      ),
      child: child,
    );
  }

  /// CircleAvatar widget döndürür
  Widget circleAvatar({
    double? radius,
    Color? backgroundColor,
    Widget? child,
  }) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      backgroundImage: AssetImage(path),
      child: child,
    );
  }

  /// Placeholder image ile Image widget döndürür
  Widget imageWithPlaceholder({
    double? width,
    double? height,
    BoxFit? fit,
    Alignment alignment = Alignment.center,
    Widget? placeholder,
    Widget? errorWidget,
    Duration? fadeDuration,
  }) {
    return FadeInImage.assetNetwork(
      placeholder: path,
      image: '', // Bu durumda network image yerine başka bir asset kullanılmalı
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      alignment: alignment,
      fadeInDuration: fadeDuration ?? const Duration(milliseconds: 300),
      imageErrorBuilder: (context, error, stackTrace) {
        return errorWidget ?? const Icon(Icons.error);
      },
    );
  }

  /// Network image için placeholder olarak kullanım
  Widget networkImageWithPlaceholder({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit? fit,
    Alignment alignment = Alignment.center,
    Widget? errorWidget,
    Duration? fadeInDuration,
    Duration? fadeOutDuration,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => image(
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
      ),
      errorWidget: (context, url, error) {
        return errorWidget ??
            image(
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
            );
      },
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      fadeInDuration: fadeInDuration ?? const Duration(milliseconds: 300),
      fadeOutDuration: fadeOutDuration ?? const Duration(milliseconds: 300),
    );
  }

  /// Asset provider döndürür
  AssetImage get assetImage => AssetImage(path);

  /// Asset path döndürür
  String get assetPath => path;

  /// Image ismini döndürür
  String get imageName => name;

  /// File extension döndürür
  String get extension => path.split('.').last;

  /// Dosya ismini extension olmadan döndürür
  String get nameWithoutExtension {
    final fileName = path.split('/').last;
    return fileName.split('.').first;
  }
}
