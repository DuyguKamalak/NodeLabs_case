// No codegen, no json_serializable: hepsi manuel.

class Movie {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String? releaseDate;
  final double? rating;
  final List<String>? genres;
  final bool isFavorite;

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.releaseDate,
    this.rating,
    this.genres,
    this.isFavorite = false,
  });

  /// Uygulama içi normalleştirilmiş şema
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      imageUrl: (json['imageUrl'] ?? '').toString(),
      releaseDate: json['releaseDate']?.toString(),
      rating: json['rating'] is num
          ? (json['rating'] as num).toDouble()
          : (double.tryParse(json['rating']?.toString() ?? '')),
      genres: (json['genres'] as List?)?.map((e) => e.toString()).toList(),
      isFavorite: (json['isFavorite'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'releaseDate': releaseDate,
        'rating': rating,
        'genres': genres,
        'isFavorite': isFavorite,
      };

  /// Backend’in OMDb benzeri şemasını normalize eder.
  static Movie fromApi(Map<String, dynamic> json) {
    String toHttps(String url) {
      if (url.isEmpty) return url;
      var out = url.trim();
      if (out.startsWith('http://')) {
        out = out.replaceFirst('http://', 'https://');
      }
      return out;
    }

    String image = (json['Poster'] ?? json['imageUrl'] ?? '').toString();
    if (image.isEmpty &&
        json['Images'] is List &&
        (json['Images'] as List).isNotEmpty) {
      final first = (json['Images'] as List).first?.toString() ?? '';
      if (first.isNotEmpty) image = first;
    }
    image = toHttps(image);

    List<String>? genres;
    final genreStr = json['Genre']?.toString();
    if (genreStr != null && genreStr.isNotEmpty) {
      genres = genreStr.split(',').map((e) => e.trim()).toList();
    } else if (json['genres'] is List) {
      genres = (json['genres'] as List).map((e) => e.toString()).toList();
    }

    final ratingStr =
        (json['imdbRating']?.toString() ?? json['rating']?.toString());
    final double? rating =
        ratingStr != null ? double.tryParse(ratingStr) : null;

    return Movie(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      title: (json['Title'] ?? json['title'] ?? '').toString(),
      description: (json['Plot'] ?? json['description'] ?? '').toString(),
      imageUrl: image,
      releaseDate: (json['Released'] ?? json['releaseDate'])?.toString(),
      rating: rating,
      genres: genres,
      isFavorite: (json['isFavorite'] as bool?) ?? false,
    );
  }
}

class MovieListResponse {
  final List<Movie> movies;
  final int totalCount;
  final int currentPage;
  final int totalPages;

  const MovieListResponse({
    required this.movies,
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
  });

  /// Backend: {"response":...,"data":{"movies":[...]}} veya bazen doğrudan {"movies":[...]}
  factory MovieListResponse.fromAnyJson(Map<String, dynamic> root) {
    final data = (root['data'] as Map<String, dynamic>?) ?? root;
    final rawList = (data['movies'] as List?) ?? const [];
    final movies =
        rawList.whereType<Map<String, dynamic>>().map(Movie.fromApi).toList();

    return MovieListResponse(
      movies: movies,
      totalCount: movies.length,
      currentPage: 1,
      totalPages: 1,
    );
  }

  Map<String, dynamic> toJson() => {
        'movies': movies.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'currentPage': currentPage,
        'totalPages': totalPages,
      };
}

/// Basit yerel yanıt modeli (API bu alanları dönmüyor, biz UI için kullanıyoruz)
class FavoriteResponse {
  final bool isFavorite;
  final String message;
  const FavoriteResponse({required this.isFavorite, required this.message});
}

/// /movie/favorites dönüşünü normalize eder
class FavoriteListResponse {
  final List<Movie> favorites;
  final int totalCount;

  const FavoriteListResponse({
    required this.favorites,
    required this.totalCount,
  });

  /// Backend: {"response":...,"data":[{movieJSON}, ...]}
  factory FavoriteListResponse.fromAnyJson(Map<String, dynamic> root) {
    final data = root['data'];
    final list = (data is List ? data : const <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(Movie.fromApi)
        .toList();

    return FavoriteListResponse(favorites: list, totalCount: list.length);
  }

  Map<String, dynamic> toJson() => {
        'favorites': favorites.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
      };
}
