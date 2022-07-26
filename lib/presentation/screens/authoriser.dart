import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jobsitytvseries/constants/colours.dart';
import 'package:jobsitytvseries/constants/enums.dart';
import 'package:jobsitytvseries/constants/strings.dart';
import 'package:jobsitytvseries/cubit/base_cubit.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/otp_widget.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/screen_title.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/secured_main_container.dart';
import 'package:jobsitytvseries/utils/device_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Authoriser extends StatefulWidget {
  const Authoriser({Key? key}) : super(key: key);

  @override
  State<Authoriser> createState() => _AuthoriserState();
}

class _AuthoriserState extends State<Authoriser> {
  TextEditingController pin = TextEditingController();
  TextEditingController confirmPin = TextEditingController();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<BaseCubit>(context).getFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SecuredMainContainer(
      pageLabel: const ScreenTitle(
        title: 'TV Series',
        subTitle: 'Welcome here',
      ),
      pageLabelIcon: Container(),
      child: BlocBuilder<BaseCubit, BaseState>(
        buildWhen: (prevState, state) {
          return prevState != state;
        },
        builder: (context, state) {
          if (state is IsFirstTimer) {
            if (state.val!) {
              return SizedBox(
                width: DeviceUtils.getScaledWidth(context, 0.75),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Icon(
                        Icons.lock_outlined,
                        size: 70,
                      ),
                    ),
                    CustomLayout.lPad.sizedBoxH,
                    const Text(
                      'You might want to protect your app from unathorised access.',
                      style: TextStyle(fontSize: 17.0),
                    ),
                    CustomLayout.sPad.sizedBoxH,
                    const Text('Kindly set your PIN'),
                    CustomLayout.mPad.sizedBoxH,
                    CustomOtpField(
                      length: 4,
                      txtEditingController: pin,
                      completeAction: (val) {
                        pin.text = val;
                      },
                      shape: PinCodeFieldShape.circle,
                    ),
                    CustomLayout.lPad.sizedBoxH,
                    const Text('Confirm PIN'),
                    CustomOtpField(
                      length: 4,
                      txtEditingController: confirmPin,
                      completeAction: (val) {
                        if (pin.text != val) {
                          BlocProvider.of<BaseCubit>(context).showError(
                              errorMsg: 'PIN must match',
                              type: ErrorMsgType.toast,
                              toastPosition: EasyLoadingToastPosition.bottom);
                        } else {
                          BlocProvider.of<BaseCubit>(context)
                              .setPin(context, pin: val);
                          BlocProvider.of<BaseCubit>(context).setFirstTimer();
                          Navigator.popAndPushNamed(context, scrHomePage);
                        }
                      },
                      shape: PinCodeFieldShape.circle,
                    ),
                    CustomLayout.xlPad.sizedBoxH,
                    CustomLayout.mPad.sizedBoxH,
                    GestureDetector(
                      onTap: () =>
                          Navigator.popAndPushNamed(context, scrHomePage),
                      child: Center(
                        child: RichText(
                          text: const TextSpan(
                            text: 'You do not want to set PIN now?',
                            children: [
                              TextSpan(
                                text: ' Continue',
                                style: TextStyle(
                                  color: appPrimaryColor,
                                ),
                              )
                            ],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: bodyTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox(
                width: DeviceUtils.getScaledWidth(context, 0.75),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Icon(
                        Icons.lock_outlined,
                        size: 70,
                      ),
                    ),
                    CustomLayout.lPad.sizedBoxH,
                    const Text(
                      'Welcome back',
                      style: TextStyle(fontSize: 17.0),
                    ),
                    CustomLayout.sPad.sizedBoxH,
                    const Text('Kindly enter your PIN for authentication'),
                    CustomLayout.mPad.sizedBoxH,
                    CustomOtpField(
                      length: 4,
                      completeAction: (val) async {
                        var pin =
                            await BlocProvider.of<BaseCubit>(context).getPin();

                        if (pin == val) {
                          Navigator.popAndPushNamed(context, scrHomePage);
                        } else {
                          BlocProvider.of<BaseCubit>(context).showError(
                              errorMsg: 'Invalid PIN',
                              type: ErrorMsgType.toast,
                              toastPosition: EasyLoadingToastPosition.bottom);
                        }
                      },
                      shape: PinCodeFieldShape.circle,
                    ),
                    CustomLayout.lPad.sizedBoxH,
                    CustomLayout.mPad.sizedBoxH,
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<BaseCubit>(context)
                            .setFirstTimer(val: true);
                      },
                      child: Center(
                        child: RichText(
                          text: const TextSpan(
                            text: 'You forgot your PIN?',
                            children: [
                              TextSpan(
                                text: ' Reset Now',
                                style: TextStyle(
                                  color: appPrimaryColor,
                                ),
                              )
                            ],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: bodyTextColor,
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
          return Container();
        },
      ),
    );
  }
}
