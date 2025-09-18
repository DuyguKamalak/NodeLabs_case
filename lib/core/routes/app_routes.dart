/// Uygulama route isimleri
class AppRoutes {
  AppRoutes._();

  // Splash
  static const String splash = '/splash';

  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  // Main Navigation
  static const String home = '/home';
  static const String profile = '/profile';
  static const String uploadPhoto = '/upload-photo';

  // Home Sub-routes
  static const String homeDetail = '/home/detail';
  static const String homeSearch = '/home/search';

  // Profile Sub-routes
  static const String profileEdit = '/profile/edit';
  static const String profileSettings = '/profile/settings';
  static const String profileChangePassword = '/profile/change-password';

  // Upload Photo Sub-routes
  static const String uploadPhotoCamera = '/upload-photo/camera';
  static const String uploadPhotoGallery = '/upload-photo/gallery';
  static const String uploadPhotoEdit = '/upload-photo/edit';

  // Settings
  static const String settings = '/settings';
  static const String settingsTheme = '/settings/theme';
  static const String settingsLanguage = '/settings/language';
  static const String settingsNotifications = '/settings/notifications';
  static const String settingsPrivacy = '/settings/privacy';
  static const String settingsTerms = '/settings/terms';
  static const String settingsAbout = '/settings/about';

  // Error
  static const String notFound = '/not-found';
  static const String error = '/error';

  /// Tüm route listesi
  static const List<String> allRoutes = [
    splash,
    login,
    register,
    forgotPassword,
    resetPassword,
    home,
    profile,
    uploadPhoto,
    homeDetail,
    homeSearch,
    profileEdit,
    profileSettings,
    profileChangePassword,
    uploadPhotoCamera,
    uploadPhotoGallery,
    uploadPhotoEdit,
    settings,
    settingsTheme,
    settingsLanguage,
    settingsNotifications,
    settingsPrivacy,
    settingsTerms,
    settingsAbout,
    notFound,
    error,
  ];

  /// Auth routes listesi
  static const List<String> authRoutes = [
    login,
    register,
    forgotPassword,
    resetPassword,
  ];

  /// Protected routes listesi (authentication gerekli)
  static const List<String> protectedRoutes = [
    home,
    profile,
    uploadPhoto,
    homeDetail,
    homeSearch,
    profileEdit,
    profileSettings,
    profileChangePassword,
    uploadPhotoCamera,
    uploadPhotoGallery,
    uploadPhotoEdit,
    settings,
    settingsTheme,
    settingsLanguage,
    settingsNotifications,
    settingsPrivacy,
  ];

  /// Public routes listesi (authentication gerekmez)
  static const List<String> publicRoutes = [
    splash,
    login,
    register,
    forgotPassword,
    resetPassword,
    settingsTerms,
    settingsAbout,
    notFound,
    error,
  ];

  /// Route'un protected olup olmadığını kontrol eder
  static bool isProtectedRoute(String route) {
    return protectedRoutes.contains(route);
  }

  /// Route'un auth route olup olmadığını kontrol eder
  static bool isAuthRoute(String route) {
    return authRoutes.contains(route);
  }

  /// Route'un public olup olmadığını kontrol eder
  static bool isPublicRoute(String route) {
    return publicRoutes.contains(route);
  }

  /// Route parametrelerini parse eder
  static Map<String, String> parseRouteParams(String route) {
    final params = <String, String>{};
    final uri = Uri.parse(route);

    // Query parameters
    params.addAll(uri.queryParameters);

    return params;
  }

  /// Route'u query parametreleri ile birleştirir
  static String buildRouteWithParams(
      String route, Map<String, String>? params) {
    if (params == null || params.isEmpty) {
      return route;
    }

    final uri = Uri.parse(route);
    final newUri = uri.replace(queryParameters: params);
    return newUri.toString();
  }

  /// Bottom navigation routes
  static const List<String> bottomNavRoutes = [
    home,
    uploadPhoto,
    profile,
  ];

  /// Route'un bottom navigation'da olup olmadığını kontrol eder
  static bool isBottomNavRoute(String route) {
    return bottomNavRoutes.contains(route);
  }
}
