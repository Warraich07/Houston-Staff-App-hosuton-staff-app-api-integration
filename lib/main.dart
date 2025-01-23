import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houston_hot_pass_staff_flow/app_bottom_nav_bar/bottom_nav_bar.dart';
import 'package:houston_hot_pass_staff_flow/controllers/auth_controller.dart';
import 'package:houston_hot_pass_staff_flow/controllers/base_controller.dart';
import 'package:houston_hot_pass_staff_flow/controllers/offers_controller.dart';
import 'package:houston_hot_pass_staff_flow/views/home/home_screen.dart';
import 'package:sizer/sizer.dart';

import 'controllers/general_controller.dart';
import 'controllers/home_controller.dart';
import 'views/intro_screens/splash_screen.dart';




void main() {

  runApp( const MyApp());


}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            initialBinding: InitialBinding(),

            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              );
            },
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white
            ),
            debugShowCheckedModeBanner: false,
            home: (
                const SplashScreen()
            ),
          );
        }
    );
  }

}
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(GeneralController());
    Get.put(OffersController());
    Get.put(AuthController());
    Get.put(HomeController());
  }
}





