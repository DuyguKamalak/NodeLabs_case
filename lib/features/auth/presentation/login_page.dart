import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/text_form_field/app_text_form_field.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

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
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40.h),

                // Lottie Animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    height: 200.h,
                    child: Lottie.asset(
                      'assets/animations/login_animation.json',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback if animation file doesn't exist
                        return Container(
                          height: 200.h,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/icon.svg',
                              width: 80.w,
                              height: 80.h,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 40.h),

                // Welcome Text
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    AppStrings.welcomeBack,
                    style: AppTextStyles.h1,
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 8.h),

                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    AppStrings.appTagline,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 40.h),

                // Email Field
                SlideTransition(
                  position: _slideAnimation,
                  child: AppTextFormField(
                    controller: _emailController,
                    labelText: AppStrings.email,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 20.w,
                      color: AppColors.textSecondary,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.fieldRequired;
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return AppStrings.invalidEmail;
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 16.h),

                // Password Field
                SlideTransition(
                  position: _slideAnimation,
                  child: AppTextFormField(
                    controller: _passwordController,
                    labelText: AppStrings.password,
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
                        return AppStrings.fieldRequired;
                      }
                      if (value.length < 6) {
                        return AppStrings.passwordTooShort;
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 16.h),

                // Remember Me & Forgot Password
                SlideTransition(
                  position: _slideAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                            activeColor: AppColors.primary,
                            checkColor: AppColors.white,
                          ),
                          Text(
                            'Beni Hatırla',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
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
                          AppStrings.forgotPassword,
                          style: AppTextStyles.link,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                // Login Button
                SlideTransition(
                  position: _slideAnimation,
                  child: AppButton(
                    text: AppStrings.login,
                    onPressed: _handleLogin,
                    type: AppButtonType.primary,
                  ),
                ),

                SizedBox(height: 24.h),

                // Divider
                SlideTransition(
                  position: _slideAnimation,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1.h,
                          color: AppColors.border,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'veya',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1.h,
                          color: AppColors.border,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Social Login Buttons
                SlideTransition(
                  position: _slideAnimation,
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: 'Google',
                          onPressed: () {
                            // Google login functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Google girişi yakında!'),
                                backgroundColor: AppColors.info,
                              ),
                            );
                          },
                          type: AppButtonType.secondary,
                          icon: Icon(
                            Icons.g_mobiledata,
                            size: 20.w,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: AppButton(
                          text: 'Apple',
                          onPressed: () {
                            // Apple login functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Apple girişi yakında!'),
                                backgroundColor: AppColors.info,
                              ),
                            );
                          },
                          type: AppButtonType.secondary,
                          icon: Icon(
                            Icons.apple,
                            size: 20.w,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                // Register Link
                SlideTransition(
                  position: _slideAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.dontHaveAccount,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: _navigateToRegister,
                        child: Text(
                          AppStrings.register,
                          style: AppTextStyles.link,
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
    );
  }
}
