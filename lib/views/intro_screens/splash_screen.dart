import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:houston_hot_pass_staff_flow/views/auth/sign_in_screen.dart';

import '../../app_bottom_nav_bar/bottom_nav_bar.dart';
import '../../constants/app_icons.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/shared_preference.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = Get.find<AuthController>();

  getData() async {

    Map<String, dynamic> userStatus = await AuthPreference.instance.getUserLoggedIn();

    bool isLoggedIn = userStatus["isLoggedIn"];

    if (isLoggedIn==true) {
      _authController.accessToken.value = await AuthPreference.instance.getUserDataToken();
      // _authController.getUserById();
      Timer(
          const Duration(seconds: 4),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const CustomBottomBar())));
    }else{
      Timer(
          const Duration(seconds: 4),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const SignInScreen())));
    }
  }
  @override
  initState() {
    // Future.delayed( const Duration(seconds: 3), () {
    //   Get.offAll(()=>SignInScreen());
    // });

    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xffF8E1C1),
      body: Column(
        children: [
          Spacer(),
          Center(child: Image.asset(AppIcons.splashScreenIcon,scale: 4.5)),
          Spacer(),
          SpinKitCircle(color: Colors.black,size: 60,),
          SizedBox(height: 70,)


        ],
      ),





    );
  }
}
