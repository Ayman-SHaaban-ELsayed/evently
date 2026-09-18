import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/providers/app_language_provider.dart';
import 'package:final_project/providers/app_theme_provider.dart';
import 'package:final_project/utils/app_assets.dart';
import 'package:final_project/utils/app_colors.dart';
import 'package:final_project/utils/app_routes.dart';
import 'package:final_project/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 375 * 812
class OnboardingHome extends StatelessWidget {
  const OnboardingHome({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var width = context.width;
    var height = context.height;

    bool isDark = themeProvider.isDark();
    bool isEn = languageProvider.appLanguage == 'en';

    Color primaryColor = Theme.of(context).cardColor;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.042,
            vertical: height * 0.034,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  isDark ? AppAssets.logoDarkImage : AppAssets.logoLightImage,
                  height: height * 0.033,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: height * 0.029),

              Expanded(
                child: Center(
                  child: Image.asset(
                    AppAssets.creativeImage,
                    fit: BoxFit.contain,
                    color: !isDark ? primaryColor : null,
                  ),
                ),
              ),
              SizedBox(height: height * 0.029),

              Text(
                AppLocalizations.of(context)!.personalize_title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: height * 0.014),
              Text(
                AppLocalizations.of(context)!.personalize_desc,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: height * 0.029),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Row(
                    children: [
                      _buildIndividualButton(
                        height: height,
                        width: width,
                        content: Text(
                          AppLocalizations.of(context)!.english,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: isEn
                                    ? AppColors.whiteColor
                                    : primaryColor,
                              ),
                        ),
                        isSelected: isEn,
                        primaryColor: primaryColor,
                        onTap: () => languageProvider.changeLanguage('en'),
                      ),
                      SizedBox(width: width * 0.021),
                      _buildIndividualButton(
                        height: height,
                        width: width,
                        content: Text(
                          AppLocalizations.of(context)!.arabic,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: !isEn
                                    ? AppColors.whiteColor
                                    : primaryColor,
                              ),
                        ),
                        isSelected: !isEn,
                        primaryColor: primaryColor,
                        onTap: () => languageProvider.changeLanguage('ar'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.024),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Row(
                    children: [
                      _buildIndividualButton(
                        height: height,
                        width: width,
                        content: Icon(
                          Icons.light_mode,
                          size: height * 0.027,
                          color: !isDark ? AppColors.whiteColor : primaryColor,
                        ),
                        isSelected: !isDark,
                        primaryColor: primaryColor,
                        onTap: () => themeProvider.changeTheme(ThemeMode.light),
                      ),
                      SizedBox(width: width * 0.021),
                      _buildIndividualButton(
                        height: height,
                        width: width,
                        content: Icon(
                          Icons.dark_mode,
                          size: height * 0.027,
                          color: isDark ? AppColors.whiteColor : primaryColor,
                        ),
                        isSelected: isDark,
                        primaryColor: primaryColor,
                        onTap: () => themeProvider.changeTheme(ThemeMode.dark),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.036),
              SizedBox(
                width: double.infinity,
                height: height * 0.068,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: التوجيه
                    Navigator.pushReplacementNamed(context, AppRoutes.onboardingRouteName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(height * 0.019),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.lets_start,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: AppColors.whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndividualButton({
    required double height,
    required double width,
    required Widget content,
    required bool isSelected,
    required Color primaryColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.049,
        padding: EdgeInsets.symmetric(horizontal: width * 0.042),
         decoration: BoxDecoration(
          color: isSelected ? primaryColor : AppColors.transparentColor,
          border: Border.all(color: primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(
            height * 0.014,
          ),
        ),
        alignment: Alignment.center,
        child: content,
      ),
    );
  }
}
