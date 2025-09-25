import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'auth_models.g.dart';

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class RegisterRequest {
  final String email;
  final String password;
  final String name;

  const RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

/// DİKKAT: Backend auth cevabı şöyle geliyor:
/// {
///   "response": { "code": 200, "message": "" },
///   "data": {
///     "_id": "...",
///     "id": "...",
///     "name": "...",
///     "email": "...",
///     "photoUrl": "",
///     "token": "JWT..."
///   }
/// }
/// Bu nedenle AuthResponse, üstteki 'data' alanından parse ediyor.
class AuthResponse {
  final String token;
  final UserProfile user;

  const AuthResponse({
    required this.token,
    required this.user,
  });

  /// Hem nested (`data`) hem de düz yapıyı destekler.
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> root = json;
    final dynamic dataNode = root['data'];

    if (dataNode is Map<String, dynamic>) {
      final token = dataNode['token'] as String? ?? '';
      // 'user' objesi yoksa, user alanlarını 'data' içinden topla
      final userJson = <String, dynamic>{
        'id': dataNode['id'] ?? dataNode['_id'] ?? '',
        'email': dataNode['email'] ?? '',
        'name': dataNode['name'] ?? '',
        'photoUrl': dataNode['photoUrl'],
      };
      return AuthResponse(
        token: token,
        user: UserProfile.fromJson(userJson),
      );
    } else {
      // Fallback: düz (nested olmayan) yapıyı da destekle
      final token = root['token'] as String? ?? '';
      final userRaw = root['user'];
      final user = (userRaw is Map<String, dynamic>)
          ? UserProfile.fromJson(userRaw)
          : UserProfile.fromJson({
              'id': root['id'] ?? root['_id'] ?? '',
              'email': root['email'] ?? '',
              'name': root['name'] ?? '',
              'photoUrl': root['photoUrl'],
            });
      return AuthResponse(token: token, user: user);
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'token': token,
        'user': user.toJson(),
      };

  @override
  String toString() => jsonEncode(toJson());
}

@JsonSerializable()
class UserProfile {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;

  const UserProfile({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

@JsonSerializable()
class UploadPhotoRequest {
  final String photo;

  const UploadPhotoRequest({
    required this.photo,
  });

  factory UploadPhotoRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadPhotoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UploadPhotoRequestToJson(this);
}

@JsonSerializable()
class UploadPhotoResponse {
  final String photoUrl;

  const UploadPhotoResponse({
    required this.photoUrl,
  });

  factory UploadPhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadPhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadPhotoResponseToJson(this);
}
