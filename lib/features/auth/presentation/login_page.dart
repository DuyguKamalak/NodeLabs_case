import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/text_form_field/app_text_form_field.dart';
import '../../../core/widgets/common/app_background.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Login logic implemented
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giriş başarılı!'),
          backgroundColor: AppColors.success,
        ),
      );

      // Navigate to main page after successful login
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/main');
        }
      });
    }
  }

  void _navigateToRegister() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const RegisterPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40.h),

                  // Lottie Animation Header (Üstte)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      height: 200.h,
                      margin: EdgeInsets.only(bottom: 20.h),
                      child: Lottie.asset(
                        'assets/animations/Artboard_1.json',
                        fit: BoxFit.contain,
                        repeat: true,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback if animation file doesn't exist
                          return Container(
                            height: 200.h,
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.movie,
                                size: 80.w,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Logo (78x78)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/icon.svg',
                        width: 78.w,
                        height: 78.h,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // "Giriş Yap" Text
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'Giriş Yap',
                      style: GoogleFonts.instrumentSans(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        height: 1.0,
                        letterSpacing: 0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // "Kullanıcı bilgilerinle giriş yap" Text
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'Kullanıcı bilgilerinle giriş yap',
                      style: GoogleFonts.instrumentSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white.withOpacity(0.9), // 90% opacity
                        height: 1.0,
                        letterSpacing: 0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Email Field (354x56)
                  SlideTransition(
                    position: _slideAnimation,
                    child: Center(
                      child: SizedBox(
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
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Password Field (354x56)
                  SlideTransition(
                    position: _slideAnimation,
                    child: Center(
                      child: SizedBox(
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
                  ),

                  SizedBox(height: 12.h),

                  // Forgot Password Link
                  SlideTransition(
                    position: _slideAnimation,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Forgot password functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Şifre sıfırlama özelliği yakında!'),
                              backgroundColor: AppColors.info,
                            ),
                          );
                        },
                        child: Text(
                          'Şifre Unuttum',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Login Button
                  SlideTransition(
                    position: _slideAnimation,
                    child: AppButton(
                      text: 'Giriş Yap',
                      onPressed: _handleLogin,
                      type: AppButtonType.primary,
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Social Login Buttons (60x60)
                  SlideTransition(
                    position: _slideAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          icon: Icons.g_mobiledata,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Google girişi yakında!'),
                                backgroundColor: AppColors.info,
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 16.w),
                        _buildSocialButton(
                          icon: Icons.apple,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Apple girişi yakında!'),
                                backgroundColor: AppColors.info,
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 16.w),
                        _buildSocialButton(
                          icon: Icons.facebook,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Facebook girişi yakında!'),
                                backgroundColor: AppColors.info,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Sign Up Link
                  SlideTransition(
                    position: _slideAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bir hesabın yok mu? ',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.white60,
                          ),
                        ),
                        TextButton(
                          onPressed: _navigateToRegister,
                          child: Text(
                            'Kayıt Ol',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),
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
