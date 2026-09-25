import 'package:final_project/firebase_utils.dart';
import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/model/my_user.dart';
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

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var rePasswordController = TextEditingController();
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
                  Image.asset(
                    themeProvider.isDark()
                        ? AppAssets.logoDarkImage
                        : AppAssets.logoLightImage,
                    width: width * .37,
                  ),
                  Text(
                    AppLocalizations.of(context)!.create_your_account,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  //enter_name
                  CustomTextField(
                    hintText: AppLocalizations.of(context)!.enter_name,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                      color: AppColors.disableColor,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return AppLocalizations.of(context)!.enter_name;
                      }

                      return null;
                    },
                  ),
                  //enter_email
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
                  //enter_password
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
                  //confirm_password
                  CustomTextField(
                    style: Theme.of(context).textTheme.bodySmall,
                    hintText: AppLocalizations.of(context)!.confirm_password,
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
                    controller: rePasswordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return AppLocalizations.of(context)!
                            .please_enter_password;
                      }
                      if (text.length < 6) {
                        return AppLocalizations.of(context)!.password_at_least;
                      }
                      if (text != passwordController.text) {
                        return AppLocalizations.of(context)!
                            .password_dont_match;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * .02),
                  CustomElevatedButton(
                    onPressed: registrt,
                    child: isLoading
                        ? MainLoadingWidget()
                        : Text(
                            AppLocalizations.of(context)!.sign_up2,
                            style: AppStyles.medium20White,
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.already_have_an_account,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.loginRouteName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
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
                    onPressed: () {
                      //todo : sign up with google
                    },
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

  void registrt() async {
    print("registrt:///${formKey.currentState?.validate()}");
    //todo=> nav to h.screen
    if (formKey.currentState?.validate() == true) {
      try {
        isLoading = true;
        setState(() {});
        final credintial = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        //todo : save user in firestore
        MyUser myUser = MyUser(
          id: credintial.user?.uid ?? '',
          name: nameController.text,
          email: emailController.text,
        );
        await FirebaseUtils.addUserToFirestoreWithConverter(myUser);
        //todo save in provider
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);
        isLoading = false;
        ToastUtils.toastMgs(
          msg: 'register successfully',
          backgroundColor: Theme.of(context).cardColor,
          textColor: AppColors.whiteColor,
          gravity: ToastGravity.BOTTOM,
        );
        Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          isLoading = false;
          ToastUtils.toastMgs(
            msg: ' the password is not strong enough.',
            backgroundColor: AppColors.redColor,
            textColor: AppColors.whiteColor,
          );
        } else if (e.code == "email-already-in-use") {
          isLoading = false;
          ToastUtils.toastMgs(
            msg:
                'there already exists an account with the given email address.',
            backgroundColor: AppColors.redColor,
            textColor: AppColors.whiteColor,
          );
        } else {
          isLoading = false;
          ToastUtils.toastMgs(
            msg: ' error: $e',
            backgroundColor: AppColors.redColor,
            textColor: AppColors.whiteColor,
          );
        }
      } catch (e) {
        isLoading = false;
        ToastUtils.toastMgs(
          msg: ' error: ${e.toString()}',
          backgroundColor: AppColors.redColor,
          textColor: AppColors.whiteColor,
        );

      }
      setState(() {

      });
    }
  }
}
