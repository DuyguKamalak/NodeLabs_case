import 'dart:ui'; // <-- Blur için eklendi
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/services/api_client.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/common/app_background.dart';

class UploadPhotoPage extends StatefulWidget {
  const UploadPhotoPage({super.key});

  @override
  State<UploadPhotoPage> createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImageFile;
  bool _uploading = false;

  Future<void> _pickFromGallery() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImageFile = File(picked.path));
    }
  }

  Future<void> _upload() async {
    if (_selectedImageFile == null || _uploading) return;

    setState(() => _uploading = true);
    try {
      final token = await ApiClient.instance.getToken();
      if (token == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Oturum bulunamadı')),
        );
        return;
      }

      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://caseapi.servicelabs.tech',
          headers: const {'Accept': 'application/json'},
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          responseType: ResponseType.json,
        ),
      );

      final form = FormData.fromMap({
        // Swagger alan adı: file
        'file': await MultipartFile.fromFile(_selectedImageFile!.path),
      });

      final response = await dio.post(
        '/user/upload_photo',
        data: form,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final status = response.statusCode ?? 500;
      final ok = status >= 200 && status < 300;

      // Dönen photoUrl’i ayıkla
      String? photoUrl;
      final body = response.data;
      if (body is Map) {
        final inner = body['data'];
        if (inner is Map && inner['photoUrl'] is String) {
          photoUrl = inner['photoUrl'] as String;
        } else if (body['photoUrl'] is String) {
          photoUrl = body['photoUrl'] as String;
        }
      }

      // Kalıcı kaydet: KULLANICIYA ÖZEL
      if (ok && photoUrl != null && photoUrl.isNotEmpty) {
        await AuthService().savePhotoUrlForCurrentUser(photoUrl);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(ok ? 'Fotoğraf yüklendi ✅' : 'Beklenmeyen yanıt: $status'),
        ),
      );

      if (ok) {
        // Profil sayfasına yeni url’i döndür
        Navigator.of(context).pop(photoUrl);
      }
    } on DioException catch (e) {
      if (!mounted) return;
      final serverText = e.response?.data?.toString() ?? '';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Yükleme başarısız: ${e.message}\n$serverText')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Yükleme başarısız: $e')));
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = _selectedImageFile != null && !_uploading;
    final size = MediaQuery.of(context).size; // Shine genişliği için

    return Scaffold(
      backgroundColor: Colors.transparent,
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

            // Mevcut içerik: olduğu gibi
            SafeArea(
              child: Column(
                children: [
                  _buildHeader(context),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: ResponsiveUtils.getPagePadding(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: ResponsiveUtils.getResponsiveSpacing(
                                  context, 24),
                            ),
                            SvgPicture.asset(
                              'assets/images/Profile_Pic.svg',
                              width: ResponsiveUtils.getResponsiveIconSize(
                                  context, 64),
                              height: ResponsiveUtils.getResponsiveIconSize(
                                  context, 64),
                            ),
                            SizedBox(
                              height: ResponsiveUtils.getResponsiveSpacing(
                                  context, 16),
                            ),
                            Text(
                              'Fotoğraf Yükle',
                              style: TextStyle(
                                fontFamily: 'Instrument Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: ResponsiveUtils.getResponsiveFontSize(
                                    context, 22),
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveUtils.getResponsiveSpacing(
                                  context, 8),
                            ),
                            Text(
                              'Profil fotoğrafın için görsel yükleyebilirsin',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Instrument Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: ResponsiveUtils.getResponsiveFontSize(
                                    context, 14),
                                height: 1.0,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            SizedBox(height: 52.h),
                            SizedBox(
                              width: 196.w,
                              height: 395.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _buildDropZone(context),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveUtils.getResponsiveSpacing(
                                  context, 36),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildBottomActions(context, isEnabled),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final horizontalPadding = ResponsiveUtils.getPagePadding(context);
    final headerHeight = ResponsiveUtils.isMobile(context) ? 60.h : 70.h;

    return Container(
      width: double.infinity,
      height: headerHeight,
      padding: horizontalPadding,
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            borderRadius: BorderRadius.circular(24.r),
            child: SizedBox(
              width: 36.w,
              height: 36.w,
              child: SvgPicture.asset(
                'assets/icons/button/Type=Secondary, State=Active, Icon Only=Yes.svg',
                width: 36.w,
                height: 36.w,
              ),
            ),
          ),
          const Spacer(),
          Text(
            'Profil Detayı',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontWeight: FontWeight.w600,
              fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
              color: Colors.white,
            ),
          ),
          const Spacer(),
          SizedBox(width: 36.w),
        ],
      ),
    );
  }

  Widget _buildDropZone(BuildContext context) {
    final double frameSize = 176.w;

    return Center(
      child: GestureDetector(
        onTap: _pickFromGallery,
        child: SizedBox(
          width: frameSize,
          height: frameSize,
          child: _selectedImageFile == null
              ? SvgPicture.asset(
                  'assets/icons/upload/Type=Upload.svg',
                  fit: BoxFit.contain,
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(32.r),
                  child: Image.file(
                    _selectedImageFile!,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, bool isEnabled) {
    final double containerWidth = 354.w;
    final double containerHeight = 125.h;
    final double gap = 13.h;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: ResponsiveUtils.getResponsiveSpacing(context, 12),
          right: ResponsiveUtils.getResponsiveSpacing(context, 12),
          bottom: ResponsiveUtils.getResponsiveSpacing(context, 12),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: containerWidth,
            height: containerHeight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isEnabled ? _upload : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF3B30),
                      disabledBackgroundColor:
                          const Color(0xFFFF3B30).withOpacity(0.6),
                      minimumSize: Size.fromHeight(56.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(_uploading ? 'Yükleniyor...' : 'Devam Et'),
                  ),
                ),
                SizedBox(height: gap),
                TextButton(
                  onPressed:
                      _uploading ? null : () => Navigator.of(context).pop(),
                  child: const Text('Atla'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
