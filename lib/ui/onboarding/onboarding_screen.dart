import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/providers/app_theme_provider.dart';
import 'package:final_project/ui/onboarding/model/onboarding_model.dart';
import 'package:final_project/utils/app_assets.dart';
import 'package:final_project/utils/app_colors.dart';
import 'package:final_project/utils/app_routes.dart';
import 'package:final_project/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width = context.width;
    var height = context.height;
    bool isDark = themeProvider.isDark();

     final List<OnboardingModel> pages = [
      OnboardingModel(
        image: AppAssets.onboardingOne,
        title: AppLocalizations.of(context)!.onboarding_title_1,
        desc: AppLocalizations.of(context)!.onboarding_desc_1,
      ),
      OnboardingModel(
        // يرجى استبدال مسارات الصور بصور التوجيه الثانية والثالثة من ملفاتك
        image: AppAssets.onboardingTwo,
        title: AppLocalizations.of(context)!.onboarding_title_2,
        desc: AppLocalizations.of(context)!.onboarding_desc_2,
      ),
      OnboardingModel(
        image: AppAssets.onboardingThree,
        title: AppLocalizations.of(context)!.onboarding_title_3,
        desc: AppLocalizations.of(context)!.onboarding_desc_3,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.042,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentIndex > 0
                      ? GestureDetector(
                          onTap: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(width * 0.02),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).cardColor,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: height * 0.02,
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                        )
                      : SizedBox(width: width * 0.1),

                  Image.asset(
                    isDark ? AppAssets.logoDarkImage : AppAssets.logoLightImage,
                    height: height * 0.033,
                    fit: BoxFit.contain,
                  ),

                  _currentIndex < 2
                      ? TextButton(
                          onPressed: () {
                            // TODO: تجاوز التوجيه والذهاب للشاشة الرئيسية
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.homeRouteName,
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.skip,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Theme.of(context).cardColor),
                          ),
                        )
                      : SizedBox(width: width * 0.1),
                ],
              ),
              SizedBox(height: height * 0.02),

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    final model = pages[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // الصورة
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              model.image,
                              fit: BoxFit.contain,
                              color: !isDark
                                  ? Theme.of(context).cardColor
                                  : null,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.03),

                        SizedBox(height: height * 0.03),

                        // العنوان
                        Text(
                          model.title,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: height * 0.015),

                        // الوصف
                        Text(
                          model.desc,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: height * 0.02),

              // 3. الزر السفلي
              SizedBox(
                width: double.infinity,
                height: height * 0.068,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentIndex == 2) {
                      // TODO: التوجيه للشاشة الرئيسية
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.homeRouteName,
                      );
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(height * 0.019),
                    ),
                  ),
                  child: Text(
                    _currentIndex == 2
                        ? AppLocalizations.of(context)!.get_started
                        : AppLocalizations.of(context)!.next,
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
}
