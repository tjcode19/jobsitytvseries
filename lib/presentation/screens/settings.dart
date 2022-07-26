import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/constants/enums.dart';
import '/cubit/base_cubit.dart';
import '/presentation/shared_widgets/otp_widget.dart';
import '/presentation/shared_widgets/screen_title.dart';
import '/presentation/shared_widgets/secured_main_container.dart';
import '/utils/device_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController oldPin = TextEditingController();
  TextEditingController newPin = TextEditingController();
  TextEditingController confirmPin = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SecuredMainContainer(
      pageLabel: const ScreenTitle(
        title: 'Change Pin',
        subTitle: 'Update your PIN',
      ),
      pageLabelIcon: Container(),
      child: Column(
        children: [
          SizedBox(
            width: DeviceUtils.getScaledWidth(context, 0.8),
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
                CustomLayout.xlPad.sizedBoxH,
                const Text(
                  'If you feel your PIN has been compromised, change it.',
                  style: TextStyle(fontSize: 13.0),
                ),
                CustomLayout.lPad.sizedBoxH,
                const Text('Enter Current PIN'),
                CustomOtpField(
                  length: 4,
                  txtEditingController: oldPin,
                  completeAction: (val) async {
                    var pin =
                        await BlocProvider.of<BaseCubit>(context).getPin();

                    if (pin != val) {
                      BlocProvider.of<BaseCubit>(context).showError(
                          errorMsg: 'Invalid Current PIN',
                          type: ErrorMsgType.toast,
                          toastPosition: EasyLoadingToastPosition.bottom);
                    }
                  },
                  shape: PinCodeFieldShape.circle,
                ),
                CustomLayout.mPad.sizedBoxH,
                const Text('Enter PIN'),
                CustomOtpField(
                  length: 4,
                  txtEditingController: newPin,
                  completeAction: (val) {
                    newPin.text = val;
                  },
                  shape: PinCodeFieldShape.circle,
                ),
                CustomLayout.lPad.sizedBoxH,
                const Text('Confirm PIN'),
                CustomOtpField(
                  length: 4,
                  txtEditingController: confirmPin,
                  completeAction: (val) {
                    if (newPin.text != val) {
                      BlocProvider.of<BaseCubit>(context).showError(
                          errorMsg: 'PIN must match',
                          type: ErrorMsgType.toast,
                          toastPosition: EasyLoadingToastPosition.bottom);
                    } else {
                      BlocProvider.of<BaseCubit>(context)
                          .setPin(context, pin: val);
                    }
                  },
                  shape: PinCodeFieldShape.circle,
                ),
                CustomLayout.xlPad.sizedBoxH,
              ],
            ),
          )
        ],
      ),
    );
  }
}
