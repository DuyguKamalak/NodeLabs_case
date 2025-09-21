import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/text_form_field/app_text_form_field.dart';
import '../../../core/widgets/common/app_background.dart';
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
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate() && _acceptTerms) {
      // Register logic implemented
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
    } else if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen kullanıcı sözleşmesini kabul edin'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
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
                                  height: ResponsiveUtils.getResponsiveSpacing(
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
                                  height: ResponsiveUtils.getResponsiveSpacing(
                                      context, 8)),

                              // "Kullanıcı bilgilerinle kaydol" Text - responsive
                              Text(
                                'Kullanıcı bilgilerinle kaydol',
                                style:
                                    AppTextStyles.bodyMedium(context).copyWith(
                                  color: AppColors.white.withOpacity(0.9),
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

                        // Terms and Conditions Checkbox - responsive
                        _buildTermsCheckbox(context),

                        SizedBox(
                            height: ResponsiveUtils.getResponsiveSpacing(
                                context, 24)),

                        // Register Button - responsive
                        AppButton(
                          text: 'Kaydol',
                          onPressed: _handleRegister,
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
      ),
    );
  }

  Widget _buildFormFields(
      BuildContext context, ResponsiveDeviceType deviceType) {
    final fieldWidth =
        ResponsiveUtils.isMobile(context) ? double.infinity : 400.w;
    final iconSize = ResponsiveUtils.getResponsiveIconSize(context, 20);
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
              prefixIcon: Icon(
                Icons.person_outline,
                size: iconSize,
                color: AppColors.textSecondary,
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
              prefixIcon: Icon(
                Icons.email_outlined,
                size: iconSize,
                color: AppColors.textSecondary,
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
              prefixIcon: Icon(
                Icons.lock_outline,
                size: iconSize,
                color: AppColors.textSecondary,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: iconSize,
                  color: AppColors.textSecondary,
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
              prefixIcon: Icon(
                Icons.lock_outline,
                size: iconSize,
                color: AppColors.textSecondary,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: iconSize,
                  color: AppColors.textSecondary,
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
        Checkbox(
          value: _acceptTerms,
          onChanged: (value) {
            setState(() {
              _acceptTerms = value ?? false;
            });
          },
          activeColor: AppColors.primary,
          checkColor: AppColors.white,
        ),
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
          icon: Icons.g_mobiledata,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Google kaydı yakında!'),
                backgroundColor: AppColors.info,
              ),
            );
          },
        ),
        SizedBox(width: spacing),
        _buildSocialButton(
          context,
          icon: Icons.apple,
          onTap: () {
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
          icon: Icons.facebook,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Facebook kaydı yakında!'),
                backgroundColor: AppColors.info,
              ),
            );
          },
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
            style: AppTextStyles.link(context).copyWith(
              color: AppColors.primary,
              fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final buttonSize = ResponsiveUtils.isMobile(context) ? 60.w : 70.w;
    final iconSize = ResponsiveUtils.getResponsiveIconSize(context, 24);
    final borderRadius = ResponsiveUtils.getResponsiveBorderRadius(context, 12);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: AppColors.border,
            width: ResponsiveUtils.isMobile(context) ? 1.w : 1.5.w,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            size: iconSize,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
