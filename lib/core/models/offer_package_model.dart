import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offer_package_model.g.dart';

/// Teklif paketi modeli
@JsonSerializable()
class OfferPackageModel extends Equatable {
  /// Paket ID
  final String id;

  /// Paket adı
  final String name;

  /// Paket açıklaması
  final String description;

  /// Paket fiyatı
  final double price;

  /// Para birimi
  final String currency;

  /// Paket süresi (gün)
  final int durationInDays;

  /// Paket özellikleri
  final List<String> features;

  /// Popüler paket mi
  final bool isPopular;

  /// Aktif mi
  final bool isActive;

  /// İndirim oranı (%)
  final double? discountPercentage;

  /// İndirimli fiyat
  final double? discountedPrice;

  /// Oluşturulma tarihi
  final DateTime createdAt;

  /// Güncellenme tarihi
  final DateTime updatedAt;

  const OfferPackageModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.durationInDays,
    required this.features,
    this.isPopular = false,
    this.isActive = true,
    this.discountPercentage,
    this.discountedPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  /// JSON'dan model oluşturur
  factory OfferPackageModel.fromJson(Map<String, dynamic> json) =>
      _$OfferPackageModelFromJson(json);

  /// Model'i JSON'a çevirir
  Map<String, dynamic> toJson() => _$OfferPackageModelToJson(this);

  /// Model kopyalama
  OfferPackageModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? currency,
    int? durationInDays,
    List<String>? features,
    bool? isPopular,
    bool? isActive,
    double? discountPercentage,
    double? discountedPrice,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OfferPackageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      durationInDays: durationInDays ?? this.durationInDays,
      features: features ?? this.features,
      isPopular: isPopular ?? this.isPopular,
      isActive: isActive ?? this.isActive,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Günlük fiyat hesaplama
  double get dailyPrice => price / durationInDays;

  /// İndirimli günlük fiyat hesaplama
  double get discountedDailyPrice =>
      (discountedPrice ?? price) / durationInDays;

  /// Toplam tasarruf miktarı
  double get totalSavings =>
      discountedPrice != null ? price - discountedPrice! : 0;

  /// Formatlanmış fiyat string'i
  String get formattedPrice => '$price $currency';

  /// Formatlanmış indirimli fiyat string'i
  String get formattedDiscountedPrice =>
      discountedPrice != null ? '$discountedPrice $currency' : formattedPrice;

  /// Paket süresini gün/ay/yıl olarak formatlar
  String get formattedDuration {
    if (durationInDays < 30) {
      return '$durationInDays gün';
    } else if (durationInDays < 365) {
      final months = (durationInDays / 30).round();
      return '$months ay';
    } else {
      final years = (durationInDays / 365).round();
      return '$years yıl';
    }
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        currency,
        durationInDays,
        features,
        isPopular,
        isActive,
        discountPercentage,
        discountedPrice,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'OfferPackageModel('
        'id: $id, '
        'name: $name, '
        'price: $price, '
        'currency: $currency, '
        'durationInDays: $durationInDays, '
        'isPopular: $isPopular, '
        'isActive: $isActive'
        ')';
  }
}
