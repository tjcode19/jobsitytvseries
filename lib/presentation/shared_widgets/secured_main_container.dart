import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/constants/colours.dart';
import '/cubit/base_cubit.dart';
import '/utils/device_utils.dart';

class SecuredMainContainer extends StatelessWidget {
  final Widget? pageLabel;
  final Widget? pageLabelIcon;
  final Widget? child;
  final Widget? footer;
  final bool isHeaderSet;
  final Widget? header;
  final Color? bgColor;
  final Widget? floatAction;
  const SecuredMainContainer(
      {Key? key,
      @required this.pageLabel,
      this.pageLabelIcon,
      this.child,
      this.footer,
      this.isHeaderSet = false,
      this.floatAction,
      this.header,
      this.bgColor = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final upperContH = DeviceUtils.getScaledHeight(context, 1.0) * 0.12;
    return SafeArea(
      child: Scaffold(
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
              padding: EdgeInsets.only(
                // top: MediaQuery.of(context).padding.top,
                left: DeviceUtils.getScaledWidth(context, 1.0) * 0.05,
                right: DeviceUtils.getScaledWidth(context, 1.0) * 0.05,
                bottom: MediaQuery.of(context).padding.top * 0.5,
              ),
              color: bgColor,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: upperContH,
                    // decoration: BoxDecoration(
                    //     // color: appPrimaryColor,
                    //     border: Border(
                    //         bottom: BorderSide(color: appPrimaryColorLight, width: 5.0))),

                    child: (!isHeaderSet)
                        ? Row(
                            children: [
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: pageLabel!),
                              ),
                              pageLabelIcon!,
                            ],
                          )
                        : header,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: DeviceUtils.getScaledHeight(context, 1.0) -
                          upperContH,
                      child: LayoutBuilder(
                        builder: (BuildContext context,
                            BoxConstraints viewportConstraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: viewportConstraints.maxHeight,
                              ),
                              child: IntrinsicHeight(
                                  child: Column(
                                children: [
                                  Expanded(child: child!),
                                  Container(child: footer)
                                ],
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: floatAction,
      ),
    );
  }
}
