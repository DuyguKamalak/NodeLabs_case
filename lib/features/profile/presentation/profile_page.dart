import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_paddings.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/models/movie_models.dart';
import '../../../../core/services/api_client.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/movie_service.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/common/app_background.dart';
import 'limited_offer_bottom_sheet.dart';
import 'upload_photo_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final MovieService _movieService = MovieService();

  String _userName = 'Kullanıcı';
  String _userIdLabel = 'ID: —';
  String? _photoUrl;

  bool _loadingFavs = true;
  String? _errorFavs;
  final List<Movie> _favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    _hydrateUserHeader(); // ad, id, foto
    _loadFavorites(); // beğendiklerim
  }

  Future<void> _hydrateUserHeader() async {
    final cachedUrl = await AuthService().getPhotoUrlForCurrentUser();
    if (cachedUrl != null && cachedUrl.isNotEmpty && mounted) {
      setState(() => _photoUrl = cachedUrl);
    }

    try {
      final token = await ApiClient.instance.getToken();
      if (token == null) return;

      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://caseapi.servicelabs.tech',
          headers: {'Accept': 'application/json'},
          responseType: ResponseType.json,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      final res = await dio.get(
        '/user/profile',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (!mounted) return;

      if (res.data is Map && res.data['data'] is Map) {
        final data = res.data['data'] as Map;
        final name = (data['name'] ?? '') as String? ?? '';
        final id = (data['id'] ?? data['_id'] ?? '') as String? ?? '';
        final serverUrl = (data['photoUrl'] ?? '') as String? ?? '';

        setState(() {
          if (name.isNotEmpty) _userName = name;
          if (id.isNotEmpty) _userIdLabel = 'ID: $id';
          if (serverUrl.isNotEmpty) _photoUrl = serverUrl;
        });

        if (serverUrl.isNotEmpty) {
          await AuthService().savePhotoUrlForCurrentUser(serverUrl);
        }
      }
    } catch (_) {
      // sessiz geç
    }
  }

  Future<void> _loadFavorites() async {
    setState(() {
      _loadingFavs = true;
      _errorFavs = null;
      _favoriteMovies.clear();
    });
    try {
      final FavoriteListResponse res = await _movieService.getFavorites();
      _favoriteMovies.addAll(res.favorites);
    } catch (e) {
      _errorFavs = e.toString();
    } finally {
      if (mounted) setState(() => _loadingFavs = false);
    }
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
                    _buildHeader(context),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: ResponsiveUtils.getResponsiveSpacing(
                                  context, 11),
                            ),
                            Container(
                              width: double.infinity,
                              height: 1.h,
                              color: AppColors.white5Opacity,
                            ),
                            SizedBox(
                              height: ResponsiveUtils.getResponsiveSpacing(
                                  context, 16),
                            ),
                            _buildLikedSection(context),
                            SizedBox(
                              height: ResponsiveUtils.getResponsiveSpacing(
                                  context, 16),
                            ),
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

  Widget _buildHeader(BuildContext context) {
    final horizontalPadding = ResponsiveUtils.getPagePadding(context);
    final headerHeight = ResponsiveUtils.isMobile(context) ? 60.h : 70.h;
    final profileSectionHeight =
        ResponsiveUtils.isMobile(context) ? 78.h : 88.h;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          // Başlık + Teklif
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
                    AppStrings.profile,
                    style: AppTextStyles.h4(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                    width: ResponsiveUtils.getResponsiveSpacing(context, 16)),
                GestureDetector(
                  onTap: () async => LimitedOfferBottomSheet.show(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          ResponsiveUtils.getResponsiveSpacing(context, 12),
                      vertical:
                          ResponsiveUtils.getResponsiveSpacing(context, 8),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.appleRed,
                      borderRadius: BorderRadius.circular(
                        ResponsiveUtils.getResponsiveBorderRadius(context, 20),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/icon/Component/Components/Gem.svg',
                          width: ResponsiveUtils.getResponsiveIconSize(
                              context, 16),
                          height: ResponsiveUtils.getResponsiveIconSize(
                              context, 16),
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                        SizedBox(
                            width: ResponsiveUtils.getResponsiveSpacing(
                                context, 4)),
                        Text(
                          AppStrings.limitedOffer,
                          style:
                              AppTextStyles.bodySmallSemibold(context).copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Profil satırı
          Container(
            width: double.infinity,
            height: profileSectionHeight,
            padding: horizontalPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfilePhoto(context),
                SizedBox(
                    width: ResponsiveUtils.getResponsiveSpacing(context, 12)),
                Expanded(child: _buildUserInfo(context)),
                SizedBox(
                    width: ResponsiveUtils.getResponsiveSpacing(context, 8)),
                GestureDetector(
                  onTap: () async {
                    final updatedUrl = await Navigator.of(context).push<String>(
                      MaterialPageRoute(
                          builder: (_) => const UploadPhotoPage()),
                    );
                    if (updatedUrl != null && updatedUrl.isNotEmpty) {
                      await AuthService()
                          .savePhotoUrlForCurrentUser(updatedUrl);
                      if (mounted) setState(() => _photoUrl = updatedUrl);
                    }
                    await _loadFavorites();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          ResponsiveUtils.getResponsiveSpacing(context, 16),
                      vertical:
                          ResponsiveUtils.getResponsiveSpacing(context, 10),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white5Opacity,
                      borderRadius: BorderRadius.circular(
                        ResponsiveUtils.getResponsiveBorderRadius(context, 8),
                      ),
                    ),
                    child: Text(
                      AppStrings.addPhoto,
                      style: AppTextStyles.bodyMediumMedium(context).copyWith(
                        color: AppColors.white80,
                      ),
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

  Widget _buildProfilePhoto(BuildContext context) {
    final photoSize = ResponsiveUtils.isMobile(context) ? 56.w : 64.w;

    return Container(
      width: photoSize,
      height: photoSize,
      decoration: const BoxDecoration(
        borderRadius: AppRadius.allCircular,
      ),
      child: ClipRRect(
        borderRadius: AppRadius.allCircular,
        child: (_photoUrl != null && _photoUrl!.isNotEmpty)
            ? Image.network(
                _photoUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.white10,
                  alignment: Alignment.center,
                  child: const Icon(Icons.person, color: AppColors.white),
                ),
              )
            : Container(
                color: Colors.white10,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/icon/Component/Components/Profile.svg',
                  width: 28.w,
                  height: 28.w,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodyLargeSemibold(context),
        ),
        SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 2)),
        Text(
          _userIdLabel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodyMediumMedium(context).copyWith(
            color: AppColors.white60,
          ),
        ),
      ],
    );
  }

  Widget _buildLikedSection(BuildContext context) {
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
            Text(
              AppStrings.likedMovies,
              style: AppTextStyles.bodyXLargeSemibold(context),
            ),
            SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 24)),
            if (_loadingFavs)
              const Center(child: CircularProgressIndicator())
            else if (_errorFavs != null)
              Column(
                children: [
                  Text('${AppStrings.favoritesLoadError}: $_errorFavs',
                      style: AppTextStyles.error(context)),
                  const SizedBox(height: AppPaddings.sm),
                  ElevatedButton(
                    onPressed: _loadFavorites,
                    child: const Text(AppStrings.retryAgain),
                  ),
                ],
              )
            else
              (isTabletOrDesktop
                  ? _buildMoviesGrid(context)
                  : _buildMoviesList(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildMoviesGrid(BuildContext context) {
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
        childAspectRatio: 0.7,
      ),
      itemCount: _favoriteMovies.length,
      itemBuilder: (context, index) {
        final m = _favoriteMovies[index];
        return _MovieThumb(movie: m);
      },
    );
  }

  Widget _buildMoviesList(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const crossAxisCount = 2;
        final availableWidth = constraints.maxWidth;
        final spacing = ResponsiveUtils.getResponsiveSpacing(context, 16);
        final crossAxisSpacing =
            ResponsiveUtils.getResponsiveSpacing(context, 24);

        final cardWidth = (availableWidth - spacing) / crossAxisCount;
        final imageHeight = cardWidth * (196 / 169);
        final textHeight = ResponsiveUtils.getResponsiveSpacing(context, 62);
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
          itemBuilder: (context, index) =>
              _MovieThumb(movie: _favoriteMovies[index]),
        );
      },
    );
  }
}

class _MovieThumb extends StatelessWidget {
  final Movie movie;
  const _MovieThumb({required this.movie});

  @override
  Widget build(BuildContext context) {
    final company = (() {
      try {
        final dyn = (movie as dynamic);
        final p = dyn.production ?? dyn.studio;
        if (p is String && p.trim().isNotEmpty) return p;
      } catch (_) {}
      try {
        final g = (movie as dynamic).genres;
        if (g is List && g.isNotEmpty) {
          final first = g.first;
          if (first is String && first.trim().isNotEmpty) return first;
          if (first != null) return first.toString();
        }
      } catch (_) {}
      return '';
    })();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 169 / 196,
          child: ClipRRect(
            borderRadius: AppRadius.all12,
            child: Image.network(
              movie.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.white10,
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image_outlined),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppPaddings.sm),
        Text(
          movie.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodySmallSemibold(context).copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: AppPaddings.xs / 2),
        if (company.isNotEmpty)
          Text(
            company,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall(context).copyWith(
              color: AppColors.white70,
            ),
          ),
      ],
    );
  }
}
