import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../app_bottom_nav_bar/bottom_nav_bar.dart';
import '../../app_widgets/app_button.dart';
import '../../app_widgets/app_subtitle_text.dart';
import '../../app_widgets/custom_text_field.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/cutom_validators.dart';
import 'auth_widgets/auth_custom_background.dart';
import 'auth_widgets/custom_horizontal_padding.dart';
import 'auth_widgets/custom_screen_title.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Controller
  final AuthController _authController=Get.find();
  FocusNode focusNodeForEmail=FocusNode();
  FocusNode focusNodeForPassword=FocusNode();
  bool showPassword = true;
  Widget spacing() {
    return SizedBox(height: 17);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthCustomBackGround(
        child:   CustomHorizontalPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomScreenTitle(screenTitle: 'Sign In',),
              Expanded(
                child: Form(
                  key: _authController.formKeySignInScreen,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSubtitleText(Text: "Sign in to your account",color: AppColors.whiteColor.withOpacity(0.7)),
                      SizedBox(height: 40),
                      CustomTextField(
                        focusNode: focusNodeForEmail,
                        prefixIcon: AppIcons.emailIcon,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email address",
                        scale: 3.5,
                        controller: _authController.emailController,
                        validator: (value) => CustomValidator.email(value),
                        // validator: (value) => CustomValidator.email(value),
                      ),
                      spacing(),
                      CustomTextField(
                        focusNode: focusNodeForPassword,
                        prefixIconColor: AppColors.whiteColor,scale: 3.5,
                        maxLines: 1,
                        hintText: "Password",
                        validator: (value) => CustomValidator.password(value),
                        controller: _authController.passwordController,
                        // validator: (value) => CustomValidator.password(value),
                        keyboardType: TextInputType.visiblePassword,
                        isObscure: showPassword,
                        prefixIcon: AppIcons.lockIcon,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Icon(
                              !showPassword
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      // ZoomTapAnimation(
                      //   onTap: () {
                      //     _authController.emailController.clear();
                      //     Get.to(()=>ForgetPasswordScreen());
                      //   },
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       AppSubtitleText(
                      //           Text: "Forgot Password?",
                      //           color: Colors.white,
                      //           fontSize: 14),
                      //     ],
                      //   ),
                      // ),
                      // Spacer(),
                      CustomButton(
                          Text: "SIGN IN",
                          onTap: () {
                 if(_authController.formKeySignInScreen.currentState!.validate()){
                   focusNodeForEmail.unfocus();
                   focusNodeForPassword.unfocus();
                   _authController.loginUser();
                        // Get.to(()=>const CustomBottomBar());
                        }
                          },
                          buttonName: ""),
                      SizedBox(height: 70,),
                      // SizedBox(height: 60),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     AppSubtitleText(
                      //         Text: "Don't have an account? ",color: AppColors.whiteColor.withOpacity(0.7)
                      //         ),
                      //     ZoomTapAnimation(
                      //         onTap: () {
                      //           //
                      //           _authController.emailController.clear();
                      //           _authController.passwordController.clear();
                      //           Get.off(()=>SignUpScreeen());
                      //         },
                      //         child: Text("Sign Up",
                      //             style: TextStyle(
                      //               fontFamily: 'medium',
                      //               color: AppColors.blackColor,fontSize: 15
                      //             )))
                      //   ],
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )

    );
  }
}
