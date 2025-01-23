import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houston_hot_pass_staff_flow/controllers/general_controller.dart';
import 'package:houston_hot_pass_staff_flow/utils/custom_dialog.dart';

import '../constants/app_colors.dart';
import '../constants/app_icons.dart';
import '../views/history_screen/history_screen.dart';
import '../views/home/home_screen.dart';
import '../views/qr_scanner/qr_scanner_screen.dart';
import '../views/qr_scanner/redeem_code_screen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final GeneralController _generalController = Get.put(GeneralController());
  // int selectedIndex = 0;
  final List<Widget> pages = [
    const HomeScreen(),
    const QrScannerScreen(),
    const HistoryScreen(), // Assuming this is a custom widget you have defined
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        body: Column(
          children: [
            Expanded(child: pages[_generalController.currentIndex]),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.primaryColor, width: 2.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Home Button
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //
                      //   selectedIndex = 0;
                      // });
                      _generalController.onBottomBarTapped(0);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          _generalController.currentIndex == 0
                              ? "assets/app_icons/bottom_bar_icons/selected_home_icon.png"
                              : "assets/app_icons/bottom_bar_icons/home_icon.png",
                          height: 22,
                          width: 22,
                          color: _generalController.currentIndex == 0
                              ? AppColors.primaryColor
                              : const Color(0xff000000),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: _generalController.currentIndex == 0
                                ? AppColors.primaryColor
                                : const Color(0xff000000),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Scan Button
                  GestureDetector(
                    onTap: () {
                      if(_generalController.currentIndex!=1){
                        CustomDialog.showPopUpDialog(
                            showTitle: true,
                            description: 'Use any of the following method to redeem this offer',
                            title: 'Redeem Offer',
                            onTapFirstButton: (){
                              Get.back();
                              // setState(() {
                              //   _generalController.onBottomBarTapped(1);
                              //   selectedIndex = 1;
                              // });
                              _generalController.onBottomBarTapped(1);
                            },
                            onTapSecondButton: (){
                              Get.back();
                              Get.to(()=>SearchScreen());
                            }
                        );

                      }

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Center(
                        child: Image.asset(
                          "assets/app_icons/bottom_bar_icons/scan_icon.png",
                          height: 140,
                          width: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // History Button
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   _generalController.onBottomBarTapped(2);
                      //   selectedIndex = 2;
                      // });
                      _generalController.onBottomBarTapped(2);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          _generalController.currentIndex == 1
                              ? "assets/app_icons/bottom_bar_icons/history_selected_icon.png"
                              : "assets/app_icons/bottom_bar_icons/history_icon.png",
                          height: 22,
                          width: 22,
                          color: _generalController.currentIndex == 2
                              ? AppColors.primaryColor
                              : const Color(0xff000000),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'History',
                          style: TextStyle(
                            color: _generalController.currentIndex == 2
                                ? AppColors.primaryColor
                                : const Color(0xff000000),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
