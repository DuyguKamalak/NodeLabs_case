import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// Uygulama genelinde kullanılan gradient background widget'ı
class AppBackground extends StatelessWidget {
  final Widget child;
  final bool showShineEffect;
  final double? shineOpacity;

  const AppBackground({
    super.key,
    required this.child,
    this.showShineEffect = false,
    this.shineOpacity = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.appBackgroundGradient,
      ),
      child: showShineEffect
          ? Stack(
              children: [
                child,
                // Shine effect overlay
                Positioned(
                  top: -100,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(shineOpacity ?? 0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : child,
    );
  }
}
