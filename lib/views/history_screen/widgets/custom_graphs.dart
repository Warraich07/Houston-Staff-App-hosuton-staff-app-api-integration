import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:houston_hot_pass_staff_flow/app_widgets/app_subtitle_text.dart';
import 'package:houston_hot_pass_staff_flow/app_widgets/bold_text.dart';
import 'package:houston_hot_pass_staff_flow/controllers/offers_controller.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../app_widgets/custom_shadow_button.dart';
import '../../../constants/app_colors.dart';
import '../history_screen.dart';


// // Sales data model
// class _SalesData {
//   _SalesData(this.year, this.sales);
//
//   final String year;
//   final double sales;
// }

// Chart Widget
class ChartWidget extends StatefulWidget {
  ChartWidget({super.key,required this.totalRedemptions,required this.impressionsData});
  String totalRedemptions;
  List<SalesData> impressionsData;

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  final OffersController _offersController=Get.find();
  // String formattedDate= DateFormat('MMMM, yyyy').format(DateTime.now());
  DateTime? selectedDate;
  Future<void> selectDate(BuildContext context) async {
    final ThemeData theme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        onBackground: AppColors.primaryColor,
        onSecondary: AppColors.blackColor,
        primary: AppColors.primaryColor,
        onPrimary: AppColors.whiteColor,
        onSurface: AppColors.blackColor,
        surface: AppColors.whiteColor,
      ),
    );

    // Set initial date to today if selectedDate is null
    final DateTime initialDate = selectedDate ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme,
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _offersController.formattedDate.value =  DateFormat('MMMM, yyyy').format(selectedDate!);
      String filteredDate= DateFormat('dd-MM-yyyy').format(selectedDate!);
      String selectedDateFor = DateFormat('d MMMM, yyyy').format(selectedDate!);
      _offersController.updateSelectedDate(selectedDateFor);
      _offersController.getRedemptionAnalysis(filteredDate);
      _offersController.getFilteredQrScans(false,filteredDate);
    }
  }

  // List<_SalesData> impressionsData = [];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   impressionsData = [
  //     _SalesData('1/7', 0.0),
  //     _SalesData('2/7', 4.0),
  //     _SalesData('3/7', 5.0),
  //     _SalesData('4/7', 3.0),
  //     _SalesData('5/7', 3.0),
  //     _SalesData('6/7', 3.0),
  //     _SalesData('7/7', 3.0),
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      width: 90.w,
      decoration: customShadowedDecoration(buttonColor: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppSubtitleText(
                    Text: "Redemptions",
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
                  Row(
                    children: [
                       AppSubtitleText(
                        Text: _offersController.formattedDate.value,
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      const SizedBox(width: 10),
                      ZoomTapAnimation(
                        onTap: () {
                          selectDate(context);
                        },
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
               BoldText(
                Text: widget.totalRedemptions,
                fontSize: 30,
                color: Colors.black,
              ),
              const AppSubtitleText(
                Text: "Total Redemptions",
                fontFamily: "regular",
                color: Colors.black,
              ),
              const SizedBox(height: 10), // Adjusted height to save space
              Expanded(
                child: Stack(
                  children: [
                    SfCartesianChart(
                      plotAreaBorderColor: Colors.transparent,
                      plotAreaBackgroundColor: Colors.transparent,
                      borderColor: Colors.transparent,
                      primaryXAxis: CategoryAxis(
                        majorGridLines: MajorGridLines(
                          color: Colors.grey.withOpacity(0.4),
                          width: 1.0,
                          dashArray: <double>[8, 8],
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      legend: const Legend(isVisible: false),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      primaryYAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(
                          color: Colors.transparent,
                          width: 1.0,
                          dashArray: <double>[3, 3],
                        ),
                        majorTickLines: const MajorTickLines(
                          size: 0,
                        ),
                        axisLine: const AxisLine(width: 0),
                        labelStyle: const TextStyle(
                          color: Colors.white, // Adjust color if needed
                        ),
                        labelFormat: '{value}', // Default formatting
                        numberFormat: NumberFormat("#0.0#", "en_US"), // Custom format for fractions
                      ),
                      series: <CartesianSeries<SalesData, String>>[
                        LineSeries<SalesData, String>(
                          width: 2,
                          color: AppColors.primaryColor,
                          dataSource: widget.impressionsData,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          dataLabelSettings: const DataLabelSettings(isVisible: false),
                        ),
                      ],
                    ),
                    // Positioned(
                    //   top: 0,
                    //   right: 30,
                    //   child: Container(
                    //     height: 30,
                    //     width: 120,
                    //     decoration: customShadowedDecoration(buttonColor: Colors.white),
                    //     child: const Center(
                    //       child: AppSubtitleText(
                    //         Text: "18 Redemptions",
                    //         fontSize: 12,
                    //         color: Colors.black,
                    //         maxLines: 1,
                    //       ),
                    //     ),
                    //   ),
                    // ),
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