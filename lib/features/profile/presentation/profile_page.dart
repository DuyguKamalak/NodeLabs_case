import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/common/app_background.dart';
import '../../movies/data/models/movie_model.dart';
import '../../movies/presentation/widgets/movie_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Mock data
  final String _userName = 'John Doe';
  final String _userEmail = 'john.doe@example.com';
  final List<MovieModel> _favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadMockData();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    ));

    _animationController.forward();
  }

  void _loadMockData() {
    // Mock favorite movies
    setState(() {
      _favoriteMovies.addAll(List.generate(6, (index) {
        return MovieModel(
          id: index + 1,
          title: 'Favorite Movie ${index + 1}',
          overview: 'This is one of my favorite movies.',
          posterPath: '/poster${index + 1}.jpg',
          backdropPath: '/backdrop${index + 1}.jpg',
          releaseDate: '2024-01-${(index % 28) + 1}',
          voteAverage: 8.0 + (index % 2),
          voteCount: 2000 + (index * 200),
          genreIds: [28, 12, 16],
          adult: false,
          originalLanguage: 'en',
          originalTitle: 'Favorite Movie ${index + 1}',
          popularity: 200.0 + (index * 20),
          hasVideo: false,
        );
      }));
    });
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 400,
        maxHeight: 400,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppStrings.uploadSuccess),
              backgroundColor: AppColors.success,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppStrings.uploadError),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Center(
                    child: Column(
                      children: [
                        // Profile Image
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 120.w,
                            height: 120.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 3.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 20.r,
                                  offset: Offset(0, 8.h),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: _profileImage != null
                                  ? Image.file(
                                      _profileImage!,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      color: AppColors.surface,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/icons/Components/User.svg',
                                          width: 40.w,
                                          height: 40.h,
                                          colorFilter: const ColorFilter.mode(
                                            AppColors.textSecondary,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Upload Button
                        TextButton.icon(
                          onPressed: _pickImage,
                          icon: SvgPicture.asset(
                            'assets/icons/Type=Upload.svg',
                            width: 16.w,
                            height: 16.h,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          label: Text(
                            _profileImage != null
                                ? AppStrings.changePhoto
                                : AppStrings.uploadPhoto,
                            style: AppTextStyles.link,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                // User Info
                SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.border,
                        width: 1.w,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profil Bilgileri',
                          style: AppTextStyles.h5.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _buildInfoRow('Ad Soyad', _userName),
                        SizedBox(height: 12.h),
                        _buildInfoRow('E-posta', _userEmail),
                        SizedBox(height: 12.h),
                        _buildInfoRow('Üyelik Tarihi', '15 Ocak 2024'),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                // Favorite Movies Section
                SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.likedMovies,
                            style: AppTextStyles.h5.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to all favorites
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Tüm favoriler sayfası yakında!'),
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
                      SizedBox(height: 16.h),
                      if (_favoriteMovies.isEmpty)
                        Container(
                          height: 200.h,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.border,
                              width: 1.w,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/Type=Default.svg',
                                  width: 48.w,
                                  height: 48.h,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.textSecondary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'Henüz favori filminiz yok',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        SizedBox(
                          height: 280.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _favoriteMovies.length,
                            itemBuilder: (context, index) {
                              final movie = _favoriteMovies[index];
                              return Padding(
                                padding: EdgeInsets.only(right: 16.w),
                                child: MovieCard(
                                  movie: movie,
                                  isFavorite: true,
                                  onFavoriteTap: () {
                                    setState(() {
                                      _favoriteMovies.removeAt(index);
                                    });
                                  },
                                  onTap: () {
                                    // Navigate to movie details
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            '${movie.title} detaylarına gidiliyor...'),
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
                  ),
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
