import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houston_hot_pass_staff_flow/constants/app_colors.dart';
import 'package:houston_hot_pass_staff_flow/controllers/offers_controller.dart';
import 'package:houston_hot_pass_staff_flow/views/auth/sign_in_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../app_widgets/alertbox.dart';
import '../../app_widgets/app_subtitle_text.dart';
import '../../app_widgets/custom_listview.dart';
import '../../app_widgets/logout_bottom_sheet.dart';
import '../../app_widgets/redeemed_offers_tile.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_images.dart';
import '../../utils/shared_preference.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  OffersController _offersController=Get.find();
  final AuthPreference _authPreference = AuthPreference.instance;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    print(_offersController.scannedQrList.length.toString()+"length");
      if(!_offersController.isLoadingForHome.value){
        _offersController.scannedQrList.clear();
        _offersController.qrScansCurrentPage.value=0;
        _offersController.qrScansLastPage.value=0;
        _offersController.getQrScans(false);
      }

    });

    // Show popup after 10 seconds
    // Future.delayed(const Duration(seconds: 10), () {
    //   // Show dialog
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return CustomAlertDialog(
    //         heading: "QR Scan Completed Successfully",
    //         subHeading: "User has successfully redeemed the offer.",
    //         buttonName: "Great",img: "assets/app_icons/success_icon.png",onTapped: () {
    //         Get.back();
    //       },);
    //     },
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    RefreshController _offersRefreshController = RefreshController(initialRefresh: false);

    return Scaffold(
   body:    SingleChildScrollView(
     child: Obx(
       ()=> Column(
         crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                      height: 150,
                      width: 100.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                              AssetImage(AppImages.homeAppBarBackgroundImage),
                              fit: BoxFit.cover))),
                  Positioned(top: 45,
                      left: 15,
                      child: Image.asset("assets/app_icons/app_logo.png",scale: 3,)),
                  Positioned(
                      right: 15,
                      top: 60,
                      child: IconButton(onPressed: (){
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return const LogOutBottomSheet();
                          },
                        );

                      }, icon: Icon(Icons.logout)))



                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      const AppSubtitleText(
                        Text: 'Recent QR Scans', color: Colors.black, fontSize: 20,),
                      const SizedBox(height: 10),
                      SizedBox(
                        child:_offersController.isLoadingForHome.value==true? Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ):SizedBox(
                          height: 64.h,
                          child:_offersController.scannedQrList.isEmpty?const Center(
                            child:Text("No record found.")
                          ): SmartRefresher(
                            enablePullDown: false,
                            enablePullUp:_offersController.qrScansCurrentPage.value>_offersController.qrScansLastPage.value?false:true,
                            controller: _offersRefreshController,
                            onLoading: () async {
                              print(_offersController.qrScansCurrentPage.value.toString()+'current page');
                              print(_offersController.qrScansLastPage.value.toString()+'last page');
                              print(_offersController.isPullUp.value.toString()+'enable pull up');
                              if (_offersController.qrScansCurrentPage.value<_offersController.qrScansLastPage.value) {
                                print("loading");
                                _offersController.qrScansCurrentPage.value++;
                                if(!_offersController.isPullUp.value){
                                await _offersController.getQrScans(true);
                                _offersRefreshController.loadComplete();
                                }
                                setState(() {});
                              }
                              _offersRefreshController.loadComplete();
                            },
                            child: CustomListview(
                              physics: ScrollPhysics(),
                                itemCount:_offersController.scannedQrList.length,
                                scrollDirection: Axis.vertical,
                                // child: const Padding(padding: EdgeInsets.only(bottom: 15.0),),
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: RedeemedOffersTile(
                                    offerTitle: _offersController.scannedQrList[index].title,
                                     offerDescription: _offersController.scannedQrList[index].description,
                                    imagePath: _offersController.scannedQrList[index].image,
                                   redeemedDateAndTime:'Redeemed: ${_offersController.formatDate(_offersController.scannedQrList[index].createdAt.toString())}',
                                      ),
                                );
                                }
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
              ),



            ],
          ),
     ),
   ),

    );
  }
}
