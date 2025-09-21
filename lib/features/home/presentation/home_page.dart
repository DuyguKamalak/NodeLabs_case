import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/common/app_background.dart';
import '../../movies/data/models/movie_model.dart';
import '../../movies/presentation/widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  // Mock data - gerçek uygulamada API'den gelecek
  final List<MovieModel> _popularMovies = [];
  final List<MovieModel> _topRatedMovies = [];
  final List<MovieModel> _nowPlayingMovies = [];
  final Set<int> _favoriteMovies = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadMockData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMockData() {
    // Mock data - gerçek uygulamada API'den gelecek
    setState(() {
      _popularMovies.addAll(_generateMockMovies('Popular'));
      _topRatedMovies.addAll(_generateMockMovies('Top Rated'));
      _nowPlayingMovies.addAll(_generateMockMovies('Now Playing'));
    });
  }

  List<MovieModel> _generateMockMovies(String category) {
    return List.generate(10, (index) {
      return MovieModel(
        id: index + 1,
        title: '$category Movie ${index + 1}',
        overview:
            'This is a great movie with an amazing storyline and incredible acting.',
        posterPath: '/poster${index + 1}.jpg',
        backdropPath: '/backdrop${index + 1}.jpg',
        releaseDate: '2024-01-${(index % 28) + 1}',
        voteAverage: 7.0 + (index % 3),
        voteCount: 1000 + (index * 100),
        genreIds: [28, 12, 16],
        adult: false,
        originalLanguage: 'en',
        originalTitle: '$category Movie ${index + 1}',
        popularity: 100.0 + (index * 10),
        hasVideo: false,
      );
    });
  }

  void _toggleFavorite(int movieId) {
    setState(() {
      if (_favoriteMovies.contains(movieId)) {
        _favoriteMovies.remove(movieId);
      } else {
        _favoriteMovies.add(movieId);
      }
    });
  }

  Widget _buildMovieSection(String title, List<MovieModel> movies) {
    return ResponsiveUtils.responsiveBuilder(
      builder: (context, deviceType) {
        final isTabletOrDesktop = ResponsiveUtils.isTablet(context) ||
            ResponsiveUtils.isDesktop(context);
        final horizontalPadding = ResponsiveUtils.getPagePadding(context);
        final cardHeight = ResponsiveUtils.getCardHeight(context, 280);
        final spacing = ResponsiveUtils.getResponsiveSpacing(context, 16);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: horizontalPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.h4(context).copyWith(
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to see all movies
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tüm filmler sayfası yakında!'),
                          backgroundColor: AppColors.info,
                        ),
                      );
                    },
                    child: Text(
                      'Tümünü Gör',
                      style: AppTextStyles.link(context),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spacing),
            // Responsive movie list
            if (isTabletOrDesktop)
              // Grid view for tablet and desktop
              _buildMovieGrid(movies, deviceType)
            else
              // Horizontal list for mobile
              _buildHorizontalMovieList(movies, cardHeight),
          ],
        );
      },
    );
  }

  Widget _buildHorizontalMovieList(List<MovieModel> movies, double cardHeight) {
    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: ResponsiveUtils.getPagePadding(context),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: EdgeInsets.only(
                right: ResponsiveUtils.getResponsiveSpacing(context, 16)),
            child: SizedBox(
              width: ResponsiveUtils.isMobile(context) ? 160.w : 200.w,
              child: MovieCard(
                movie: movie,
                isFavorite: _favoriteMovies.contains(movie.id),
                onFavoriteTap: () => _toggleFavorite(movie.id),
                onTap: () {
                  // Navigate to movie details
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${movie.title} detaylarına gidiliyor...'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMovieGrid(
      List<MovieModel> movies, ResponsiveDeviceType deviceType) {
    final columns = ResponsiveUtils.getGridColumns(context);
    final horizontalPadding = ResponsiveUtils.getPagePadding(context);
    final spacing = ResponsiveUtils.getResponsiveSpacing(context, 16);

    return Container(
      constraints: BoxConstraints(
        maxWidth: ResponsiveUtils.getMaxContentWidth(context),
      ),
      child: Padding(
        padding: horizontalPadding,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: 0.7, // Movie card aspect ratio
          ),
          itemCount: movies.length > 8 ? 8 : movies.length, // Limit grid items
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieCard(
              movie: movie,
              isFavorite: _favoriteMovies.contains(movie.id),
              onFavoriteTap: () => _toggleFavorite(movie.id),
              onTap: () {
                // Navigate to movie details
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${movie.title} detaylarına gidiliyor...'),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
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
                    // App Bar
                    _buildAppBar(context, deviceType),

                    // Tab Bar
                    _buildTabBar(context, deviceType),

                    SizedBox(
                        height:
                            ResponsiveUtils.getResponsiveSpacing(context, 24)),

                    // Content
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildTabContent(_popularMovies),
                          _buildTabContent(_topRatedMovies),
                          _buildTabContent(_nowPlayingMovies),
                          _buildTabContent(
                              _popularMovies), // Placeholder for upcoming
                        ],
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

  Widget _buildAppBar(BuildContext context, ResponsiveDeviceType deviceType) {
    final horizontalPadding = ResponsiveUtils.getPagePadding(context);
    final spacing = ResponsiveUtils.getResponsiveSpacing(context, 8);
    final iconSize = ResponsiveUtils.getResponsiveIconSize(context, 24);

    return Padding(
      padding: horizontalPadding.copyWith(
        top: ResponsiveUtils.getResponsiveSpacing(context, 20),
        bottom: ResponsiveUtils.getResponsiveSpacing(context, 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.appName,
                  style: AppTextStyles.h2(context).copyWith(
                    color: AppColors.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  AppStrings.appTagline,
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // Search functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Arama özelliği yakında!'),
                      backgroundColor: AppColors.info,
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  'assets/icons/icon/Component/Components/User.svg',
                  width: iconSize,
                  height: iconSize,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: spacing),
              IconButton(
                onPressed: () {
                  // Profile functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profil sayfasına gidiliyor...'),
                      backgroundColor: AppColors.info,
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  'assets/icons/icon/Component/Components/User.svg',
                  width: iconSize,
                  height: iconSize,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, ResponsiveDeviceType deviceType) {
    final horizontalPadding = ResponsiveUtils.getPagePadding(context);
    final borderRadius = ResponsiveUtils.getResponsiveBorderRadius(context, 8);

    return Container(
      margin: horizontalPadding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        labelColor: AppColors.white,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTextStyles.labelMedium(context).copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStyles.labelMedium(context),
        isScrollable: ResponsiveUtils.isMobile(context),
        tabs: const [
          Tab(text: 'Popüler'),
          Tab(text: 'En İyi'),
          Tab(text: 'Şimdi'),
          Tab(text: 'Yakında'),
        ],
      ),
    );
  }

  Widget _buildTabContent(List<MovieModel> movies) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          _buildMovieSection(AppStrings.popularMovies, _popularMovies),
          SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 32)),
          _buildMovieSection(AppStrings.topRated, _topRatedMovies),
          SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 32)),
          _buildMovieSection(AppStrings.nowPlaying, _nowPlayingMovies),
          SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 32)),
          // Extra bottom padding for mobile devices
          SizedBox(height: ResponsiveUtils.isMobile(context) ? 100.h : 50.h),
        ],
      ),
    );
  }
}
