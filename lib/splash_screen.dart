import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/utils/responsive_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigateToLogin();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _animationController.forward();
  }

  void _navigateToLogin() {
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ResponsiveUtils.responsiveBuilder(
        builder: (context, deviceType) {
          final size = MediaQuery.of(context).size;
          final iconSize = ResponsiveUtils.isMobile(context) ? 88.w : 120.w;
          final titleFontSize =
              ResponsiveUtils.getResponsiveFontSize(context, 33.32);
          final spacing = ResponsiveUtils.getResponsiveSpacing(context, 16);

          return Stack(
            children: [
              // Arka plan: linear-gradient(0deg, #090909 40%, #3F0306 100%)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xFF090909),
                      Color(0xFF3F0306),
                    ],
                    stops: [0.4, 1.0],
                  ),
                ),
              ),
              // Üst blur: Responsive shine effect
              Positioned(
                top: ResponsiveUtils.isMobile(context) ? -56 : -80,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Center(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: ResponsiveUtils.isMobile(context) ? 50.6 : 60.0,
                        sigmaY: ResponsiveUtils.isMobile(context) ? 50.6 : 60.0,
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
                child: ResponsiveUtils.constrainedContainer(
                  context: context,
                  child: Center(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // İkon: responsive SVG
                            SvgPicture.asset(
                              'assets/images/icon.svg',
                              width: iconSize,
                              height: iconSize,
                            ),
                            SizedBox(height: spacing),
                            // App title: responsive text
                            Text(
                              'Shartflix',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
