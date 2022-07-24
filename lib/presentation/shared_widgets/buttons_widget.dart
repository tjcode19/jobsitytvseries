import 'package:flutter/material.dart';
import 'package:jobsitytvseries/constants/colours.dart';
import 'package:jobsitytvseries/constants/enums.dart';
import 'package:jobsitytvseries/utils/device_utils.dart';

Widget elevatedButton(
    {required context,
    required txt,
    state = false,
    bgColor = appPrimaryColor,
    textColor = whiteColour,
    double fontSize = 18.0,
    action}) {
  return InkWell(
    onTap: action,
    child: Container(
      width: DeviceUtils.getScaledWidth(context, 1.0),
      padding: EdgeInsets.all(CustomLayout.mPad.padding),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        color: bgColor,
      ),
      child: Center(
        child: (!state)
            ? Text(
                txt,
                style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600),
              )
            : SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  backgroundColor: appPrimaryColorLight,
                  strokeWidth: 2.0,
                )),
      ),
    ),
  );
}