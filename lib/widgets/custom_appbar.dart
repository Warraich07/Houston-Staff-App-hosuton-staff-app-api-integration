import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../app_widgets/app_subtitle_text.dart';
import '../app_widgets/bold_text.dart';
import '../constants/app_icons.dart';
import '../constants/app_images.dart';
import '../controllers/general_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/offers_controller.dart';

class CustomAppBarBackGround extends StatefulWidget {
  final bool showTextField;
  final bool showFiltersIcon;
  final bool? showBackButton;
  final bool? showIcon;
  final Widget? child;
  final String? screenTitle;
  final String? screenSubtitle;
  final bool? showScreenTitle;
  final bool? showScreenSubtitle;
  final Widget? textFieldWidget;
  final Widget? filtersBottomSheet;
  const CustomAppBarBackGround(
      {super.key,
        required this.showTextField,
        required this.showFiltersIcon,
        this.showBackButton,
        this.child,
        this.showIcon = true,
        this.height,
        this.screenTitle,
        this.showScreenTitle,
        this.screenSubtitle,
        this.showScreenSubtitle,
        this.textFieldWidget,
        this.filtersBottomSheet
      });

  @override
  State<CustomAppBarBackGround> createState() => _CustomAppBarBackGroundState();
  final double? height;
}

class _CustomAppBarBackGroundState extends State<CustomAppBarBackGround> {
  GeneralController generalController = Get.find();
  HomeController homeController = HomeController();
  OffersController offersController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: widget.height,
              width: 100.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.homeAppBarBackgroundImage),
                      fit: BoxFit.fill)),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Center(
                          child: widget.showIcon == true
                              ? Image.asset(AppIcons.splashScreenIcon,
                              scale: 13)
                              : SizedBox.shrink()),
                      SizedBox(height: 13),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: widget.showTextField == true
                                    ? widget.textFieldWidget
                                    : SizedBox.shrink(),
                              ),
                            ),
                            SizedBox(width: 10),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 55,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        widget.showBackButton == true
                            ? ZoomTapAnimation(
                            onTap: () {
                              // offersController.focusNodeForHome.unfocus();
                              // FocusScope.of(context).unfocus();
                              Get.back();
                            },
                            child: Icon(Icons.arrow_back))
                            : SizedBox.shrink(),
                        SizedBox(width: 15),
                        widget.showScreenTitle == true
                            ? BoldText(
                          Text: widget.screenTitle.toString() ?? "",
                          color: Colors.black,
                          fontSize: 20,
                        )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(height: 10),
                    widget.showScreenSubtitle == true
                        ? AppSubtitleText(
                      Text: widget.screenSubtitle.toString() ?? "",
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 15,
                    )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
