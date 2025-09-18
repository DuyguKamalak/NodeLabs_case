/// Uygulama icon enums
enum AppIcons {
  /// Ana uygulama ikonu
  logo('assets/icons/logo.svg'),

  /// Home ikonu
  home('assets/icons/home.svg'),

  /// Profile ikonu
  profile('assets/icons/profile.svg'),

  /// Upload ikonu
  upload('assets/icons/upload.svg'),

  /// Search ikonu
  search('assets/icons/search.svg'),

  /// Settings ikonu
  settings('assets/icons/settings.svg'),

  /// Back ikonu
  back('assets/icons/back.svg'),

  /// Close ikonu
  close('assets/icons/close.svg'),

  /// Edit ikonu
  edit('assets/icons/edit.svg'),

  /// Delete ikonu
  delete('assets/icons/delete.svg'),

  /// Like ikonu
  like('assets/icons/like.svg'),

  /// Share ikonu
  share('assets/icons/share.svg'),

  /// Comment ikonu
  comment('assets/icons/comment.svg'),

  /// Notification ikonu
  notification('assets/icons/notification.svg'),

  /// Eye ikonu
  eye('assets/icons/eye.svg'),

  /// Eye off ikonu
  eyeOff('assets/icons/eye_off.svg'),

  /// Camera ikonu
  camera('assets/icons/camera.svg'),

  /// Gallery ikonu
  gallery('assets/icons/gallery.svg'),

  /// Google ikonu
  google('assets/icons/google.svg'),

  /// Apple ikonu
  apple('assets/icons/apple.svg'),

  /// Facebook ikonu
  facebook('assets/icons/facebook.svg'),

  /// Twitter ikonu
  twitter('assets/icons/twitter.svg');

  const AppIcons(this.path);

  /// Icon dosya yolu
  final String path;
}
