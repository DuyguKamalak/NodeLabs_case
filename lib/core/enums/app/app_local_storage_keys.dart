/// Local storage için kullanılan anahtar değerleri
enum AppLocalStorageKeys {
  /// Kullanıcı token bilgisi
  userToken('user_token'),

  /// Kullanıcı bilgileri
  userInfo('user_info'),

  /// Tema seçimi (dark/light)
  themeMode('theme_mode'),

  /// Dil seçimi
  languageCode('language_code'),

  /// İlk açılış kontrolü
  isFirstLaunch('is_first_launch'),

  /// Kullanıcı onboarding tamamlama durumu
  onboardingCompleted('onboarding_completed'),

  /// Bildirim izinleri
  notificationPermission('notification_permission'),

  /// Son giriş tarihi
  lastLoginDate('last_login_date'),

  /// Otomatik giriş seçimi
  rememberMe('remember_me'),

  /// Uygulama ayarları
  appSettings('app_settings');

  const AppLocalStorageKeys(this.key);

  /// Storage anahtarı
  final String key;
}
