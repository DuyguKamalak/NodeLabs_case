// Lib/core/services/api_service.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/auth_models.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://caseapi.servicelabs.tech")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // -------- Auth --------
  @POST("/user/login")
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST("/user/register")
  Future<AuthResponse> register(@Body() RegisterRequest request);

  @GET("/user/profile")
  Future<UserProfile> getProfile(@Header("Authorization") String token);

  // -------- Movies --------
  @GET("/movie/list")
  Future<dynamic> getMovieList(@Header("Authorization") String token);

  @POST("/movie/favorite/{favoriteId}")
  Future<void> toggleFavorite(
    @Header("Authorization") String token,
    @Path("favoriteId") String movieId,
  );

  @GET("/movie/favorites")
  Future<dynamic> getFavorites(@Header("Authorization") String token);
}
