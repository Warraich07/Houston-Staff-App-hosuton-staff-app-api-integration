import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:houston_hot_pass_staff_flow/constants/app_colors.dart';
import 'package:houston_hot_pass_staff_flow/controllers/offers_controller.dart';
import 'package:houston_hot_pass_staff_flow/views/history_screen/widgets/custom_graphs.dart';
import 'package:sizer/sizer.dart';

import '../../app_widgets/app_subtitle_text.dart';
import '../../app_widgets/redeemed_offers_tile.dart';
import '../../constants/app_images.dart';
class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  OffersController _offersController=Get.find();
  // List<SalesData> impressionsData= [];
  // List<SalesData> impressionsData= [
  //   SalesData('1/7', 0.0),
  //   SalesData('2/7', 4.0),
  //   SalesData('3/7', 5.0),
  //   SalesData('4/7', 3.0),
  //   SalesData('5/7', 3.0),
  //   SalesData('6/7', 3.0),
  //   SalesData('7/7', 3.0),
  //   SalesData('7/7', 3.0),
  //   SalesData('8/7', 3.0),
  // ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Get the current date
    DateTime now = DateTime.now();
    String formattedDate = '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
    _offersController.getRedemptionAnalysis(formattedDate);
    _offersController.scannedQrListAccordingToDate.clear();
    _offersController.qrScansCurrentPageDateWise.value=0;
    _offersController.qrScansLastPageDateWise.value=0;
    _offersController.getFilteredQrScans(false,formattedDate);
    // String selectedDateFor = DateFormat('d MMMM, yyyy').format(selectedDate!);
    _offersController.updateSelectedDate("Today");
    // impressionsData = _offersController.redemptions.asMap().entries.map((entry) {
    //   int index = entry.key;
    //   int value = entry.value;
    //   return SalesData('${index + 1}/${_offersController.dates.length}', value.toDouble());
    // }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                Positioned(
                    top: 60,
                    left: 15,
                    child: AppSubtitleText(
                      Text: "Redeemed Offers\nHistory",
                      fontSize: 25,
                      color: AppColors.primaryColor,
                      height: 1.1,
                    )),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(
    ()=> Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),

                               _offersController.isLoading.value==true?Container(
                          height: 60.h,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),),
                        ) : ChartWidget(totalRedemptions:_offersController.totalRedemptions.value.toString(),impressionsData: _offersController.impressionsData,),
                        SizedBox(height: 15),
                        AppSubtitleText(
                          Text: _offersController.selectedDate.value+"'s QR Scans",
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        SizedBox(height: 10),
                        _offersController.scannedQrListAccordingToDate.isEmpty?Container(
                          height: 17.h,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text("No record found."),
                            ),
                          ),
                        ): ListView.builder(
                          padding: EdgeInsets.all(0),
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,itemCount: _offersController.scannedQrListAccordingToDate.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: RedeemedOffersTile(
                                offerTitle: _offersController.scannedQrListAccordingToDate[index].title,
                                offerDescription: _offersController.scannedQrListAccordingToDate[index].description,
                                imagePath: _offersController.scannedQrListAccordingToDate[index].image,
                                redeemedDateAndTime:'Redeemed: ${_offersController.formatDate(_offersController.scannedQrListAccordingToDate[index].createdAt.toString())}',
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

    );
  }
}
