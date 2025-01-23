import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../app_widgets/app_subtitle_text.dart';
import '../../app_widgets/custom_text_field.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../controllers/general_controller.dart';
import '../../controllers/offers_controller.dart';
import '../../utils/cutom_validators.dart';
import '../../widgets/custom_appbar.dart';
import '../auth/auth_widgets/custom_horizontal_padding.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Controllers
  GeneralController generalController = Get.find();
  OffersController offerController = Get.find();
  String searchQuery='';
  final focusNode=FocusNode();
  TextEditingController redeemOfferController=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();

    return Scaffold(
      body:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBarBackGround(
              showFiltersIcon: false,
              showBackButton: true,
              height: 150, showTextField: false,

            ),
            const SizedBox(height: 20),
            const CustomHorizontalPadding(child: AppSubtitleText(Text: "Enter the offer code to redeem this offer",color: Colors.black,fontSize: 14,)),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                child: CustomTextField(
                    isEditProfileInfoScreen:true,
                  validator: (value) => CustomValidator.isEmptyOfferCode(value),
                  controller: redeemOfferController,
                    fieldBorderColor:AppColors.primaryColor,
                  onFieldSubmitted: (value){
                      focusNode.unfocus();
                      if(redeemOfferController.text.isNotEmpty){
                        offerController.redeemOfferCode(redeemOfferController.text.toString(), context);
                      }

                  },
                  focusNode: focusNode,
                  inputTextColor: Colors.black,
                  onChanged: (String value) {

                  },
                  onTap: () {
                  },
                  fillColor: AppColors.whiteColor,
                  hintText: "Enter Offer Code",
                  hintTextColor:
                  Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Spacer(flex: 4,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: ZoomTapAnimation(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      focusNode.unfocus();
                      offerController.redeemOfferCode(redeemOfferController.text.toString(), context);

                    }
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
                      color: AppColors.primaryColor,
                    ),
                    child: Center(
                        child: Text("Redeem Offer",
                            style:  TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 16,
                                fontFamily: "Bold"))),
                  )),
            ),
            Spacer(flex: 1,),

          ],
        ),

    );
  }
}
