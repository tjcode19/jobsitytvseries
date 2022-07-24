import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/constants/colours.dart';
import '/constants/enums.dart';
import '/utils/device_utils.dart';

class MainContainer extends StatelessWidget {
  final Widget? child;
  final Function backAction;
  const MainContainer({Key? key, this.child, required this.backAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: DeviceUtils.getScaledHeight(context, 1.0) * 0.09,
            right: -DeviceUtils.getScaledWidth(context, 1.0) * 0.15,
            child: Container(
              width: DeviceUtils.getScaledWidth(context, 1.0) * 0.4,
              height: DeviceUtils.getScaledHeight(context, 1.0) * 0.25,
              child: const Text(''),
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(100),
                  color: appSecondaryColorLight.withOpacity(0.1),
                  shape: BoxShape.circle),
            ),
          ),
          Positioned(
            top: DeviceUtils.getScaledHeight(context, 1.0) * 0.45,
            left: -DeviceUtils.getScaledWidth(context, 1.0) * 0.23,
            child: Container(
              width: DeviceUtils.getScaledWidth(context, 1.0) * 0.35,
              height: DeviceUtils.getScaledHeight(context, 1.0) * 0.22,
              child: const Text(''),
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(100),
                  color: appPrimaryColorLighter.withOpacity(0.1),
                  shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: -DeviceUtils.getScaledHeight(context, 1.0) * 0.1,
            right: -DeviceUtils.getScaledWidth(context, 1.0) * 0.1,
            child: Container(
              width: DeviceUtils.getScaledWidth(context, 1.0) * 0.65,
              height: DeviceUtils.getScaledHeight(context, 1.0) * 0.4,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(100),
                  color: appPrimaryColor.withOpacity(0.1),
                  shape: BoxShape.circle),
            ),
          ),
          Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top * 1.5,
              left: DeviceUtils.getScaledWidth(context, 1.0) * 0.05,
            ),
            child: _backAction(context, backAction),
          ),
          Container(
              height: DeviceUtils.getScaledHeight(context, 1.0) -
                  (MediaQuery.of(context).padding.top * 1.5),
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top * 3),
              width: DeviceUtils.getScaledWidth(context, 1.0),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(child: child)),
        ],
      ),
    );
  }

  Widget _backAction(context, backAction) {
    return GestureDetector(
      onTap: backAction,
      child: Container(
        padding: EdgeInsets.all(CustomLayout.msPad.padding),
        child: Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.arrow_back, size: 16,)
            ),
            Text(
              'Back',
            ),
          ],
        ),
      ),
    );
  }
}
