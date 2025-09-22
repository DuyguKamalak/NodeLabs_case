import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Yardımcı: Figma pikselini ekrana ölçekle
  Offset _figmaPos(BuildContext c,
      {required double left, required double top}) {
    const figmaW = 402.0, figmaH = 874.0;
    final size = MediaQuery.of(c).size;
    return Offset(size.width * (left / figmaW), size.height * (top / figmaH));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// BG: zoom + odak + hafif yukarı kaydır
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(0, -80), // biraz yukarı
              child: Transform.scale(
                scale: 1.35, // yakınlık
                alignment:
                    const Alignment(-0.5, 0.4), // odağı çiftin yüzlerine getir
                child: Image.asset(
                  'assets/images/anasayfa.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomLeft, // burada center bırak
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),

          /// Gradyan overlay
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.35, 0.75, 0.88],
                  colors: [
                    Color.fromRGBO(9, 9, 9, 0.3), // Üst (daha az opacity)
                    Color.fromRGBO(9, 9, 9, 0.0), // Şeffaf başlangıç
                    Color.fromRGBO(9, 9, 9, 0.0), // Şeffaf bitiş
                    Color.fromRGBO(9, 9, 9, 0.9),
                  ],
                ),
              ),
            ),
          ),

          /// Alt kısım: film info + nav bar
          Positioned(
            left: 0,
            right: 0,
            bottom: ResponsiveUtils.getBottomNavHeight(context) +
                MediaQuery.of(context).padding.bottom +
                16,
            child: SafeArea(
              top: false,
              bottom: false,
              child: Padding(
                padding: ResponsiveUtils.getPagePadding(context).copyWith(
                    bottom: ResponsiveUtils.getResponsiveSpacing(context, 12)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Film info frame'i
                    _buildMovieInfoSection(context),
                  ],
                ),
              ),
            ),
          ),

          /// Fav butonunu Figma koordinatlarına göre konumlandır
          Builder(
            builder: (context) {
              final p =
                  _figmaPos(context, left: 326, top: 611); // Figma birebir
              return Positioned(
                left: p.dx,
                top: p.dy,
                child: _FavoriteButton(
                  isFavorite: _isFavorite,
                  onTap: () {
                    setState(() => _isFavorite = !_isFavorite);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          _isFavorite
                              ? 'Favorilere eklendi'
                              : 'Favorilerden çıkarıldı',
                        ),
                        backgroundColor: AppColors.primary,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Film bilgi alanı
  Widget _buildMovieInfoSection(BuildContext context) {
    final logoSize = ResponsiveUtils.getResponsiveIconSize(context, 40);
    final gap = ResponsiveUtils.getResponsiveSpacing(context, 16);
    final titleFs = ResponsiveUtils.getResponsiveFontSize(context, 18);
    final bodyFs = ResponsiveUtils.getResponsiveFontSize(context, 14);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: ResponsiveUtils.isMobile(context) ? double.infinity : 420,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// N logosu
          SizedBox(
            width: logoSize,
            height: logoSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/anasayfa_icon.svg',
                  width: logoSize,
                  height: logoSize,
                ),
                SvgPicture.asset(
                  'assets/images/Icon1.svg',
                  width: logoSize * 0.52,
                  height: logoSize * 0.44,
                ),
              ],
            ),
          ),
          SizedBox(width: gap),

          /// Başlık + açıklama
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Son Ana Kadar',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.h1(context).copyWith(
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: titleFs,
                    height: 1.0,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(
                    height: ResponsiveUtils.getResponsiveSpacing(context, 4)),
                RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Birbirine derinden bağlı iki çocukluk arkadaşı olan Sydney ve Karl ',
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          fontFamily: 'Instrument Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: bodyFs,
                          height: 1.1,
                          color: AppColors.white70,
                        ),
                      ),
                      TextSpan(
                        text: 'Devamını Oku',
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          fontFamily: 'Instrument Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: bodyFs,
                          height: 1.1,
                          color: AppColors.white,
                        ),
                      ),
                    ],
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

class _FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const _FavoriteButton({
    required this.isFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = ResponsiveUtils.getResponsiveIconSize(context, 52);
    final height = ResponsiveUtils.getResponsiveIconSize(context, 72);
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width / 2),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.08),
              borderRadius: BorderRadius.circular(width / 2),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 0.8,
              ),
            ),
            child: SvgPicture.asset(
              isFavorite
                  ? 'assets/icons/fav_button/Type=Liked.svg'
                  : 'assets/icons/fav_button/Type=Default.svg',
              width: width,
              height: height,
              fit: BoxFit.contain,
              clipBehavior: Clip.antiAlias,
              allowDrawingOutsideViewBox: false,
              matchTextDirection: false,
            ),
          ),
        ),
      ),
    );
  }
}
