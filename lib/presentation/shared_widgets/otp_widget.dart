import 'dart:async';

import 'package:flutter/material.dart';
import '/constants/colours.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomOtpField extends StatefulWidget {
  final completeAction;
  final int length;
  final TextEditingController? txtEditingController;
  final FocusNode? focusNode;
  final PinCodeFieldShape shape;

  const CustomOtpField(
      {Key? key,
      required this.completeAction,
      this.length = 6,
      this.txtEditingController,
      this.shape = PinCodeFieldShape.underline,
      this.focusNode})
      : super(key: key);

  @override
  _CustomOtpFieldState createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  // final completeAction;
  // _CustomOtpFieldState({this.completeAction});
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    // errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: const TextStyle(
        color: appPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
      length: widget.length,
      obscureText: true,
      obscuringCharacter: '*',
      obscuringWidget: Image.asset(
        'assets/images/logo1.png',
        width: 18,
        height: 18,
      ),
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      // validator: (v) {
      //   if (v!.length < 3) {
      //     return "I'm from validator";
      //   } else {
      //     return null;
      //   }
      // },
      pinTheme: PinTheme(
          shape: widget.shape,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          selectedColor: appPrimaryColor,
          disabledColor: appPrimaryColor,
          activeFillColor: Colors.white,
          inactiveColor: appPrimaryColorLight,
          activeColor: appPrimaryColor),
      cursorColor: appPrimaryColor,
      animationDuration: const Duration(milliseconds: 200),
      enableActiveFill: false,
      errorAnimationController: errorController,
      controller: widget.txtEditingController,
      keyboardType: TextInputType.number,
      focusNode: widget.focusNode,
      // boxShadows: [
      //   BoxShadow(
      //     offset: Offset(0, 1),
      //     color: Colors.black12,
      //     blurRadius: 10,
      //   )
      // ],
      onCompleted: widget.completeAction,
      // onTap: () {
      //   print("Pressed");
      // },
      onChanged: (value) {
        setState(() {
          currentText = value;
        });
      },
      beforeTextPaste: (text) {
        // print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }
}
