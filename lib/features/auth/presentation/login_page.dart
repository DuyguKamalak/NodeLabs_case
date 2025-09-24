import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_utils.dart';
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
      backgroundColor: AppColors.transparent,
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
                                context, 40)),

                        // Lottie Animation Header - responsive
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: _buildAnimationHeader(context, deviceType),
                        ),

                        // Logo - responsive
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: _buildLogo(context),
                        ),

                        SizedBox(
                            height: ResponsiveUtils.getResponsiveSpacing(
                                context, 24)),

                        // Title and subtitle - responsive
                        _buildTitleSection(context),

                        SizedBox(
                            height: ResponsiveUtils.getResponsiveSpacing(
                                context, 40)),

                        // Form fields - responsive
                        _buildFormFields(context, deviceType),

                        SizedBox(
                            height: ResponsiveUtils.getResponsiveSpacing(
                                context, 32)),

                        // Login Button - responsive
                        SlideTransition(
                          position: _slideAnimation,
                          child: _buildLoginButton(context),
                        ),

                        SizedBox(
                            height: ResponsiveUtils.getResponsiveSpacing(
                                context, 32)),

                        // Social Login Buttons - responsive
                        SlideTransition(
                          position: _slideAnimation,
                          child: _buildSocialButtons(context, deviceType),
                        ),

                        SizedBox(
                            height: ResponsiveUtils.getResponsiveSpacing(
                                context, 32)),

                        // Sign Up Link - responsive
                        _buildSignUpLink(context),

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

  Widget _buildAnimationHeader(
      BuildContext context, ResponsiveDeviceType deviceType) {
    final animationHeight = ResponsiveUtils.isMobile(context) ? 200.h : 250.h;
    final bottomMargin = ResponsiveUtils.getResponsiveSpacing(context, 20);
    final borderRadius = ResponsiveUtils.getResponsiveBorderRadius(context, 16);

    return Container(
      height: animationHeight,
      margin: EdgeInsets.only(bottom: bottomMargin),
      child: Lottie.asset(
        'assets/animations/Artboard_1.json',
        fit: BoxFit.contain,
        repeat: true,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: animationHeight,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/icon.svg',
                width: ResponsiveUtils.getResponsiveIconSize(context, 80),
                height: ResponsiveUtils.getResponsiveIconSize(context, 80),
                colorFilter: const ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    final logoSize = ResponsiveUtils.isMobile(context) ? 78.w : 88.w;

    return Center(
      child: SvgPicture.asset(
        'assets/images/icon.svg',
        width: logoSize,
        height: logoSize,
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Column(
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            'Giriş Yap',
            style: AppTextStyles.h4(context).copyWith(
              height: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 8)),
        FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            'Kullanıcı bilgilerinle giriş yap',
            style: AppTextStyles.bodyMedium(context).copyWith(
              color: AppColors.white90,
              height: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields(
      BuildContext context, ResponsiveDeviceType deviceType) {
    final fieldWidth =
        ResponsiveUtils.isMobile(context) ? double.infinity : 400.w;
    final spacing = ResponsiveUtils.getResponsiveSpacing(context, 16);

    return Column(
      children: [
        // Email Field
        SlideTransition(
          position: _slideAnimation,
          child: Center(
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
        ),

        SizedBox(height: spacing),

        // Password Field
        SlideTransition(
          position: _slideAnimation,
          child: Center(
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
        ),

        SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 12)),

        // Forgot Password Link
        SlideTransition(
          position: _slideAnimation,
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Şifre sıfırlama özelliği yakında!'),
                    backgroundColor: AppColors.info,
                  ),
                );
              },
              child: Text(
                'Şifre Unuttum',
                style: AppTextStyles.bodyMedium(context).copyWith(
                  color: AppColors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return AppButton(
      text: 'Giriş Yap',
      onPressed: _handleLogin,
      type: AppButtonType.primary,
    );
  }

  Widget _buildSocialButtons(
      BuildContext context, ResponsiveDeviceType deviceType) {
    final spacing = ResponsiveUtils.getResponsiveSpacing(context, 16);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          context,
          iconPath: 'assets/icons/icon/Component/Components/Google.svg',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Google girişi yakında!'),
                backgroundColor: AppColors.info,
              ),
            );
          },
        ),
        SizedBox(width: spacing),
        _buildSocialButton(
          context,
          iconPath: 'assets/icons/icon/Component/Components/Apple.svg',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Apple girişi yakında!'),
                backgroundColor: AppColors.info,
              ),
            );
          },
        ),
        SizedBox(width: spacing),
        _buildSocialButton(
          context,
          iconPath: 'assets/icons/icon/Component/Components/Facebook.svg',
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
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Bir hesabın yok mu? ',
            style: AppTextStyles.bodyMedium(context).copyWith(
              color: AppColors.white60,
            ),
          ),
          TextButton(
            onPressed: _navigateToRegister,
            child: Text(
              'Kayıt Ol',
              style: AppTextStyles.bodyMediumSemibold(context).copyWith(
                color: AppColors.white,
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context, {
    required String iconPath,
    required VoidCallback onTap,
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
          color: AppColors.surface,
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
            colorFilter: const ColorFilter.mode(
              AppColors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
