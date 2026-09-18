import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/providers/app_language_provider.dart';
import 'package:final_project/providers/app_theme_provider.dart';
import 'package:final_project/ui/home/home_screen.dart';
import 'package:final_project/ui/onboarding/onboarding_home.dart';
import 'package:final_project/ui/onboarding/onboarding_screen.dart';
import 'package:final_project/ui/splash/splash_screen.dart';
import 'package:final_project/utils/app_routes.dart';
import 'package:final_project/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      routes: {
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.splashScreen: (context) => SplashScreen(),
        AppRoutes.onboardingHome: (context) => OnboardingHome(),
        AppRoutes.onboardingRouteName: (context) => OnboardingScreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}
