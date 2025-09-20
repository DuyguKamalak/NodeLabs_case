import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/common/app_background.dart';
import '../../movies/data/models/movie_model.dart';
import '../../movies/presentation/widgets/movie_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Mock data
  final String _userName = 'Ayça Aydoğan';
  final String _userId = 'ID: 245677';
  final List<MovieModel> _favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    // Mock favorite movies with real movie data for demonstration
    setState(() {
      _favoriteMovies.addAll([
        const MovieModel(
          id: 1,
          title: 'Aşk Yeniden',
          overview: 'Sony',
          posterPath: 'assets/images/aşkyeniden.png',
          backdropPath: 'assets/images/aşkyeniden.png',
          releaseDate: '2024',
          voteAverage: 8.6,
          voteCount: 2000,
          genreIds: [28, 12, 16],
          adult: false,
          originalLanguage: 'tr',
          originalTitle: 'Aşk Yeniden',
          popularity: 200.0,
          hasVideo: false,
        ),
        const MovieModel(
          id: 2,
          title: 'Başka Bir Hayatta',
          overview: 'A24',
          posterPath: 'assets/images/başkabirhayatta.png',
          backdropPath: 'assets/images/başkabirhayatta.png',
          releaseDate: '2024',
          voteAverage: 8.8,
          voteCount: 2500,
          genreIds: [18],
          adult: false,
          originalLanguage: 'en',
          originalTitle: 'Past Lives',
          popularity: 300.0,
          hasVideo: false,
        ),
        const MovieModel(
          id: 3,
          title: 'Senden Başka',
          overview: 'Columbia',
          posterPath: 'assets/images/sendenbaşka.png',
          backdropPath: 'assets/images/sendenbaşka.png',
          releaseDate: '2024',
          voteAverage: 8.2,
          voteCount: 1800,
          genreIds: [35, 10749],
          adult: false,
          originalLanguage: 'en',
          originalTitle: 'Anyone But You',
          popularity: 250.0,
          hasVideo: false,
        ),
        const MovieModel(
          id: 4,
          title: 'Culpa mía',
          overview: 'Netflix',
          posterPath: 'assets/images/culpamia.png',
          backdropPath: 'assets/images/culpamia.png',
          releaseDate: '2024',
          voteAverage: 7.9,
          voteCount: 1500,
          genreIds: [10749, 18],
          adult: false,
          originalLanguage: 'es',
          originalTitle: 'Culpa mía',
          popularity: 180.0,
          hasVideo: false,
        ),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header Section
              _buildHeader(context),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 24.h),

                      // Border çizgisi - telefonun tam genişliğinde
                      Container(
                        width: double.infinity,
                        height: 1.h,
                        color: const Color(0xFFFFFFFF).withOpacity(0.05),
                      ),

                      SizedBox(height: 24.h),

                      // Beğendiklerim Section - Centered with specified dimensions
                      _buildLikedSectionWithGrid(),

                      SizedBox(height: 100.h), // Space for bottom nav
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // Get screen width and calculate relative dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    const designWidth = 402.0;
    final scaleFactor = screenWidth / designWidth;

    return SizedBox(
      width: screenWidth,
      child: Column(
        children: [
          // Header section - 402x60 responsive
          Container(
            width: screenWidth,
            height: (60 * scaleFactor).clamp(50.0, 70.0), // Min 50, Max 70
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Profil',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 24.sp,
                      height: 1.0,
                      color: const Color(0xFFFFFFFF),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 16.w),
                // Sınırlı Teklif Button
                Container(
                  constraints: BoxConstraints(
                    minWidth: 80.w,
                    maxWidth: 140.w,
                  ),
                  height: 32.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF3B30),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/icon/Component/Components/Gem.svg',
                        width: 16.w,
                        height: 16.h,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          'Sınırlı Teklif',
                          style: TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Profile photo section - 402x78 responsive
          Container(
            width: screenWidth,
            height: (78 * scaleFactor).clamp(70.0, 90.0), // Min 70, Max 90
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Photo
                Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(900.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(900.r),
                    child: Image.asset(
                      'assets/images/profil_photo.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _userName,
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          height: 1.0,
                          color: const Color(0xFFFFFFFF),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        _userId,
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          height: 1.0,
                          color: const Color(0xFFFFFFFF).withOpacity(0.6),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                // Fotoğraf Ekle Button
                Container(
                  constraints: BoxConstraints(
                    minWidth: 100.w,
                    maxWidth: 140.w,
                  ),
                  height: 37.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      'Fotoğraf Ekle',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: const Color(0xFFFFFFFF).withOpacity(0.8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLikedSectionWithGrid() {
    // Get screen width and calculate responsive dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    const designWidth = 402.0;
    final scaleFactor = screenWidth / designWidth;

    // Calculate responsive dimensions based on design specs
    final sectionWidth = (354 * scaleFactor).clamp(300.0, 380.0);
    final sectionHeight = (564 * scaleFactor).clamp(500.0, 600.0);

    return Center(
      child: SizedBox(
        width: sectionWidth,
        height: sectionHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Beğendiklerim title
            Text(
              'Beğendiklerim',
              style: TextStyle(
                fontFamily: 'Instrument Sans',
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                height: 1.0,
                color: const Color(0xFFFFFFFF),
              ),
            ),

            SizedBox(height: 24.h), // 24px gap as specified

            // Movies Grid
            Expanded(
              child: _buildMoviesGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoviesGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Fixed 2 columns for consistent layout
        const crossAxisCount = 2;
        final availableWidth = constraints.maxWidth;

        // Calculate card dimensions with 16px gap
        final cardWidth = (availableWidth - 16.w) / crossAxisCount;
        final imageHeight = cardWidth * (196 / 169); // Maintain aspect ratio
        final textHeight = 50.h;
        final cardHeight = imageHeight + textHeight;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16.w, // 16px gap between columns
            mainAxisSpacing: 24.h, // 24px gap between rows as specified
            childAspectRatio: cardWidth / cardHeight,
          ),
          itemCount: _favoriteMovies.length,
          itemBuilder: (context, index) {
            final movie = _favoriteMovies[index];
            return MovieCard(
              movie: movie,
              isFavorite: true,
              onFavoriteTap: () {
                setState(() {
                  _favoriteMovies.removeAt(index);
                });
              },
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${movie.title} detaylarına gidiliyor...'),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
