import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shartflix',
      theme: ThemeData(useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A0002), // very dark red
                  Color(0xFF000000), // black
                ],
              ),
            ),
          ),
          // Top radial shine
          Positioned(
            top: -120,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 340,
                height: 340,
                child: ClipOval(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: 0.9,
                          colors: [
                            const Color(0xFFFF1B1B).withOpacity(0.8),
                            const Color(0xFFFF1B1B).withOpacity(0.4),
                            const Color(0xFF8D0000).withOpacity(0.0),
                          ],
                          stops: const [0.0, 0.25, 1.0],
                          tileMode: TileMode.clamp,
                        ),
                      ),
                      foregroundDecoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        backgroundBlendMode: BlendMode.softLight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Center content
          Align(
            alignment: const Alignment(0, 0.08),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/Icon.svg',
                  width: 78,
                  height: 78,
                ),
                const SizedBox(height: 16),
                Text(
                  'Shartflix',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 33.32,
                    height: 1.2,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
