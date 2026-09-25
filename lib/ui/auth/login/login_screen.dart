import 'package:final_project/firebase_utils.dart';
import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/providers/app_theme_provider.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:final_project/ui/home/tabs/widgets/main_loading_widget.dart';
import 'package:final_project/ui/widgets/custom_elevated_button.dart';
import 'package:final_project/ui/widgets/custom_text_field.dart';
import 'package:final_project/utils/app_assets.dart';
import 'package:final_project/utils/app_colors.dart';
import 'package:final_project/utils/app_routes.dart';
import 'package:final_project/utils/app_styles.dart';
import 'package:final_project/utils/size_utils.dart';
import 'package:final_project/utils/toast_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isLoading = false;

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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .30),
                    child: Image.asset(
                      themeProvider.isDark()
                          ? AppAssets.logoDarkImage
                          : AppAssets.logoLightImage,
                      width: width * .37,
                    ),
                  ),
                  SizedBox(height: height * .03),
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
                        return AppLocalizations.of(context)!.password_at_least;
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
                    child: isLoading
                        ? MainLoadingWidget()
                        : Text(
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

  void login() async {
    print("registrt:///${formKey.currentState?.validate()}");
    //todo
    if (formKey.currentState?.validate() == true) {
      try {
        //todo is loading => true
        isLoading = true;
        setState(() {});
        //todo auth
        final credintial = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

        //todo read data firestore
        var user = await FirebaseUtils.readUserFromFireStore(
          credintial.user?.uid ?? '',
        );
        if (user == null) {
          isLoading = false;
          setState(() {});
          return;
        }
        //todo save in provider
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        //todo isloading =>false
        isLoading = false;

        ToastUtils.toastMgs(
          msg: 'login successfully',
          backgroundColor: Theme.of(context).cardColor,
          textColor: AppColors.whiteColor,
          gravity: ToastGravity.BOTTOM,
        );
        Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          isLoading = false;
          ToastUtils.toastMgs(
            msg: 'the email or password is incorrect.',
            backgroundColor: AppColors.redColor,
            textColor: AppColors.whiteColor,
            gravity: ToastGravity.BOTTOM,
          );
        } else if (e.code == 'network-request-failed') {
          isLoading = false;
          ToastUtils.toastMgs(
            msg: '''there was a network request error, for example the user doesn't have internet connection''',
            backgroundColor: AppColors.redColor,
            textColor: AppColors.whiteColor,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          isLoading = false;
          ToastUtils.toastMgs(
            msg: 'errorCode:${e.code}, error: $e',
            backgroundColor: AppColors.redColor,
            textColor: AppColors.whiteColor,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } catch (e) {
        isLoading = false;
        ToastUtils.toastMgs(
          msg: ' error: $e',
          backgroundColor: AppColors.redColor,
          textColor: AppColors.whiteColor,
          gravity: ToastGravity.BOTTOM,
        );
      }
      setState(() {});
    }
  }
}
