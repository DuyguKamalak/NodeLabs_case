import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
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
          child: ResponsiveUtils.responsiveBuilder(
            builder: (context, deviceType) {
              return ResponsiveUtils.constrainedContainer(
                context: context,
                child: Column(
                  children: [
                    // Header Section
                    _buildHeader(context, deviceType),

                    // Scrollable Content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: ResponsiveUtils.getResponsiveSpacing(
                                    context, 24)),

                            // Border çizgisi - responsive genişlikte
                            Container(
                              width: double.infinity,
                              height: 1.h,
                              color: const Color(0xFFFFFFFF).withOpacity(0.05),
                            ),

                            SizedBox(
                                height: ResponsiveUtils.getResponsiveSpacing(
                                    context, 24)),

                            // Beğendiklerim Section - Responsive with grid/list
                            _buildLikedSection(context, deviceType),

                            SizedBox(
                                height: ResponsiveUtils.isMobile(context)
                                    ? 100.h
                                    : 50.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ResponsiveDeviceType deviceType) {
    final horizontalPadding = ResponsiveUtils.getPagePadding(context);
    final headerHeight = ResponsiveUtils.isMobile(context) ? 60.h : 70.h;
    final profileSectionHeight =
        ResponsiveUtils.isMobile(context) ? 78.h : 88.h;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          // Header section - responsive
          Container(
            width: double.infinity,
            height: headerHeight,
            padding: horizontalPadding,
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
                      fontSize:
                          ResponsiveUtils.getResponsiveFontSize(context, 24),
                      height: 1.0,
                      color: const Color(0xFFFFFFFF),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                    width: ResponsiveUtils.getResponsiveSpacing(context, 16)),
                // Sınırlı Teklif Button - responsive
                _buildOfferButton(context),
              ],
            ),
          ),

          // Profile photo section - responsive
          Container(
            width: double.infinity,
            height: profileSectionHeight,
            padding: horizontalPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Photo - responsive
                _buildProfilePhoto(context),
                SizedBox(
                    width: ResponsiveUtils.getResponsiveSpacing(context, 12)),
                // User Info - responsive
                Expanded(child: _buildUserInfo(context)),
                SizedBox(
                    width: ResponsiveUtils.getResponsiveSpacing(context, 8)),
                // Fotoğraf Ekle Button - responsive
                _buildPhotoButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferButton(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final buttonHeight = ResponsiveUtils.isMobile(context) ? 32.h : 36.h;

    return Container(
      constraints: BoxConstraints(
        minWidth: isDesktop ? 100.w : 80.w,
        maxWidth: isDesktop ? 160.w : 140.w,
      ),
      height: buttonHeight,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getResponsiveSpacing(context, 12),
        vertical: ResponsiveUtils.getResponsiveSpacing(context, 8),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFF3B30),
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getResponsiveBorderRadius(context, 20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/icon/Component/Components/Gem.svg',
            width: ResponsiveUtils.getResponsiveIconSize(context, 16),
            height: ResponsiveUtils.getResponsiveIconSize(context, 16),
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context, 4)),
          Flexible(
            child: Text(
              'Sınırlı Teklif',
              style: TextStyle(
                fontFamily: 'Instrument Sans',
                fontWeight: FontWeight.w600,
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhoto(BuildContext context) {
    final photoSize = ResponsiveUtils.isMobile(context) ? 56.w : 64.w;

    return Container(
      width: photoSize,
      height: photoSize,
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
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _userName,
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
            height: 1.0,
            color: const Color(0xFFFFFFFF),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 2)),
        Text(
          _userId,
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontWeight: FontWeight.w500,
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
            height: 1.0,
            color: const Color(0xFFFFFFFF).withOpacity(0.6),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildPhotoButton(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final buttonHeight = ResponsiveUtils.isMobile(context) ? 37.h : 42.h;

    return Container(
      constraints: BoxConstraints(
        minWidth: isDesktop ? 120.w : 100.w,
        maxWidth: isDesktop ? 160.w : 140.w,
      ),
      height: buttonHeight,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getResponsiveSpacing(context, 16),
        vertical: ResponsiveUtils.getResponsiveSpacing(context, 10),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF).withOpacity(0.05),
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getResponsiveBorderRadius(context, 8),
        ),
      ),
      child: Center(
        child: Text(
          'Fotoğraf Ekle',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontWeight: FontWeight.w500,
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
            color: const Color(0xFFFFFFFF).withOpacity(0.8),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildLikedSection(
      BuildContext context, ResponsiveDeviceType deviceType) {
    final horizontalPadding = ResponsiveUtils.getPagePadding(context);
    final isTabletOrDesktop =
        ResponsiveUtils.isTablet(context) || ResponsiveUtils.isDesktop(context);

    return Container(
      constraints: BoxConstraints(
        maxWidth: ResponsiveUtils.getMaxContentWidth(context),
      ),
      child: Padding(
        padding: horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Beğendiklerim title - responsive
            Text(
              'Beğendiklerim',
              style: TextStyle(
                fontFamily: 'Instrument Sans',
                fontWeight: FontWeight.w600,
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
                height: 1.0,
                color: const Color(0xFFFFFFFF),
              ),
            ),

            SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 24)),

            // Movies Grid/List - responsive
            if (isTabletOrDesktop)
              _buildMoviesGrid(context, deviceType)
            else
              _buildMoviesList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMoviesGrid(
      BuildContext context, ResponsiveDeviceType deviceType) {
    final columns = ResponsiveUtils.getGridColumns(context);
    final spacing = ResponsiveUtils.getResponsiveSpacing(context, 16);
    final crossAxisSpacing = ResponsiveUtils.getResponsiveSpacing(context, 24);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: spacing,
        mainAxisSpacing: crossAxisSpacing,
        childAspectRatio: 0.7, // Movie card aspect ratio
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
  }

  Widget _buildMoviesList(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Fixed 2 columns for mobile
        const crossAxisCount = 2;
        final availableWidth = constraints.maxWidth;
        final spacing = ResponsiveUtils.getResponsiveSpacing(context, 16);
        final crossAxisSpacing =
            ResponsiveUtils.getResponsiveSpacing(context, 24);

        // Calculate card dimensions with spacing
        final cardWidth = (availableWidth - spacing) / crossAxisCount;
        final imageHeight = cardWidth * (196 / 169); // Maintain aspect ratio
        final textHeight = ResponsiveUtils.getResponsiveSpacing(context, 50);
        final cardHeight = imageHeight + textHeight;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: crossAxisSpacing,
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
