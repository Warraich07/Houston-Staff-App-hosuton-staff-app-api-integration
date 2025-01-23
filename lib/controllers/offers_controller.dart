import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houston_hot_pass_staff_flow/views/auth/sign_in_screen.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../app_bottom_nav_bar/bottom_nav_bar.dart';
import '../app_widgets/alertbox.dart';
import '../models/qr_scans_model.dart';
import '../utils/custom_dialog.dart';
import '../views/history_screen/history_screen.dart';
import 'base_controller.dart';
import 'general_controller.dart';

class OffersController extends GetxController {
  RxList<QrScansModel> scannedQrList=<QrScansModel>[].obs;
  RxInt qrScansCurrentPage=0.obs;
  RxInt qrScansLastPage=0.obs;
  RxList<QrScansModel> scannedQrListAccordingToDate=<QrScansModel>[].obs;
  RxInt qrScansCurrentPageDateWise=0.obs;
  RxInt qrScansLastPageDateWise=0.obs;
  RxBool isLoading=false.obs;
  RxBool isLoadingForHome=false.obs;
  RxBool isPullUp=false.obs;
  final BaseController _baseController = BaseController.instance;
  GeneralController _generalController=Get.find();
  RxList<int> redemptions = <int>[].obs;
  RxInt totalRedemptions=0.obs;
  RxList<int> dates = <int>[].obs;
  RxList<SalesData> impressionsData= <SalesData>[].obs;
  RxString formattedDate= DateFormat('MMMM, yyyy').format(DateTime.now()).obs;
  QRViewController? controller;
  RxString selectedDate='Today'.obs;
  // RxInt homeOffersCurrentPage=1.obs;
  // RxInt homeOffersLastPage=0.obs;

  Future scanQrCode(String qrCode,BuildContext context) async {

    Future.microtask(() async {
      // scannedQrList.clear();
      // qrScansCurrentPage.value=0;
      // qrScansLastPage.value=0;
     _baseController.showLoading();
      var response = await DataApiService.instance
          .getScanCode(qrCode)
          .catchError((error) {
        if (error is BadRequestException) {
          // var apiError = json.decode(error.message!);
          // CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {
          // _baseController.handleError(error);
        }
      });
     _baseController.hideLoading();
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {

        _generalController.onBottomBarTapped(0);
        Get.to(()=>const CustomBottomBar());
          // Show dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomAlertDialog(
                heading: "QR Scan Completed Successfully",
                subHeading: "User has successfully redeemed the offer.",
                buttonName: "Great",img: "assets/app_icons/success_icon.png",onTapped: () {
                  Get.back();
              },);
            },
          );


      } else {
        List<dynamic> errorMessage=result['message'];
        String message=errorMessage.join();
        if(message=='You are not authorized to scan offers from other restaurants. Please scan offers that belong to your restaurant only.'){
          _generalController.onBottomBarTapped(0);

          Get.to(()=>const CustomBottomBar());
          CustomDialog.showErrorDialog(description: message);
        }else{
          CustomDialog.showErrorDialog(description: message,onTap: (){
            Get.back();
            controller?.resumeCamera();
          });

        }

      }});
  }

  Future getQrScans(bool isPagination) async {

    Future.microtask(() async {
      isPullUp.value=true;
      if(!isPagination){
        isLoadingForHome.value=true;
      }
      var response = await DataApiService.instance
          .get('staff/qr-code-scans?page=${qrScansCurrentPage.value}')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {
          _baseController.handleError(error);
        }
      });
      isPullUp.value=false;
      isLoadingForHome.value=false;
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        print(qrScansCurrentPage.value.toString()+'current page in APi');
        print(qrScansLastPage.value.toString()+'last page in APi');
        print(isPullUp.value.toString()+'pull up value in APi');
        if(scannedQrList.isEmpty){
          scannedQrList.value = List<QrScansModel>.from(result['data']['data'].map((x) => QrScansModel.fromJson(x)));
        }else{
          scannedQrList.addAll(List<QrScansModel>.from(result['data']['data'].map((x) => QrScansModel.fromJson(x))));
        }
        qrScansCurrentPage.value=result['data']['current_page'];
        qrScansLastPage.value=result['data']['last_page'];
      } else {


      }});
  }

  Future getFilteredQrScans(bool isPagination,String date) async {

    Future.microtask(() async {
      isPullUp.value=true;
      if(!isPagination){
        isLoading.value=true;
      }
      var response = await DataApiService.instance
          .get('staff/qr-code-scans?date=$date')
          .catchError((error) {
        if (error is BadRequestException) {
          // var apiError = json.decode(error.message!);
          // CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {
          // _baseController.handleError(error);
        }
      });
      isPullUp.value=true;
      isLoading.value=false;
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        // if(scannedQrList.isEmpty){
        scannedQrListAccordingToDate.value = List<QrScansModel>.from(result['data']['data'].map((x) => QrScansModel.fromJson(x)));
        // }else{
        //   scannedQrList.addAll(List<QrScansModel>.from(result['data']['data'].map((x) => QrScansModel.fromJson(x))));
        // }
          qrScansCurrentPageDateWise.value=result['data']['current_page'];
          qrScansLastPageDateWise.value=result['data']['last_page'];
      } else {

      }});
  }

  Future redeemOfferCode(String offerCode,BuildContext context) async {

    Future.microtask(() async {
      _baseController.showLoading();

        Map<String, String> body = {
          'code': offerCode
        };
      var response = await DataApiService.instance
          .post('staff/offer-redeem-code',body)
          .catchError((error) {
        if (error is BadRequestException) {
          // var apiError = json.decode(error.message!);
          // CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {
          // _baseController.handleError(error);
        }
      });
      _baseController.hideLoading();
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        Get.to(()=>const CustomBottomBar());
        // Show dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              heading: "QR Scan Completed Successfully",
              subHeading: "User has successfully redeemed the offer.",
              buttonName: "Great",img: "assets/app_icons/success_icon.png",onTapped: () {
              Get.back();
            },);
          },
        );
      } else {
        List<dynamic> errorMessage=result['message'];
        String message=errorMessage.join();
        CustomDialog.showErrorDialog(showTitle: true,description: message,title: "Error!");
      }});
  }

  Future getRedemptionAnalysis(String date) async {

    Future.microtask(() async {
      isLoading.value=true;
      var response = await DataApiService.instance
          .get('staff/redemption-analytics?date=$date')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {
          _baseController.handleError(error);
        }
      });
      isLoading.value=false;
      update();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        dates.value = List<int>.from(result['data']['dates']);
        redemptions.value = List<int>.from(result['data']['redemptions']);
        totalRedemptions.value = redemptions.fold(0, (sum, item) => sum + item);
        impressionsData.value = redemptions.asMap().entries.map((entry) {
          int index = entry.key;
          int value = entry.value;
          return SalesData('${index + 1}/${dates.length}', value.toDouble());
        }).toList();
      } else {

      }
    });
  }


  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat('MM/dd/yyyy h:mm a').format(parsedDate);

    return formattedDate;
  }

  void updateSelectedDate(String date) {
    String todayData = DateFormat('d MMMM, yyyy').format(DateTime.now());
    if(date==todayData||date=='Today'){
      selectedDate.value="Today";
    }else{
      selectedDate.value=date;
    }
  }
}