import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../data/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.onFavoriteTap,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveUtils.responsiveBuilder(
      builder: (context, deviceType) {
        final borderRadius =
            ResponsiveUtils.getResponsiveBorderRadius(context, 8);
        final titleFontSize =
            ResponsiveUtils.getResponsiveFontSize(context, 16);
        final subtitleFontSize =
            ResponsiveUtils.getResponsiveFontSize(context, 14);
        final iconSize = ResponsiveUtils.getResponsiveIconSize(context, 40);
        final spacing = ResponsiveUtils.getResponsiveSpacing(context, 8);
        final smallSpacing = ResponsiveUtils.getResponsiveSpacing(context, 4);

        // Responsive text heights
        final titleHeight = ResponsiveUtils.isMobile(context) ? 20.h : 24.h;
        final subtitleHeight = ResponsiveUtils.isMobile(context) ? 18.h : 20.h;

        return GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie Poster - Responsive aspect ratio
              Expanded(
                child: AspectRatio(
                  aspectRatio: ResponsiveUtils.isMobile(context)
                      ? 169 / 196 // Original mobile ratio
                      : 3 / 4, // Slightly different for larger screens
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadius),
                        child: movie.posterPath != null &&
                                movie.posterPath!.isNotEmpty
                            ? Image.asset(
                                movie.posterPath!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildPlaceholder(iconSize);
                                },
                              )
                            : _buildPlaceholder(iconSize),
                      ),
                      // Favorite button overlay (conditional)
                      if (onFavoriteTap != null)
                        Positioned(
                          top: ResponsiveUtils.getResponsiveSpacing(context, 8),
                          right:
                              ResponsiveUtils.getResponsiveSpacing(context, 8),
                          child: _buildFavoriteButton(context),
                        ),
                    ],
                  ),
                ),
              ),

              // Movie Info - Responsive spacing and text
              SizedBox(height: spacing),
              SizedBox(
                height: titleHeight,
                child: Text(
                  movie.title,
                  style: AppTextStyles.bodyLargeSemibold(context).copyWith(
                    fontSize: titleFontSize,
                    color: AppColors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: smallSpacing),
              SizedBox(
                height: subtitleHeight,
                child: Text(
                  movie.overview, // Using overview field for studio/producer
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    fontSize: subtitleFontSize,
                    color: AppColors.white70,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlaceholder(double iconSize) {
    return Container(
      color: AppColors.surface,
      child: Center(
        child: Icon(
          Icons.movie,
          color: AppColors.textSecondary,
          size: iconSize,
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    final buttonSize = ResponsiveUtils.getResponsiveIconSize(context, 32);
    final iconSize = ResponsiveUtils.getResponsiveIconSize(context, 16);

    return GestureDetector(
      onTap: onFavoriteTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(buttonSize / 2),
        ),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.white,
          size: iconSize,
        ),
      ),
    );
  }
}
