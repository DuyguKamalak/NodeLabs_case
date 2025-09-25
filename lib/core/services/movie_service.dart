import 'api_client.dart';
import '../models/movie_models.dart';

class MovieService {
  final ApiClient _apiClient = ApiClient.instance;

  Future<MovieListResponse> getMovieList() async {
    final token = await _apiClient.getToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }

    final raw = await _apiClient.apiService.getMovieList('Bearer $token');
    return MovieListResponse.fromAnyJson(raw);
  }

  /// API dönüşünü kullanmıyoruz; sadece isteği atıp UI'da mevcut durumu tersliyoruz.
  Future<FavoriteResponse> toggleFavorite(String movieId, bool current) async {
    final token = await _apiClient.getToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }
    await _apiClient.apiService.toggleFavorite('Bearer $token', movieId);
    return FavoriteResponse(isFavorite: !current, message: 'ok');
  }

  Future<FavoriteListResponse> getFavorites() async {
    final token = await _apiClient.getToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }
    final raw = await _apiClient.apiService.getFavorites('Bearer $token');
    return FavoriteListResponse.fromAnyJson(raw);
  }
}
