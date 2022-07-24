import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobsitytvseries/constants/colours.dart';

Widget textInputField(context,
    {hintTex,
    controller,
    isObscure = false,
    enabled = true,
    TextInputType? textInputType,
    textCap = TextCapitalization.none,
    onChange,
    bool isMoneyField = false,
    String currency = 'GBP',
    Widget? sufIcon,
    Widget? preIcon,
    int? maxLength,
    validator}) {
  return TextFormField(
    controller: controller,
    obscureText: isObscure,
    obscuringCharacter: '*',
    maxLength: maxLength,
    cursorColor: appFormTextColor,
    keyboardType: textInputType,
    textCapitalization: textCap,
    style: const TextStyle(color: bodyTextColor, fontWeight: FontWeight.w500),
    onChanged: onChange,
    validator: validator,
    decoration: InputDecoration(
        border: const OutlineInputBorder(
          gapPadding: 0.0,
          borderSide: BorderSide(
            color: appFormFieldLineColor,
          ),
        ),
        errorStyle: TextStyle(
          color: Theme.of(context).errorColor,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: appFormFieldLineColor,
          ),
        ),
        counterStyle: const TextStyle(
          height: double.minPositive,
        ),
        counterText: "",
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: appFormFieldLineColor,
          ),
        ),
        suffixIcon: sufIcon,
        prefixIcon: preIcon,
        suffixIconConstraints:
            const BoxConstraints(minHeight: 24, minWidth: 24),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appPrimaryColorLight),
        ),
        hintText: hintTex,
        hintStyle: const TextStyle(color: Color(0xFF9B9B9B), fontSize: 13.0),
        enabled: enabled,
        prefix: (isMoneyField) ? Text('$currency ') : null,
        fillColor: whiteColour,
        filled: true),
  );
}
