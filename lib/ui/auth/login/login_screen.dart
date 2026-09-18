import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/providers/app_theme_provider.dart';
import 'package:final_project/ui/widgets/custom_elevated_button.dart';
import 'package:final_project/ui/widgets/custom_text_field.dart';
import 'package:final_project/utils/app_assets.dart';
import 'package:final_project/utils/app_colors.dart';
import 'package:final_project/utils/app_routes.dart';
import 'package:final_project/utils/app_styles.dart';
import 'package:final_project/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * .02,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: height * .02,
                children: [
                  Image.asset(
                    themeProvider.isDark()
                        ? AppAssets.logoDarkImage
                        : AppAssets.logoLightImage,
                    width: width * .37,
                  ),
                  Text(
                    AppLocalizations.of(context)!.login_to_your_account,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  CustomTextField(
                    hintText: AppLocalizations.of(context)!.please_enter_email,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.disableColor,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_email;
                      }

                      final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(text);
                      if (!emailValid) {
                        return AppLocalizations.of(context)!.please_enter_email;
                      }

                      return null;
                    },
                  ),
                  CustomTextField(
                    style: Theme.of(context).textTheme.bodySmall,
                    hintText: AppLocalizations.of(context)!
                        .please_enter_password,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                      color: AppColors.disableColor,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility_off_outlined,
                      color: AppColors.disableColor,
                    ),
                    keyboardType: TextInputType.number,
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return AppLocalizations.of(context)!
                            .please_enter_password;
                      }
                      if (text.length < 6) {
                    return    AppLocalizations.of(context)!.password_at_least;
                      }
                      return null;
                    },
                  ),
                  Container(
                    alignment: .centerEnd,
                    child: TextButton(
                      onPressed: () {
                        //todo nav to f.pass screen
                      },
                      child: Text(
                        '${AppLocalizations.of(context)!.forget_password} ?',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).cardColor,
                        ),
                      ),
                    ),
                  ),
                  CustomElevatedButton(
                    onPressed: login,
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: AppStyles.medium20White,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.do_not_have_an_account,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          //todo nav to reg screen\
                          Navigator.of(context)
                              .pushNamed(AppRoutes.registerRouteName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.sign_up,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).cardColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Theme.of(context).dividerColor,
                          thickness: 2,
                          indent: width * 0.02,
                          endIndent: width * 0.06,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.or,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Expanded(
                        child: Divider(
                          color: Theme.of(context).dividerColor,
                          thickness: 2,
                          indent: width * 0.06,
                          endIndent: width * 0.02,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * .01),
                  CustomElevatedButton(
                    onPressed: login,
                    padding: height * .02,
                    borderColor: Theme.of(context).dividerColor,
                    backgroundColor: Theme.of(context).highlightColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: width * 0.04,
                      children: [
                        Image.asset(AppAssets.googleLogo),
                        Text(
                          AppLocalizations.of(context)!.login_with_google,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    //todo
    if (formKey.currentState!.validate()) {}
  }
}
