import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> _pickFromGallery() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImageFile = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
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
                                context, 24)),
                        SvgPicture.asset(
                          'assets/images/Profile_Pic.svg',
                          width: ResponsiveUtils.getResponsiveIconSize(
                              context, 64),
                          height: ResponsiveUtils.getResponsiveIconSize(
                              context, 64),
                        ),
                        SizedBox(
                            height: ResponsiveUtils.getResponsiveSpacing(
                                context, 16)),
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
                                context, 8)),
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
                                context, 36)),
                      ],
                    ),
                  ),
                ),
              ),
              _buildBottomActions(context),
            ],
          ),
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
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: const BoxDecoration(),
              alignment: Alignment.center,
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

  Widget _buildBottomActions(BuildContext context) {
    final bool isEnabled = _selectedImageFile != null;
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
                    onPressed: isEnabled ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF3B30),
                      disabledBackgroundColor:
                          const Color(0xFFFF3B30).withOpacity(0.6),
                      minimumSize: Size.fromHeight(56.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: const Text('Devam Et'),
                  ),
                ),
                SizedBox(height: gap),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
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
