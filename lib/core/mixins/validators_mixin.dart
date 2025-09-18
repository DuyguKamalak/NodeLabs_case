import '../constants/app_strings.dart';

/// Form validation mixin
mixin ValidatorsMixin {
  /// E-posta validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldRequired;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return AppStrings.invalidEmail;
    }

    return null;
  }

  /// Şifre validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldRequired;
    }

    if (value.length < 6) {
      return AppStrings.passwordTooShort;
    }

    return null;
  }

  /// Şifre tekrar validation
  String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldRequired;
    }

    if (value != password) {
      return AppStrings.passwordsNotMatch;
    }

    return null;
  }

  /// Ad validation
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldRequired;
    }

    if (value.length < 2) {
      return 'Ad en az 2 karakter olmalıdır';
    }

    if (value.length > 50) {
      return 'Ad en fazla 50 karakter olabilir';
    }

    // Sadece harfler ve boşluk
    final nameRegex = RegExp(r'^[a-zA-ZğüşıöçĞÜŞİÖÇ\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Ad sadece harfler içerebilir';
    }

    return null;
  }

  /// Telefon numarası validation
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldRequired;
    }

    // Türkiye telefon numarası formatı
    final phoneRegex = RegExp(r'^(\+90|0)?[5][0-9]{9}$');
    if (!phoneRegex.hasMatch(value.replaceAll(' ', '').replaceAll('-', ''))) {
      return 'Geçersiz telefon numarası formatı';
    }

    return null;
  }

  /// Zorunlu alan validation
  String? validateRequired(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return fieldName != null
          ? '$fieldName ${AppStrings.fieldRequired.toLowerCase()}'
          : AppStrings.fieldRequired;
    }
    return null;
  }

  /// Minimum uzunluk validation
  String? validateMinLength(String? value, int minLength, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldRequired;
    }

    if (value.length < minLength) {
      return '${fieldName ?? 'Bu alan'} en az $minLength karakter olmalıdır';
    }

    return null;
  }

  /// Maksimum uzunluk validation
  String? validateMaxLength(String? value, int maxLength, [String? fieldName]) {
    if (value != null && value.length > maxLength) {
      return '${fieldName ?? 'Bu alan'} en fazla $maxLength karakter olabilir';
    }

    return null;
  }

  /// Sayı validation
  String? validateNumber(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldRequired;
    }

    if (double.tryParse(value) == null) {
      return '${fieldName ?? 'Bu alan'} geçerli bir sayı olmalıdır';
    }

    return null;
  }

  /// Pozitif sayı validation
  String? validatePositiveNumber(String? value, [String? fieldName]) {
    final numberValidation = validateNumber(value, fieldName);
    if (numberValidation != null) return numberValidation;

    final number = double.parse(value!);
    if (number <= 0) {
      return '${fieldName ?? 'Bu alan'} pozitif bir sayı olmalıdır';
    }

    return null;
  }

  /// URL validation
  String? validateUrl(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldRequired;
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return '${fieldName ?? 'Bu alan'} geçerli bir URL olmalıdır';
    }

    return null;
  }

  /// Tarih validation
  String? validateDate(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldRequired;
    }

    try {
      DateTime.parse(value);
      return null;
    } catch (e) {
      return '${fieldName ?? 'Bu alan'} geçerli bir tarih formatında olmalıdır';
    }
  }

  /// Yaş validation
  String? validateAge(String? value, {int minAge = 0, int maxAge = 120}) {
    final numberValidation = validateNumber(value, 'Yaş');
    if (numberValidation != null) return numberValidation;

    final age = int.parse(value!);
    if (age < minAge || age > maxAge) {
      return 'Yaş $minAge ile $maxAge arasında olmalıdır';
    }

    return null;
  }

  /// Doğum tarihi validation
  String? validateBirthDate(DateTime? value) {
    if (value == null) {
      return AppStrings.fieldRequired;
    }

    final now = DateTime.now();
    final age = now.year - value.year;

    if (value.isAfter(now)) {
      return 'Doğum tarihi gelecek bir tarih olamaz';
    }

    if (age < 13) {
      return 'Yaşınız en az 13 olmalıdır';
    }

    if (age > 120) {
      return 'Geçersiz doğum tarihi';
    }

    return null;
  }

  /// Combination validator - Multiple validators
  String? validateCombined(
      String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) return result;
    }
    return null;
  }
}
