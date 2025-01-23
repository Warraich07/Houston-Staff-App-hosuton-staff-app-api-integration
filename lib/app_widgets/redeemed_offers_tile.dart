import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:houston_hot_pass_staff_flow/app_widgets/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../app_widgets/app_subtitle_text.dart';
import '../constants/app_colors.dart';
import '../constants/app_images.dart';
import 'app_button.dart';
import 'bold_text.dart';

class RedeemedOffersTile extends StatefulWidget {
  RedeemedOffersTile({super.key,this.offerTitle,this.offerDescription,this.imagePath,this.redeemedDateAndTime,this.redeemedTIme});
  String? offerTitle;
  String? offerDescription;
  String? imagePath;
  String? redeemedDateAndTime;
  String? redeemedTIme;

  @override
  State<RedeemedOffersTile> createState() => _RedeemedOffersTileState();
}

class _RedeemedOffersTileState extends State<RedeemedOffersTile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                  height: 130,
                  width: 170,
                  child: CachedNetworkImage(
                    imageUrl:widget.imagePath??'',
                    placeholder: (context, url) =>
                        Center(
                            child: ShimmerSingleWidget(shimmerWidth: 45.w,)),
                    errorWidget: (context, url,
                        error) =>
                        Image.asset(
                          AppImages.foodTileImage,
                          // color:   widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor,

                        ),
                    fit: BoxFit.cover,
                    // scale:20 ,
                    // width: double.infinity,
                    // height: 250,
                  )),
              SizedBox(width: 10),
              CustomButton(Text: "Redeemed",width: 100,height: 33,buttonColor: Colors.grey,textColor: AppColors.whiteColor,textSize: 13,)

            ],
          ),

        ),
        Positioned(
          top: 12,
          right: 5,
          left: 120,
          child: Container(
            width: 70.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor, width: 2.3),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor, // Shadow color
                  spreadRadius: 0, // The radius of the shadow
                  blurRadius: 0, // The blur effect
                  offset: Offset(4, -4), // Offset of the shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tooltip(
                    message: widget.offerTitle,
                    child: BoldText(
                      Text:widget.offerTitle?? "The Curry Pizza guys",height: 1.1,
                      color: Colors.black,fontSize: 12,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(height: 2),
                  Tooltip(
                    message: widget.offerDescription,

                    child: Text(

                      overflow: TextOverflow.ellipsis,
                      widget.offerDescription??'30% Off On All-You-Can-Eat ',
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: "regular",
                        fontSize: 9,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  AppSubtitleText(Text:widget.redeemedDateAndTime?? 'Redeemed: 07/25/2024   10:00 am',color: AppColors.primaryColor,fontSize: 9),
                ],
              ),
            ),
          ),

        ),


      ],
    );
  }
}
