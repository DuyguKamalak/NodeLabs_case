import 'dart:ui' as ui show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/utils/responsive_utils.dart';

class LimitedOfferBottomSheet extends StatefulWidget {
  const LimitedOfferBottomSheet({super.key});

  static Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const LimitedOfferBottomSheet(),
    );
  }

  @override
  State<LimitedOfferBottomSheet> createState() =>
      _LimitedOfferBottomSheetState();
}

class _LimitedOfferBottomSheetState extends State<LimitedOfferBottomSheet> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final double maxHeight =
        (screen.height * 0.83).clamp(0.0, 620.h.toDouble());
    final EdgeInsets contentPadding = EdgeInsets.symmetric(
      horizontal: ResponsiveUtils.getResponsiveSpacing(context, 24),
      vertical: ResponsiveUtils.getResponsiveSpacing(context, 32),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.backgroundGradient,
              ),
            ),
          ),

          // --- Top Shine Effect  ---
          Positioned(
            top: ResponsiveUtils.isMobile(context) ? 20 : -80,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Center(
                child: ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(
                    sigmaX: ResponsiveUtils.isMobile(context) ? 40.6 : 60.0,
                    sigmaY: ResponsiveUtils.isMobile(context) ? 40.6 : 60.0,
                  ),
                  child: SvgPicture.asset(
                    'assets/images/Shine Effect.svg',
                    width: screen.width *
                        (ResponsiveUtils.isMobile(context) ? 0.92 : 0.8),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          // --- Bottom Shine Effect (primary #E50914, yuvarlak) ---
          Positioned(
            bottom: ResponsiveUtils.isMobile(context) ? -56 : -80,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Center(
                child: SizedBox(
                  width: 220, // verilen width
                  height: 220, // verilen height
                  child: ImageFiltered(
                    imageFilter: ui.ImageFilter.blur(
                      sigmaX: ResponsiveUtils.isMobile(context) ? 90.0 : 60.0,
                      sigmaY: ResponsiveUtils.isMobile(context) ? 90.0 : 60.0,
                    ),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // yuvarlak
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: 0.95,
                          colors: <Color>[
                            AppColors.primary, // merkez opak #E50914
                            Colors.transparent, // dışa sönüş
                          ],
                          stops: <double>[0.0, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.limitedOffer,
                          style: AppTextStyles.h4(context),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height:
                              ResponsiveUtils.getResponsiveSpacing(context, 8),
                        ),
                        Text(
                          AppStrings.limitedOfferDescription,
                          style: AppTextStyles.bodyMedium(context)
                              .copyWith(color: AppColors.white90),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height:
                              ResponsiveUtils.getResponsiveSpacing(context, 16),
                        ),
                        const _BonusesPanel(),
                        SizedBox(
                          height:
                              ResponsiveUtils.getResponsiveSpacing(context, 16),
                        ),
                        Text(
                          AppStrings.unlockWithTokenPackage,
                          style: AppTextStyles.bodyLargeSemibold(context),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height:
                              ResponsiveUtils.getResponsiveSpacing(context, 12),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: ResponsiveUtils.getResponsiveSpacing(
                                context, 8),
                          ),
                          child: _CoinOptions(
                            selectedIndex: selectedIndex,
                            onChanged: (i) => setState(() => selectedIndex = i),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: ResponsiveUtils.getResponsiveSpacing(context, 12),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppRadius.all12,
                      ),
                    ),
                    child: Text(
                      AppStrings.viewAllTokens,
                      style: AppTextStyles.buttonLarge(context),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),

          Positioned(
            right: ResponsiveUtils.getResponsiveSpacing(context, 24),
            top: ResponsiveUtils.getResponsiveSpacing(context, 16),
            child: _BlurCircleButton(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.close, size: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlurCircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const _BlurCircleButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(900),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(900),
        child: Container(
          width: 36.w,
          height: 36.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.white10,
            borderRadius: BorderRadius.circular(900),
            border: Border.all(color: AppColors.white50, width: 1),
          ),
          child: child,
        ),
      ),
    );
  }
}

// 'key' opsiyonel parametresi kaldırıldı (lint fix)
class _BonusesPanel extends StatelessWidget {
  const _BonusesPanel();

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = EdgeInsets.all(AppPaddings.md.w);
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: AppRadius.all16,
        border: Border.all(color: AppColors.white20, width: 1),
        gradient: const RadialGradient(
          center: Alignment(0.1, 0),
          radius: 1.2,
          colors: [AppColors.white10, AppColors.white5],
          stops: [0.0, 1.0],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.bonusesYouWillGet,
            style: AppTextStyles.bodyLargeSemibold(context)
                .copyWith(color: AppColors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 12)),
          LayoutBuilder(
            builder: (context, constraints) {
              final double gap = 6.w;
              final double usable = constraints.maxWidth - gap * 3;
              final double badgeSize = (usable / 4).clamp(44.0, 60.0);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BonusBadge(
                    size: badgeSize,
                    label: AppStrings.premiumAccount,
                    asset: 'assets/images/iconlyPro.png',
                  ),
                  _BonusBadge(
                    size: badgeSize,
                    label: AppStrings.moreMatches,
                    asset: 'assets/images/iconlyMatch.png',
                  ),
                  _BonusBadge(
                    size: badgeSize,
                    label: AppStrings.highlight,
                    asset: 'assets/images/iconlyHighlight.png',
                  ),
                  _BonusBadge(
                    size: badgeSize,
                    label: AppStrings.moreLikes,
                    asset: 'assets/images/iconlyLikes.png',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BonusBadge extends StatelessWidget {
  final double size;
  final String label;
  final String asset;
  const _BonusBadge({
    required this.size,
    required this.label,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    const double sigma = 4.5; // glow blur gücü
    const double ringStart = 0.74; // halkanın başlangıç noktası

    return SizedBox(
      width: size,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Ana daire
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white50, width: 1),
                ),
              ),

              // Inset glow efekti
              ClipOval(
                child: ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(
                    sigmaX: sigma,
                    sigmaY: sigma,
                  ),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        center: Alignment(0, 0),
                        radius: 0.95,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          AppColors.white60, // beyaz glow
                          Colors.transparent,
                        ],
                        stops: [0.0, ringStart, 0.92, 1.0],
                      ),
                    ),
                  ),
                ),
              ),

              // --- İKON: SVG + PNG fallback (SVG boş çizilirse PNG görünür) ---
              _BadgeIcon(
                asset: asset,
                size: size * 0.56,
              ),
            ],
          ),
          SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 16)),
          Text(
            label,
            style: AppTextStyles.bodyXSmallSemibold(context)
                .copyWith(color: AppColors.white),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _BadgeIcon extends StatelessWidget {
  final String asset;
  final double size;
  const _BadgeIcon({required this.asset, required this.size});

  String _pngPath(String p) =>
      p.replaceAll(RegExp(r'\.svg$', caseSensitive: false), '.png');

  @override
  Widget build(BuildContext context) {
    final png = _pngPath(asset);

    // PNG'yi altta, SVG'yi üstte tutuyoruz.
    // SVG boş/şeffaf çizilirse alttaki PNG görünür.
    return Stack(
      alignment: Alignment.center,
      children: [
        // PNG fallback
        Image.asset(
          png,
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),

        // SVG
        SvgPicture.asset(
          asset,
          width: size,
          height: size,
          fit: BoxFit.contain,
          allowDrawingOutsideViewBox: true,
          placeholderBuilder: (_) => const SizedBox.shrink(),
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _CoinOptions extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  const _CoinOptions({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(3, (index) {
        final bool isSelected = index == selectedIndex;
        final String asset = isSelected
            ? 'assets/icons/coin_options/State=Selected.svg'
            : 'assets/icons/coin_options/State=Default.svg';
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(index),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: AspectRatio(
                aspectRatio: 0.52,
                child: SvgPicture.asset(
                  asset,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
