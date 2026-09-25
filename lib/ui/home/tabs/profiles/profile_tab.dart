import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/providers/app_language_provider.dart';
import 'package:final_project/providers/app_theme_provider.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:final_project/ui/home/tabs/profiles/widgets/app_config_item.dart';
import 'package:final_project/ui/home/tabs/profiles/widgets/language/language_bottom_sheet.dart';
import 'package:final_project/utils/app_assets.dart';
import 'package:final_project/utils/app_colors.dart';
import 'package:final_project/utils/app_routes.dart';
import 'package:final_project/utils/size_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var height = context.height;
    var width = context.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * .04,
        vertical: height * .04,
      ),
      child: SafeArea(
        child: Column(
          spacing: height * .02,
          children: [
            SizedBox(height: height * .02),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AppAssets.logoRouteImage),
            ),
            Text(
             userProvider.currentUser!.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              userProvider.currentUser!.email,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: height * .01),
            AppConfigItem(
              text: AppLocalizations.of(context)!.dark_mode,
              icon: Switch(
                value: themeProvider.isDark(),
                onChanged: (value) {
                  themeProvider.changeTheme(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
                },
                trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.disabled)) {
                    return AppColors.transparentColor;
                  }
                  return null; // Use the default color.
                }),
              ),
            ),
            AppConfigItem(
              text: AppLocalizations.of(context)!.language,
              icon: IconButton(
                onPressed: () {
                  //todo show lang btn
                  showLanguageBottomSheet();
                },
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
            AppConfigItem(
              text: AppLocalizations.of(context)!.logout,
              icon: IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  //todo logout
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.loginRouteName,
                      (route)=>false);

                },
                icon: Icon(Icons.logout, color: AppColors.redColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  // void showThemeBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) => ThemeBottomSheet(),
  //   );
  // }
}
