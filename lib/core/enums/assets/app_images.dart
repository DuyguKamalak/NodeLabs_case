/// Uygulama image enums
enum AppImages {
  /// Splash screen background
  splashBackground('assets/images/splash_background.png'),

  /// Default avatar
  defaultAvatar('assets/images/default_avatar.png'),

  /// Empty state illustration
  emptyState('assets/images/empty_state.png'),

  /// Error state illustration
  errorState('assets/images/error_state.png'),

  /// Success state illustration
  successState('assets/images/success_state.png'),

  /// Onboarding first page
  onboarding1('assets/images/onboarding_1.png'),

  /// Onboarding second page
  onboarding2('assets/images/onboarding_2.png'),

  /// Onboarding third page
  onboarding3('assets/images/onboarding_3.png'),

  /// Logo transparent
  logoTransparent('assets/images/logo_transparent.png'),

  /// Logo white
  logoWhite('assets/images/logo_white.png'),

  /// Logo black
  logoBlack('assets/images/logo_black.png'),

  /// Placeholder image
  placeholder('assets/images/placeholder.png'),

  /// No internet illustration
  noInternet('assets/images/no_internet.png'),

  /// Loading animation
  loadingAnimation('assets/images/loading_animation.gif');

  const AppImages(this.path);

  /// Image dosya yolu
  final String path;
}
