import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../app_bottom_nav_bar/bottom_nav_bar.dart';
import '../models/user_model.dart';
import '../utils/custom_dialog.dart';
import '../utils/shared_preference.dart';
import 'base_controller.dart';
import 'general_controller.dart';

class AuthController extends GetxController {

  final GlobalKey<FormState> formKeySignInScreen = GlobalKey();

  final BaseController _baseController = BaseController.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController  passwordController = TextEditingController();
  RxString accessToken = "".obs;
  GeneralController _generalController=Get.find();
  final AuthPreference _authPreference = AuthPreference.instance;
  Rxn<UserModel> userData=Rxn<UserModel>();


  Future loginUser() async {
    _baseController.showLoading();
    Map<String, String> body = {
      'email': emailController.text.toString(),
      'password': passwordController.text.toString()
    };
    var response = await DataApiService.instance
        .post('staff/login', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
       _baseController.handleError(error);
      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    // print(result['success'])
    var result = json.decode(response);
    if (result['success']) {
      _authPreference.saveUserData(token: jsonEncode(userData.value.toString()));
      // general
      accessToken.value=result['token'];
      print(accessToken.value);
          userData.value=UserModel.fromJson(result['data']);
          _authPreference.setUserLoggedIn(true);
          _authPreference.saveUserDataToken(token: accessToken.value);
      _generalController.onBottomBarTapped(0);
      Get.offAll(()=>const CustomBottomBar());
      emailController.clear();
      passwordController.clear();
    } else {
      List<dynamic> errorMessage=result['message'];
      String message=errorMessage.join();
      CustomDialog.showErrorDialog(showTitle: true,description: message,title: "Error!");

    }
  }

  Future getUserById() async {
    var response = await DataApiService.instance
        .get('user/get-user')
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      }
    });
    update();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      // userLoginData.value=MainUserLoginModel.fromJson(result['data']);
      accessToken.value=result['token'];
    } else {

    }
  }

}
