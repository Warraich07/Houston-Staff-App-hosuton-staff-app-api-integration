import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../constants/app_colors.dart';

class CustomDialog {


  static Future<dynamic> showErrorDialog({
    String title = 'Error',
    String? description = 'Something went wrong',
    int? maxLine,
    dynamic Function()? onTap,
    String? buttonText,
    bool showTitle=false

  }) {
    return Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  20.0)), //this right here
          child: Container(
            height:380,
            width: 100.w,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.primaryColor,
              border: Border.all(color: AppColors.whiteColor,width: 2.7),

            ),
            child: Column(
              children: [

                SizedBox(height: 50,),
                Image.asset(
                  'assets/app_icons/erro_icon.png',
                  scale: 4.6,
                ),
                const Spacer(),
                showTitle? Text(
                  title,
                  style:  TextStyle(fontSize: 22,height: 1.2, fontFamily: "bold",color: AppColors.whiteColor),
                  textAlign: TextAlign.center,
                ):Container(),
                showTitle? SizedBox(height: 10):Container(),
                Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.4,
                    fontSize: 12,
                    fontFamily: "Bold",
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),

                const Spacer(),
                ZoomTapAnimation(
                    onTap: onTap??(){
                      Get.back();
                    },
                    enableLongTapRepeatEvent: false,
                    longTapRepeatDuration: const Duration(milliseconds: 100),
                    begin: 1.0,
                    end: 0.93,
                    beginDuration: const Duration(milliseconds: 20),
                    endDuration: const Duration(milliseconds: 120),
                    beginCurve: Curves.decelerate,
                    endCurve: Curves.fastOutSlowIn,
                    child: Container(
                      height: 55,
                      width: 90.w,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                      ),
                      child: Center(
                          child: Text(buttonText??"Back",
                              style:  TextStyle(
                                  color: AppColors.primaryColor,


                                  fontSize: 16,
                                  fontFamily: "Bold"))),
                    )),
                SizedBox(height: 15),
                // widget.newButton==true?GestureDetector(
                //   onTap: () {
                //     Get.to(());
                //   },
                //   child: Container(
                //     height: 55,
                //     width: 90.w,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(5),
                //       color: AppColors.whiteColor,
                //     ),
                //     child: Center(
                //         child: Text(widget.secondButtonName.toString(),
                //             style:  TextStyle(
                //                 color: AppColors.primaryColor,
                //
                //
                //                 fontSize: 16,
                //                 fontFamily: "Bold"))),
                //   ),
                // ):SizedBox.shrink(),
              ],
            ),

          ),
        )
    );
  }

  static Future<dynamic> showPopUpDialog({
    String title = 'Error',
    String? description = 'Something went wrong',
    int? maxLine,
    dynamic Function()? onTapFirstButton,
    dynamic Function()? onTapSecondButton,
    String? buttonText,
    bool showTitle=false

  }) {
    return Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  20.0)), //this right here
          child: Container(
            height:270,
            width: 100.w,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.primaryColor,
              border: Border.all(color: AppColors.whiteColor,width: 2.7),

            ),
            child: Column(
              children: [
                Spacer(flex: 1,),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.close,color: Colors.white,)),
                ),
                showTitle? Text(
                  title,
                  style:  TextStyle(fontSize: 22,height: 1.2, fontFamily: "bold",color: AppColors.whiteColor),
                  textAlign: TextAlign.center,
                ):Container(),
                showTitle? SizedBox(height: 10):Container(),
                Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.4,
                    fontSize: 12,
                    fontFamily: "Bold",
                    color: Colors.white,
                  ),
                ),
               Spacer(flex: 2,),
                ZoomTapAnimation(
                    onTap: onTapFirstButton??(){
                      Get.back();
                    },
                    enableLongTapRepeatEvent: false,
                    longTapRepeatDuration: const Duration(milliseconds: 100),
                    begin: 1.0,
                    end: 0.93,
                    beginDuration: const Duration(milliseconds: 20),
                    endDuration: const Duration(milliseconds: 120),
                    beginCurve: Curves.decelerate,
                    endCurve: Curves.fastOutSlowIn,
                    child: Container(
                      height: 55,
                      width: 90.w,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                      ),
                      child: Center(
                          child: Text(buttonText??"Scan QR Code",
                              style:  TextStyle(
                                  color: AppColors.primaryColor,


                                  fontSize: 16,
                                  fontFamily: "Bold"))),
                    )),
                SizedBox(height: 15),
                ZoomTapAnimation(
                    onTap: onTapSecondButton??(){
                      Get.back();
                    },
                    enableLongTapRepeatEvent: false,
                    longTapRepeatDuration: const Duration(milliseconds: 100),
                    begin: 1.0,
                    end: 0.93,
                    beginDuration: const Duration(milliseconds: 20),
                    endDuration: const Duration(milliseconds: 120),
                    beginCurve: Curves.decelerate,
                    endCurve: Curves.fastOutSlowIn,
                    child: Container(
                      height: 55,
                      width: 90.w,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                      ),
                      child: Center(
                          child: Text(buttonText??"Enter Offer Code",
                              style:  TextStyle(
                                  color: AppColors.primaryColor,


                                  fontSize: 16,
                                  fontFamily: "Bold"))),
                    )),

              ],
            ),

          ),
        )
    );
  }
  //show snack bar
  //show loading
  static void showLoading([String? message]) {
    Get.dialog(
      Center(
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: Colors.deepOrangeAccent),
                const SizedBox(height: 8),
                Text(message ?? 'Loading...'),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}

