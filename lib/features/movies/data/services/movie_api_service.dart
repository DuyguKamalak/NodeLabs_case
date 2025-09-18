import 'package:dio/dio.dart';
import '../models/movie_model.dart';

class MovieApiService {
  final Dio _dio;
  static const String baseUrl = "https://api.themoviedb.org/3/";
  static const String apiKey =
      "your_api_key_here"; // Replace with actual API key

  MovieApiService(this._dio);

  Future<MovieResponse> getPopularMovies({
    int page = 1,
    String language = 'tr-TR',
  }) async {
    try {
      final response = await _dio.get(
        '${baseUrl}movie/popular',
        queryParameters: {
          'api_key': apiKey,
          'page': page,
          'language': language,
        },
      );
      return MovieResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load popular movies: $e');
    }
  }

  Future<MovieResponse> getTopRatedMovies({
    int page = 1,
    String language = 'tr-TR',
  }) async {
    try {
      final response = await _dio.get(
        '${baseUrl}movie/top_rated',
        queryParameters: {
          'api_key': apiKey,
          'page': page,
          'language': language,
        },
      );
      return MovieResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load top rated movies: $e');
    }
  }

  Future<MovieResponse> getNowPlayingMovies({
    int page = 1,
    String language = 'tr-TR',
  }) async {
    try {
      final response = await _dio.get(
        '${baseUrl}movie/now_playing',
        queryParameters: {
          'api_key': apiKey,
          'page': page,
          'language': language,
        },
      );
      return MovieResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load now playing movies: $e');
    }
  }

  Future<MovieResponse> getUpcomingMovies({
    int page = 1,
    String language = 'tr-TR',
  }) async {
    try {
      final response = await _dio.get(
        '${baseUrl}movie/upcoming',
        queryParameters: {
          'api_key': apiKey,
          'page': page,
          'language': language,
        },
      );
      return MovieResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load upcoming movies: $e');
    }
  }

  Future<MovieModel> getMovieDetails({
    required int movieId,
    String language = 'tr-TR',
  }) async {
    try {
      final response = await _dio.get(
        '${baseUrl}movie/$movieId',
        queryParameters: {
          'api_key': apiKey,
          'language': language,
        },
      );
      return MovieModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }
}

class MovieResponse {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  const MovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      page: json['page'] ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((item) => MovieModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((movie) => movie.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}
