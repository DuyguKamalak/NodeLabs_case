import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
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
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster - Flexible boyutlandırma
          Expanded(
            child: AspectRatio(
              aspectRatio: 169 / 196, // Orijinal aspect ratio
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: movie.posterPath != null && movie.posterPath!.isNotEmpty
                    ? Image.asset(
                        movie.posterPath!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.surface,
                            child: Center(
                              child: Icon(
                                Icons.movie,
                                color: AppColors.textSecondary,
                                size: 40.w,
                              ),
                            ),
                          );
                        },
                      )
                    : Container(
                        color: AppColors.surface,
                        child: Center(
                          child: Icon(
                            Icons.movie,
                            color: AppColors.textSecondary,
                            size: 40.w,
                          ),
                        ),
                      ),
              ),
            ),
          ),

          // Movie Info - Sabit yükseklik
          SizedBox(height: 8.h),
          SizedBox(
            height: 20.h, // Başlık için sabit yükseklik
            child: Text(
              movie.title,
              style: TextStyle(
                fontFamily: 'Instrument Sans',
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 4.h),
          SizedBox(
            height: 18.h, // Alt yazı için sabit yükseklik
            child: Text(
              movie.overview, // Using overview field for studio/producer
              style: TextStyle(
                fontFamily: 'Instrument Sans',
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: Colors.white.withOpacity(0.7),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
