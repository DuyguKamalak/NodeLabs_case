import 'dart:ui'; // <-- Blur için eklendi
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/text_form_field/app_text_form_field.dart';
import '../../../core/widgets/common/app_background.dart';
import '../../../core/services/auth_service.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _acceptTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate() && _acceptTerms) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _authService.registerWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          name: _firstNameController.text.trim(),
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Kayıt başarılı!'),
              backgroundColor: AppColors.success,
            ),
          );

          // Navigate to main page after successful registration
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              Navigator.of(context).pushReplacementNamed('/main');
            }
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Kayıt başarısız: ${e.toString()}'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen kullanıcı sözleşmesini kabul edin'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _handleGoogleRegister() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.signInWithGoogle();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Google ile kayıt başarılı!'),
            backgroundColor: AppColors.success,
          ),
        );

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.of(context).pushReplacementNamed('/main');
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google kaydı başarısız: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleFacebookRegister() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.signInWithFacebook();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Facebook ile kayıt başarılı!'),
            backgroundColor: AppColors.success,
          ),
        );

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.of(context).pushReplacementNamed('/main');
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Facebook kaydı başarısız: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Shine Effect genişliği için ekran boyutu
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: AppBackground(
        child: Stack(
          children: [
            // Üst blur
            Positioned(
              top: ResponsiveUtils.isMobile(context) ? 20 : -80,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Center(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: ResponsiveUtils.isMobile(context) ? 40.6 : 60.0,
                      sigmaY: ResponsiveUtils.isMobile(context) ? 40.6 : 60.0,
                    ),
                    child: SvgPicture.asset(
                      'assets/images/Shine Effect.svg',
                      width: size.width *
                          (ResponsiveUtils.isMobile(context) ? 0.92 : 0.8),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            SafeArea(
              child: ResponsiveUtils.responsiveBuilder(
                builder: (context, deviceType) {
                  return ResponsiveUtils.constrainedContainer(
                    context: context,
                    child: SingleChildScrollView(
                      padding: ResponsiveUtils.getPagePadding(context),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                                height: ResponsiveUtils.getResponsiveSpacing(
                                    context, 20)),

                            // Logo ve Text Container - responsive
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Logo - responsive
                                  SvgPicture.asset(
                                    'assets/images/icon.svg',
                                    width: ResponsiveUtils.isMobile(context)
                                        ? 78.w
                                        : 88.w,
                                    height: ResponsiveUtils.isMobile(context)
                                        ? 78.h
                                        : 88.h,
                                  ),

                                  SizedBox(
                                      height:
                                          ResponsiveUtils.getResponsiveSpacing(
                                              context, 24)),

                                  // "Hesap Oluştur" Text - responsive
                                  Text(
                                    'Hesap Oluştur',
                                    style: AppTextStyles.h4(context).copyWith(
                                      color: AppColors.white,
                                      fontSize:
                                          ResponsiveUtils.getResponsiveFontSize(
                                              context, 24),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  SizedBox(
                                      height:
                                          ResponsiveUtils.getResponsiveSpacing(
                                              context, 8)),

                                  // "Kullanıcı bilgilerinle kaydol" Text - responsive
                                  Text(
                                    'Kullanıcı bilgilerinle kaydol',
                                    style: AppTextStyles.bodyMedium(context)
                                        .copyWith(
                                      color: AppColors.white90,
                                      fontSize:
                                          ResponsiveUtils.getResponsiveFontSize(
                                              context, 14),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                                height: ResponsiveUtils.getResponsiveSpacing(
                                    context, 24)),

                            // Form Fields - responsive
                            _buildFormFields(context, deviceType),

                            SizedBox(
                                height: ResponsiveUtils.getResponsiveSpacing(
                                    context, 24)),

                            // Terms and Conditions Checkbox - responsive
                            _buildTermsCheckbox(context),

                            SizedBox(
                                height: ResponsiveUtils.getResponsiveSpacing(
                                    context, 24)),

                            // Register Button - responsive
                            AppButton(
                              text:
                                  _isLoading ? 'Kayıt yapılıyor...' : 'Kaydol',
                              onPressed: _isLoading ? null : _handleRegister,
                              type: AppButtonType.primary,
                            ),

                            SizedBox(
                                height: ResponsiveUtils.getResponsiveSpacing(
                                    context, 24)),

                            // Social Login Buttons - responsive
                            _buildSocialButtons(context, deviceType),

                            SizedBox(
                                height: ResponsiveUtils.getResponsiveSpacing(
                                    context, 24)),

                            // Login Link - responsive
                            _buildLoginLink(context),

                            SizedBox(
                                height: ResponsiveUtils.getResponsiveSpacing(
                                    context, 40)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields(
      BuildContext context, ResponsiveDeviceType deviceType) {
    final fieldWidth =
        ResponsiveUtils.isMobile(context) ? double.infinity : 400.w;
    final spacing = ResponsiveUtils.getResponsiveSpacing(context, 24);

    return Column(
      children: [
        // Ad Soyad Field
        Center(
          child: SizedBox(
            width: fieldWidth,
            child: AppTextFormField(
              controller: _firstNameController,
              labelText: 'Ad Soyad',
              hintText: 'Ad ve soyadınızı girin',
              prefixIcon: SvgPicture.asset(
                'assets/icons/icon/Component/Components/User.svg',
                width: ResponsiveUtils.getResponsiveIconSize(context, 18),
                height: ResponsiveUtils.getResponsiveIconSize(context, 16),
                colorFilter: const ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ad soyad gerekli';
                }
                return null;
              },
            ),
          ),
        ),

        SizedBox(height: spacing),

        // Email Field
        Center(
          child: SizedBox(
            width: fieldWidth,
            child: AppTextFormField(
              controller: _emailController,
              labelText: 'E-Posta',
              hintText: 'E-posta adresinizi girin',
              prefixIcon: SvgPicture.asset(
                'assets/icons/icon/Component/Components/Mail.svg',
                width: ResponsiveUtils.getResponsiveIconSize(context, 18),
                height: ResponsiveUtils.getResponsiveIconSize(context, 16),
                colorFilter: const ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'E-posta adresi gerekli';
                }
                if (!value.contains('@')) {
                  return 'Geçerli bir e-posta adresi girin';
                }
                return null;
              },
            ),
          ),
        ),

        SizedBox(height: spacing),

        // Password Field
        Center(
          child: SizedBox(
            width: fieldWidth,
            child: AppTextFormField(
              controller: _passwordController,
              labelText: 'Şifre',
              hintText: 'Şifrenizi girin',
              prefixIcon: SvgPicture.asset(
                'assets/icons/icon/Component/Components/Lock.svg',
                width: ResponsiveUtils.getResponsiveIconSize(context, 18),
                height: ResponsiveUtils.getResponsiveIconSize(context, 16),
                colorFilter: const ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  _isPasswordVisible
                      ? 'assets/icons/icon/Component/Components/See.svg'
                      : 'assets/icons/icon/Component/Components/Hide.svg',
                  width: ResponsiveUtils.getResponsiveIconSize(context, 18),
                  height: ResponsiveUtils.getResponsiveIconSize(context, 16),
                  colorFilter: const ColorFilter.mode(
                    AppColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              obscureText: !_isPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Şifre gerekli';
                }
                if (value.length < 6) {
                  return 'Şifre en az 6 karakter olmalı';
                }
                return null;
              },
            ),
          ),
        ),

        SizedBox(height: spacing),

        // Confirm Password Field
        Center(
          child: SizedBox(
            width: fieldWidth,
            child: AppTextFormField(
              controller: _confirmPasswordController,
              labelText: 'Şifre Tekrar',
              hintText: 'Şifrenizi tekrar girin',
              prefixIcon: SvgPicture.asset(
                'assets/icons/icon/Component/Components/Lock.svg',
                width: ResponsiveUtils.getResponsiveIconSize(context, 18),
                height: ResponsiveUtils.getResponsiveIconSize(context, 16),
                colorFilter: const ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  _isConfirmPasswordVisible
                      ? 'assets/icons/icon/Component/Components/See.svg'
                      : 'assets/icons/icon/Component/Components/Hide.svg',
                  width: ResponsiveUtils.getResponsiveIconSize(context, 18),
                  height: ResponsiveUtils.getResponsiveIconSize(context, 16),
                  colorFilter: const ColorFilter.mode(
                    AppColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
              obscureText: !_isConfirmPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Şifre tekrarı gerekli';
                }
                if (value != _passwordController.text) {
                  return 'Şifreler eşleşmiyor';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _acceptTerms = !_acceptTerms;
            });
          },
          child: Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: _acceptTerms ? AppColors.primary : AppColors.border,
                width: 1.5,
              ),
              color: _acceptTerms ? AppColors.primary : Colors.transparent,
            ),
            child: _acceptTerms
                ? SvgPicture.asset(
                    'assets/icons/input/Checked=Yes.svg',
                    width: 12.w,
                    height: 12.w,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  )
                : SvgPicture.asset(
                    'assets/icons/input/Checked=No.svg',
                    width: 12.w,
                    height: 12.w,
                    colorFilter: const ColorFilter.mode(
                      AppColors.border,
                      BlendMode.srcIn,
                    ),
                  ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: AppTextStyles.bodySmall(context).copyWith(
                color: AppColors.white60,
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12),
              ),
              children: [
                const TextSpan(text: 'Kullanıcı sözleşmesini '),
                TextSpan(
                  text: 'Okudum ve Kabul ediyorum',
                  style: AppTextStyles.bodySmallBold(context).copyWith(
                    color: AppColors.white,
                    fontSize:
                        ResponsiveUtils.getResponsiveFontSize(context, 12),
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.white,
                  ),
                ),
                const TextSpan(
                    text: '. Bu sözleşmeyi okuyarak devam ediniz lütfen.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButtons(
      BuildContext context, ResponsiveDeviceType deviceType) {
    final spacing = ResponsiveUtils.getResponsiveSpacing(context, 15);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          context,
          iconPath: 'assets/icons/icon/Component/Components/Google.svg',
          onTap: _isLoading ? null : _handleGoogleRegister,
        ),
        SizedBox(width: spacing),
        _buildSocialButton(
          context,
          iconPath: 'assets/icons/icon/Component/Components/Apple.svg',
          onTap: _isLoading
              ? null
              : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Apple kaydı yakında!'),
                      backgroundColor: AppColors.info,
                    ),
                  );
                },
        ),
        SizedBox(width: spacing),
        _buildSocialButton(
          context,
          iconPath: 'assets/icons/icon/Component/Components/Facebook.svg',
          onTap: _isLoading ? null : _handleFacebookRegister,
        ),
      ],
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hesabın var mı?',
          style: AppTextStyles.bodyMedium(context).copyWith(
            color: AppColors.white60,
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
          ),
        ),
        TextButton(
          onPressed: _navigateToLogin,
          child: Text(
            'Giriş Yap',
            style: AppTextStyles.bodyMediumSemibold(context).copyWith(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    BuildContext context, {
    required String iconPath,
    required VoidCallback? onTap,
  }) {
    final buttonSize = ResponsiveUtils.getResponsiveIconSize(context, 60);
    final iconSize = ResponsiveUtils.getResponsiveIconSize(context, 24);
    final borderRadius = ResponsiveUtils.getResponsiveBorderRadius(context, 12);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: onTap == null
              ? AppColors.surface.withOpacity(0.5)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: AppColors.border,
            width: ResponsiveUtils.isMobile(context) ? 1.w : 1.5.w,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: iconSize,
            height: iconSize,
            colorFilter: ColorFilter.mode(
              onTap == null
                  ? AppColors.white.withOpacity(0.5)
                  : AppColors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
