import 'package:flutter/material.dart';
import 'package:jobsitytvseries/constants/colours.dart';
import 'package:jobsitytvseries/constants/enums.dart';
import 'package:jobsitytvseries/constants/strings.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/buttons_widget.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/main_page_container.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/otp_widget.dart';
import 'package:jobsitytvseries/utils/device_utils.dart';

class Authoriser extends StatefulWidget {
  const Authoriser({Key? key}) : super(key: key);

  @override
  State<Authoriser> createState() => _AuthoriserState();
}

class _AuthoriserState extends State<Authoriser> {
  @override
  Widget build(BuildContext context) {
    return MainContainer(
      backAction: () {},
      child: Container(
        height: DeviceUtils.getScaledHeight(context, 1.0),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome'),
            Text('Kindly set your PIN'),
            CustomOtpField(length: 4, completeAction: (val) {}),
            CustomOtpField(length: 4, completeAction: (val) {}),
            CustomLayout.xlPad.sizedBoxH,
            // SizedBox(
            //   height: 50,
            //   child: elevatedButton(
            //       context: context,
            //       txt: "Set",
            //       action: () async {
            //         DeviceUtils.hideKeyboard(context);

            //         //  Map<String, dynamic>? newData = widget.data;

            //         if (formKey.currentState!.validate()) {
            //           final providerContext =
            //               BlocProvider.of<SignupCubit>(context);

            //           // newData!.update("retrieval_pin",
            //           //     (value) => value = _pinController.text);

            //           var res = await providerContext.createProfile(
            //               CreateUserRequest(
            //                   country: widget.userData!.country,
            //                   email: widget.userData!.email,
            //                   name: _nameController.text,
            //                   password: _passwordController.text,
            //                   referralCode: _refCodeController.text));

            //           print('wait for $res');
            //           var l = providerContext.state.props;

            //           // print('wait for $l');

            //           if (l.isNotEmpty) if (l[0] == true) {
            //             successBottomSheet(context);
            //           }
            //         }

            //         // successBottomSheet(context);
            //       }),
            // ),
            CustomLayout.mPad.sizedBoxH,
            GestureDetector(
              onTap: () => Navigator.popAndPushNamed(context, scrMainPage),
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
      ),
    );
  }
}
