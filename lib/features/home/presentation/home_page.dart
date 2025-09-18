import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.h4.copyWith(
                  color: AppColors.textPrimary,
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
                  style: AppTextStyles.link,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 280.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: MovieCard(
                  movie: movie,
                  isFavorite: _favoriteMovies.contains(movie.id),
                  onFavoriteTap: () => _toggleFavorite(movie.id),
                  onTap: () {
                    // Navigate to movie details
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('${movie.title} detaylarına gidiliyor...'),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.appName,
                          style: AppTextStyles.h2.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          AppStrings.appTagline,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
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
                            'assets/icons/Components/User.svg',
                            width: 24.w,
                            height: 24.h,
                            colorFilter: const ColorFilter.mode(
                              AppColors.textPrimary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
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
                            'assets/icons/Components/User.svg',
                            width: 24.w,
                            height: 24.h,
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
              ),

              // Tab Bar
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  labelColor: AppColors.white,
                  unselectedLabelColor: AppColors.textSecondary,
                  labelStyle: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: AppTextStyles.labelMedium,
                  tabs: const [
                    Tab(text: 'Popüler'),
                    Tab(text: 'En İyi'),
                    Tab(text: 'Şimdi'),
                    Tab(text: 'Yakında'),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

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
        ),
      ),
    );
  }

  Widget _buildTabContent(List<MovieModel> movies) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          _buildMovieSection(AppStrings.popularMovies, _popularMovies),
          SizedBox(height: 32.h),
          _buildMovieSection(AppStrings.topRated, _topRatedMovies),
          SizedBox(height: 32.h),
          _buildMovieSection(AppStrings.nowPlaying, _nowPlayingMovies),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
