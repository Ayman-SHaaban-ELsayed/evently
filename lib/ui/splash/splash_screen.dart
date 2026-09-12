import 'dart:async';
import 'package:final_project/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// تأكد من استيراد مسارات ملفاتك بشكل صحيح هنا
import 'package:final_project/utils/app_assets.dart';
import 'package:final_project/utils/app_colors.dart';
import 'package:final_project/utils/app_routes.dart';
import 'package:final_project/providers/app_theme_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDark();
    var   width=context.width;
    var   height=context.height;
    return Scaffold(
       backgroundColor: isDark ? AppColors.darkBgColor : AppColors.lightBgColor,
      body: Stack(
        children: [
           Align(
            alignment: Alignment.center,
            child: Image.asset(
              isDark ? AppAssets.logoDarkImage : AppAssets.logoLightImage,

              fit: BoxFit.fill,
            ),
          ),

           Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:   EdgeInsets.only(bottom: height*.082,right: width*.21,left:width*.21),
              child: Image.asset(
                isDark ?   AppAssets.logoSplashDarkImage: AppAssets.logoSplash,
                 fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}