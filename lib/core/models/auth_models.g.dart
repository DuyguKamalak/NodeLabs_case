// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
    };

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
    };

UploadPhotoRequest _$UploadPhotoRequestFromJson(Map<String, dynamic> json) =>
    UploadPhotoRequest(
      photo: json['photo'] as String,
    );

Map<String, dynamic> _$UploadPhotoRequestToJson(UploadPhotoRequest instance) =>
    <String, dynamic>{
      'photo': instance.photo,
    };

UploadPhotoResponse _$UploadPhotoResponseFromJson(Map<String, dynamic> json) =>
    UploadPhotoResponse(
      photoUrl: json['photoUrl'] as String,
    );

Map<String, dynamic> _$UploadPhotoResponseToJson(
        UploadPhotoResponse instance) =>
    <String, dynamic>{
      'photoUrl': instance.photoUrl,
    };
