import 'package:flutter/material.dart';
import '/utils/device_utils.dart';
import '/constants/colours.dart';

Future customShowBottomSheet(
    {@required context,
    Widget? child,
    animController,
    Color? bgColor = Colors.transparent,
    double? height}) {
  return showModalBottomSheet(
    context: context,
    // transitionAnimationController: animController,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    backgroundColor: bgColor,
    builder: (context) {
      return Container(
        // color: whiteColour,
        // padding: EdgeInsets.only(
        //     // left: 20.0,
        //     // right: 20.0,
        //     // top: 30.0,
        //     bottom: MediaQuery.of(context).viewInsets.bottom + 50),
        height: (height != null) ? height : null,
        child: Wrap(children: [child!]),
      );
    },
  );
}

Future customShowBottomSheetNoIcon(
    {@required context,
    Widget? child,
    animController,
    Color? bgColor = Colors.transparent,
    pTop = 30.0,
    double? height}) {
  return showModalBottomSheet(
    context: context,
    // transitionAnimationController: animController,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    backgroundColor: bgColor,
    builder: (context) {
      return Container(
        padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: pTop,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50),
        height: (height != null) ? height : null,
        child: Wrap(children: [child!]),
      );
    },
  );
}
