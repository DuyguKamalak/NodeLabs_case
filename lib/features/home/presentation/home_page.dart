import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';
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
  int _currentIndex = 0; // ekranda gösterilen film
  bool _isLoading = true;
  String? _error;

  /// Plot (açıklama) için “Devamını oku” aç/kapa
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

  /// Yukarı doğru swipe ile sıradaki filme geç
  Future<void> _nextMovie() async {
    if (_movies.isEmpty) return;

    setState(() {
      _isPlotExpanded = false;
      if (_currentIndex < _movies.length - 1) {
        _currentIndex++;
      } else {
        // listenin sonuna gelindiyse yeniden çek
        _currentIndex = 0;
      }
    });

    // Son 2’ye gelmişsek yeni listeyi arkadan güncelle
    if (_currentIndex >= _movies.length - 2) {
      try {
        final response = await _movieService.getMovieList();
        if (mounted) {
          setState(() {
            _movies = response.movies;
            // mevcut index 0’a resetlenmiyor; kullanıcı devam ediyor
          });
        }
      } catch (_) {
        // hata durumunda sessiz geç
      }
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
          // diğer alanlar varsa ek modelinizde korunur
        );
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Favori güncellenemedi: $e'),
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
        // yalnızca dikey yukarı atımda sonraki filme geç
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity != null &&
              details.primaryVelocity! < -100) {
            _nextMovie();
          }
        },
        child: Stack(
          children: [
            // Arka plan poster
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

            // Karanlık geçiş
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

            // Alt bilgi bloğu
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

            // Favori butonu
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

  Widget _buildMovieInfoSection(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filmler yüklenemedi: $_error',
              style: const TextStyle(color: Colors.redAccent)),
          const SizedBox(height: 8),
          ElevatedButton(
              onPressed: _loadMovies, child: const Text('Tekrar Dene')),
        ],
      );
    }
    final movie = _currentMovie;
    if (movie == null) {
      return const Text('Henüz film bulunmuyor',
          style: TextStyle(color: Colors.white70));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1) KIRMIZI DAİRE içinde Icon1.svg
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFFFF3B30),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/images/Icon1.svg',
            width: 22,
            height: 22,
          ),
        ),
        const SizedBox(width: 12),

        // 2) Başlık + yalnızca Plot ve "Devamını oku"
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const SizedBox(height: 6),

              // Plot (açıklama) – rating YOK
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.description,
                      maxLines: _isPlotExpanded ? 10 : 2,
                      overflow: _isPlotExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      style:
                          const TextStyle(color: Colors.white70, height: 1.2),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () =>
                          setState(() => _isPlotExpanded = !_isPlotExpanded),
                      child: Text(
                        _isPlotExpanded ? 'Gizle' : 'Devamını Oku',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
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
