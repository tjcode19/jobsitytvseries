import 'package:flutter/material.dart';
import '/constants/colours.dart';
import '/constants/enums.dart';
import '/utils/device_utils.dart';
import 'bottom_sheet.dart';
import 'buttons_widget.dart';
import 'custom_cont.dart';

successMainBottomSheet(context, {title, subTitle, textOnBtn, btnAction}) {
  var h = DeviceUtils.getScaledHeight(context, 1.0) * 0.6;
  customShowBottomSheet(
    context: context,
    child: SizedBox(
      height: h,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: CustomCont(
              height: h - 27.5,
              vPadding: 20.0,
              hPadding: 20,
              radTopLeft: 20.0,
              radTopRight: 20.0,
              bgColor: whiteColour,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomLayout.xlPad.sizedBoxH,
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CustomLayout.xlPad.sizedBoxH,
                      CustomCont(
                        width: DeviceUtils.getScaledWidth(context, 1.0),
                        bgColor: successColor,
                        // height: 80,
                        hPadding: 20.0,
                        vPadding: 20.0,
                        shadow: false,
                        child: Text(
                          subTitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CustomLayout.lPad.sizedBoxH,
                      SizedBox(
                        height: 50,
                        child: elevatedButton(
                          context: context,
                          txt: textOnBtn ?? "Dashboard",
                          action: () =>
                              btnAction() ??
                              () {
                                
                              },
                        ),
                      ),
                      CustomLayout.xlPad.sizedBoxH,
                      // Center(
                      //   child: RichText(
                      //     text: const TextSpan(
                      //       text: 'Not Ready?',
                      //       children: [
                      //         TextSpan(
                      //           text: ' Update Later',
                      //           style: TextStyle(
                      //             color: appPrimaryColor,
                      //           ),
                      //         )
                      //       ],
                      //       style: TextStyle(
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.w400,
                      //         color: bodyTextColor,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const SizedBox(
                  width: 55.0,
                  height: 55.0,
                  child: CircleAvatar(
                    child: Icon(
                      Icons.check_circle,
                      size: 35.0,
                      color: successColorDark,
                    ),
                    backgroundColor: successColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
