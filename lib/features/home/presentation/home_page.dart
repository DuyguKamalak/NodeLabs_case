import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_paddings.dart';
import '../../../../core/models/movie_models.dart';
import '../../../../core/services/movie_service.dart';
import '../../../../core/utils/responsive_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final MovieService _movieService = MovieService();

  List<Movie> _movies = [];
  int _currentIndex = 0;
  bool _isLoading = true;
  String? _error;

  bool _isPlotExpanded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final response = await _movieService.getMovieList();
      setState(() {
        _movies = response.movies;
        _currentIndex = 0;
        _isLoading = false;
        _isPlotExpanded = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Movie? get _currentMovie =>
      (_movies.isEmpty || _currentIndex < 0 || _currentIndex >= _movies.length)
          ? null
          : _movies[_currentIndex];

  Future<void> _nextMovie() async {
    if (_movies.isEmpty) return;

    setState(() {
      _isPlotExpanded = false;
      if (_currentIndex < _movies.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
    });

    if (_currentIndex >= _movies.length - 2) {
      try {
        final response = await _movieService.getMovieList();
        if (mounted) {
          setState(() {
            _movies = response.movies;
          });
        }
      } catch (_) {}
    }
  }

  Future<void> _toggleFavorite(String movieId) async {
    try {
      final index = _movies.indexWhere((m) => m.id == movieId);
      if (index == -1) return;
      final current = _movies[index].isFavorite;

      final resp = await _movieService.toggleFavorite(movieId, current);

      setState(() {
        final m = _movies[index];
        _movies[index] = Movie(
          id: m.id,
          title: m.title,
          description: m.description,
          imageUrl: m.imageUrl,
          releaseDate: m.releaseDate,
          rating: m.rating,
          genres: m.genres,
          isFavorite: resp.isFavorite,
        );
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppStrings.uploadFailed}: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Offset _figmaPos(BuildContext c,
      {required double left, required double top}) {
    const figmaW = 402.0, figmaH = 874.0;
    final size = MediaQuery.of(c).size;
    return Offset(size.width * (left / figmaW), size.height * (top / figmaH));
  }

  @override
  Widget build(BuildContext context) {
    final movie = _currentMovie;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity != null &&
              details.primaryVelocity! < -100) {
            _nextMovie();
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: movie == null
                  ? Container(color: Colors.black)
                  : Image.network(
                      movie.imageUrl,
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomLeft,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (_, __, ___) =>
                          Container(color: Colors.black),
                    ),
            ),
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.35, 0.75, 0.88],
                    colors: [
                      Color.fromRGBO(9, 9, 9, 0.3),
                      Color.fromRGBO(9, 9, 9, 0.0),
                      Color.fromRGBO(9, 9, 9, 0.0),
                      Color.fromRGBO(9, 9, 9, 0.9),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: ResponsiveUtils.getBottomNavHeight(context) +
                  MediaQuery.of(context).padding.bottom +
                  16,
              child: SafeArea(
                top: false,
                bottom: false,
                child: Padding(
                  padding: ResponsiveUtils.getPagePadding(context).copyWith(
                    bottom: ResponsiveUtils.getResponsiveSpacing(context, 12),
                  ),
                  child: _buildMovieInfoSection(context),
                ),
              ),
            ),
            if (movie != null)
              Builder(
                builder: (context) {
                  final p = _figmaPos(context, left: 326, top: 611);
                  return Positioned(
                    left: p.dx,
                    top: p.dy,
                    child: _FavoriteButton(
                      isFavorite: movie.isFavorite,
                      onTap: () => _toggleFavorite(movie.id),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  // ===================== Yardımcılar (inline link için) =====================

  String _normalizeWhitespace(String input) {
    return input
        .replaceAll('\u00A0', ' ')
        .replaceAll('\u2007', ' ')
        .replaceAll('\u202F', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  String _truncateToWordSafe(String s) {
    final trimmed = s.trimRight();
    final matches = RegExp(r'\s').allMatches(trimmed).toList();
    if (matches.isNotEmpty) {
      final last = matches.last.start;
      if (last > 0) return trimmed.substring(0, last);
    }
    if (trimmed.length > 6) return trimmed.substring(0, trimmed.length - 6);
    return trimmed;
  }

  /// Açıklamayı **iki satıra**, en sonda `linkText` ile birlikte sığdırır.
  String _fitTextForTwoLines({
    required String text,
    required double maxWidth,
    required TextStyle baseStyle,
    required TextStyle linkStyle,
    required String linkText,
  }) {
    final normalized = _normalizeWhitespace(text);

    // Bir miktar güvenlik payı: ölçüm ve gerçek çizimde küçük farklar olabiliyor.
    final safeWidth = (maxWidth - 8).clamp(0.0, maxWidth);

    int low = 0, high = normalized.length, best = 0;

    bool fits(int len) {
      final base = normalized.substring(0, len).trimRight();
      final tp = TextPainter(
        text: TextSpan(
          children: [
            TextSpan(text: base, style: baseStyle),
            const TextSpan(text: ' '),
            TextSpan(text: linkText, style: linkStyle),
          ],
        ),
        maxLines: 2,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: safeWidth);
      return !tp.didExceedMaxLines;
    }

    while (low <= high) {
      final mid = (low + high) >> 1;
      if (fits(mid)) {
        best = mid;
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }

    return _truncateToWordSafe(normalized.substring(0, best));
  }

  // ==========================================================================

  Widget _buildMovieInfoSection(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${AppStrings.uploadFailed}: $_error',
              style: AppTextStyles.error(context)),
          const SizedBox(height: AppPaddings.sm),
          ElevatedButton(
              onPressed: _loadMovies, child: const Text(AppStrings.retryAgain)),
        ],
      );
    }
    final movie = _currentMovie;
    if (movie == null) {
      return Text(AppStrings.loading,
          style: AppTextStyles.bodyMedium(context)
              .copyWith(color: AppColors.white70));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Kırmızı daire + küçük N logosu
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppColors.appleRed,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/images/Icon1.svg',
            width: 20,
            height: 17,
          ),
        ),
        const SizedBox(width: 16),

        // Başlık + açıklama (inline link)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Başlık
              Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppPaddings.xs),

              // Açıklama: kapalıyken iki satır + SONDA link
              LayoutBuilder(
                builder: (context, constraints) {
                  const baseStyle =
                      TextStyle(color: Colors.white70, height: 1.2);
                  const linkStyle = TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    // underline istenmiyor
                    decoration: TextDecoration.none,
                  );
                  final linkText = _isPlotExpanded ? 'Gizle' : 'Devamını Oku';

                  if (_isPlotExpanded) {
                    final full = _normalizeWhitespace(movie.description);
                    return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: full, style: baseStyle),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: linkText,
                            style: linkStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => setState(() => _isPlotExpanded = false),
                          ),
                        ],
                      ),
                    );
                  } else {
                    final fittedBase = _fitTextForTwoLines(
                      text: movie.description,
                      maxWidth: constraints.maxWidth,
                      baseStyle: baseStyle,
                      linkStyle: linkStyle,
                      linkText: linkText,
                    );

                    return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: fittedBase, style: baseStyle),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: linkText,
                            style: linkStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => setState(() => _isPlotExpanded = true),
                          ),
                        ],
                      ),
                      maxLines: 2,
                      // güvenlik payı koyduğumuz için ellipsis'e gerek yok
                      overflow: TextOverflow.clip,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const _FavoriteButton({required this.isFavorite, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: 0.95,
        child: SizedBox(
          width: 52,
          height: 72,
          child: SvgPicture.asset(
            isFavorite
                ? 'assets/icons/fav_button/Type=Liked.svg'
                : 'assets/icons/fav_button/Type=Default.svg',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
