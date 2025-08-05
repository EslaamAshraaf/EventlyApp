import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/screens/register/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IntroductionScreen extends StatelessWidget {
  static const String routeName = "intro";

  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    const Color highlightColor = Color(0xFF5669FF); // New color for headline & button

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/images/logo_h.png"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/introduction.png", width: double.infinity),
            SizedBox(height: 24.h),
            Text(
              "introduction_title".tr(),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: highlightColor, // Headline color
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "introduction_subtitle".tr(),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: colorScheme.onBackground,
              ),
            ),
            SizedBox(height: 24.h),
            _buildLanguageSelector(context, highlightColor),
            SizedBox(height: 16.h),
            _buildThemeSelector(themeProvider, highlightColor),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: highlightColor, // Button color
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  "intro_btn".tr(),
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context, Color highlightColor) {
    final currentLocale = context.locale.toString();

    return Row(
      children: [
        Expanded(
          child: Text(
            "language".tr(),
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
              color: highlightColor,
            ),
          ),
        ),
        Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: highlightColor, width: 3),
            ),
            child: Row(
              children: [
                _buildFlag(
                  asset: "assets/images/usa.png",
                  isSelected: currentLocale == "en",
                  onTap: () => context.setLocale(const Locale('en')),
                  borderColor: highlightColor,
                ),
                SizedBox(width: 16.w),
                _buildFlag(
                  asset: "assets/images/EG.png",
                  isSelected: currentLocale == "ar",
                  onTap: () => context.setLocale(const Locale('ar')),
                  borderColor: highlightColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFlag({
    required String asset,
    required bool isSelected,
    required VoidCallback onTap,
    required Color borderColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          border: isSelected
              ? Border.all(color: borderColor, width: 3.r)
              : Border.all(color: Colors.transparent),
        ),
        child: Image.asset(
          asset,
          width: 30.w,
          height: 30.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildThemeSelector(ThemeProvider provider, Color highlightColor) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "theme".tr(),
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
              color: highlightColor,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: highlightColor, width: 3),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => provider.changeTheme(ThemeMode.light),
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Image.asset(
                    "assets/images/sun.png",
                    width: 30.w,
                    height: 30.h,
                    color: Colors.white,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              GestureDetector(
                onTap: () => provider.changeTheme(ThemeMode.dark),
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Icon(
                    Icons.mode_night_rounded,
                    color: highlightColor,
                    size: 30.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
