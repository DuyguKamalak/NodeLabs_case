// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_package_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferPackageModel _$OfferPackageModelFromJson(Map<String, dynamic> json) =>
    OfferPackageModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      durationInDays: (json['durationInDays'] as num).toInt(),
      features:
          (json['features'] as List<dynamic>).map((e) => e as String).toList(),
      isPopular: json['isPopular'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      discountedPrice: (json['discountedPrice'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$OfferPackageModelToJson(OfferPackageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'currency': instance.currency,
      'durationInDays': instance.durationInDays,
      'features': instance.features,
      'isPopular': instance.isPopular,
      'isActive': instance.isActive,
      'discountPercentage': instance.discountPercentage,
      'discountedPrice': instance.discountedPrice,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
