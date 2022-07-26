import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsitytvseries/constants/colours.dart';
import 'package:jobsitytvseries/constants/strings.dart';
import 'package:jobsitytvseries/cubit/base_cubit.dart';
import 'package:jobsitytvseries/utils/device_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isInitialValue = false;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    BlocProvider.of<BaseCubit>(context).finishSplashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColour,
      body: BlocListener<BaseCubit, dynamic>(
        listener: (context, state) {
          if (state is BaseLoaded) {
            SchedulerBinding.instance!.addPostFrameCallback((_) async {
              Navigator.popAndPushNamed(context, scrAuthoriser);
            });
          }
          if (state is BaseLoadAnim) {
            setState(() {
              _isInitialValue = true;
            });
          }
        },
        child: Stack(
          children: [
            Positioned(
              top: DeviceUtils.getScaledHeight(context, 1.0) * 0.35,
              left: DeviceUtils.getScaledWidth(context, 1.0) * 0.02,
              child: Container(
                width: DeviceUtils.getScaledWidth(context, 1.0) * 0.3,
                height: DeviceUtils.getScaledHeight(context, 1.0) * 0.27,
                child: Text(''),
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(100),
                    color: appSecondaryColor.withOpacity(0.3),
                    shape: BoxShape.circle),
              ),
            ),
            Positioned(
              top: DeviceUtils.getScaledHeight(context, 1.0) * 0.15,
              right: -DeviceUtils.getScaledWidth(context, 1.0) * 0.15,
              child: Container(
                width: DeviceUtils.getScaledWidth(context, 1.0) * 0.5,
                height: DeviceUtils.getScaledHeight(context, 1.0) * 0.25,
                child: Text(''),
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(100),
                    color: appPrimaryColor.withOpacity(0.3),
                    shape: BoxShape.circle),
              ),
            ),
            Positioned(
              top: -DeviceUtils.getScaledHeight(context, 1.0) * 0.004,
              left: -DeviceUtils.getScaledWidth(context, 1.0) * 0.12,
              child: Container(
                width: DeviceUtils.getScaledWidth(context, 1.0) * 0.3,
                height: DeviceUtils.getScaledHeight(context, 1.0) * 0.1,
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(100),
                    color: appPrimaryColor.withOpacity(0.3),
                    shape: BoxShape.circle),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 4),
                    color: appPrimaryColorLight,
                    height: 4,
                    width: _isInitialValue
                        ? DeviceUtils.getScaledWidth(context, 1.0)
                        : DeviceUtils.getScaledWidth(context, 1.0) * 0.1,
                    curve: Curves.bounceInOut,
                  ),
                  AnimatedContainer(
                    duration: const Duration(seconds: 3),
                    color: appPrimaryColor.withOpacity(0.5),
                    height: 8,
                    width: _isInitialValue
                        ? DeviceUtils.getScaledWidth(context, 1.0)
                        : DeviceUtils.getScaledWidth(context, 1.0) * 0.3,
                    curve: Curves.easeInBack,
                  ),
                  Container(
                    height: 20,
                    color: appPrimaryColor,
                    width: DeviceUtils.getScaledWidth(context, 1.0),
                    child: const Center(
                      child: Text(
                        'v1.0.0',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: whiteColour,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      // height: 120,
                      child: Image.asset(
                        'assets/images/logo1.png',
                        width: 100,
                        height: 70,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'TV',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              // color: whiteColour,
                              shadows: [
                                Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(4, 3),
                                    blurRadius: 4),
                              ]),
                        ),
                        AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText('Series',
                                textStyle: TextStyle(
                                    fontSize: 35.0,
                                    // fontWeight: FontWeight.bold,
                                    color: appSecondaryColor,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black.withOpacity(0.3),
                                          offset: const Offset(1, 2),
                                          blurRadius: 4),
                                    ]),
                                speed: const Duration(milliseconds: 150),
                                cursor: '.'),
                          ],
                          totalRepeatCount: 1,
                          pause: const Duration(milliseconds: 500),
                          displayFullTextOnTap: true,
                          stopPauseOnTap: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
