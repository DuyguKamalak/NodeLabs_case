import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
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
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.h),

                  // Ana Container (354px genişlik, esnek yükseklik)
                  SizedBox(
                    width: 354.w,
                    child: Column(
                      children: [
                        // Logo ve Text Container (256x160, gap: 24px)
                        SizedBox(
                          width: 256.w,
                          height: 160.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Logo (78x78)
                              SvgPicture.asset(
                                'assets/images/icon.svg',
                                width: 78.w,
                                height: 78.h,
                              ),

                              SizedBox(height: 24.h), // Gap: 24px

                              // "Hesap Oluştur" Text
                              Text(
                                'Hesap Oluştur',
                                style: AppTextStyles.h4
                                    .copyWith(color: AppColors.white),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: 8.h),

                              // "Kullanıcı bilgilerinle kaydol" Text
                              Text(
                                'Kullanıcı bilgilerinle kaydol',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.white
                                      .withOpacity(0.9), // 90% opacity
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h), // Gap: 24px

                        // Input Container (354px genişlik, esnek yükseklik)
                        SizedBox(
                          width: 354.w,
                          child: Column(
                            children: [
                              // Ad Soyad Field
                              SizedBox(
                                width: 354.w,
                                child: AppTextFormField(
                                  controller: _firstNameController,
                                  labelText: 'Ad Soyad',
                                  hintText: 'Ad ve soyadınızı girin',
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    size: 20.w,
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

                              SizedBox(height: 24.h), // Gap: 24px

                              // Email Field
                              SizedBox(
                                width: 354.w,
                                child: AppTextFormField(
                                  controller: _emailController,
                                  labelText: 'E-Posta',
                                  hintText: 'E-posta adresinizi girin',
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    size: 20.w,
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

                              SizedBox(height: 24.h), // Gap: 24px

                              // Password Field
                              SizedBox(
                                width: 354.w,
                                child: AppTextFormField(
                                  controller: _passwordController,
                                  labelText: 'Şifre',
                                  hintText: 'Şifrenizi girin',
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    size: 20.w,
                                    color: AppColors.textSecondary,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 20.w,
                                      color: AppColors.textSecondary,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
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

                              SizedBox(height: 24.h), // Gap: 24px

                              // Confirm Password Field
                              SizedBox(
                                width: 354.w,
                                child: AppTextFormField(
                                  controller: _confirmPasswordController,
                                  labelText: 'Şifre Tekrar',
                                  hintText: 'Şifrenizi tekrar girin',
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    size: 20.w,
                                    color: AppColors.textSecondary,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isConfirmPasswordVisible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 20.w,
                                      color: AppColors.textSecondary,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isConfirmPasswordVisible =
                                            !_isConfirmPasswordVisible;
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

                              SizedBox(height: 24.h), // Gap: 24px

                              // Terms and Conditions Checkbox
                              Row(
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
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: AppColors.white60,
                                        ),
                                        children: [
                                          const TextSpan(
                                              text: 'Kullanıcı sözleşmesini '),
                                          TextSpan(
                                            text: 'Okudum ve Kabul ediyorum',
                                            style: AppTextStyles.bodySmallBold
                                                .copyWith(
                                              color: AppColors.white,
                                            ),
                                          ),
                                          const TextSpan(
                                              text:
                                                  '. Bu sözleşmeyi okuyarak devam ediniz lütfen.'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h), // Gap: 24px

                        // Register Button
                        AppButton(
                          text: 'Kaydol',
                          onPressed: _handleRegister,
                          type: AppButtonType.primary,
                        ),

                        SizedBox(height: 24.h), // Gap: 24px

                        // Social Login Buttons Container (210px genişlik, esnek yükseklik)
                        SizedBox(
                          width: 210.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildSocialButton(
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
                              SizedBox(width: 15.w), // Gap: 15px
                              _buildSocialButton(
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
                              SizedBox(width: 15.w), // Gap: 15px
                              _buildSocialButton(
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
                          ),
                        ),

                        SizedBox(height: 24.h), // Gap: 24px

                        // Login Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hesabın var mı?',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.white60,
                              ),
                            ),
                            TextButton(
                              onPressed: _navigateToLogin,
                              child: Text(
                                'Giriş Yap',
                                style: AppTextStyles.link.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 40.h), // Alt boşluk
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 24.w,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
