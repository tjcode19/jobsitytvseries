import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jobsitytvseries/constants/colours.dart';
import 'package:jobsitytvseries/constants/strings.dart';
import '../data/repository.dart';
import '/data/shared_preference.dart';
import '/constants/enums.dart';

part 'base_state.dart';

class BaseCubit extends Cubit<BaseState> {
  final Repository? repository;
  final SharedPreferenceApp? sharedPreference;

  BaseCubit({this.repository, this.sharedPreference}) : super(BaseInitial());

  void finishSplashScreen() async {
    // sharedPreference!.removeOnly('userDetails');
    // sharedPreference!.removeOnly('walletBal');

    Timer(const Duration(seconds: 5), () {
      emit(const BaseLoaded(isCompleted: true));
    });

    //To start Splashscreen Animation
    Timer(const Duration(seconds: 0), () {
      emit(const BaseLoadAnim(isStart: true));
    });
  }

  void setFirstTimer({val = false}) async {
    sharedPreference!.setData(
        sharedType: spDataType.bool, fieldName: 'isFirstTime', fieldValue: val);
  }

  getFirstTimer() async {
    bool val = true;
    try {
      val = (await sharedPreference!.getSharedPrefs(
              sharedType: spDataType.bool, fieldName: 'isFirstTime') ??
          false);
    } catch (e) {
      showError(errorMsg: e.toString());
    }

    emit(IsFirstTimer(val: val));
  }

  setPin(context, {pin}) async {
    sharedPreference!.setData(
        sharedType: spDataType.string, fieldName: 'pin', fieldValue: pin);

    showInfo(msg: 'PIN set was successfull');
    Navigator.popAndPushNamed(context, scrMainPage);
  }

  getPin() async {
    String val = "";
    try {
      val = await sharedPreference!.getSharedPrefs(
              sharedType: spDataType.string, fieldName: 'pin') ??
          "";
    } catch (e) {
      showError(errorMsg: e.toString());
    }

    return val;
  }

  void loaderShow() {
    return emit(Loading(show: true));
  }

  void loaderHide() {
    emit(Loading(show: false));
  }

  void loadError({errMsg}) {
    emit(AppError(show: true, msg: errMsg));
    Timer(const Duration(seconds: 3), () {
      emit(AppError(show: false));
    });
  }

  showLoading({String? title, dismissOnTap = true}) async {
    EasyLoading.instance.backgroundColor = appPrimaryColor;
    await EasyLoading.show(
        status: title,
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: dismissOnTap);
  }

  hideLoading() async {
    await EasyLoading.dismiss();
  }

  showError(
      {String errorMsg = 'Error occured',
      type = ErrorMsgType.modal,
      toastPosition = EasyLoadingToastPosition.top}) {
    EasyLoading.instance.backgroundColor = Colors.red[300];
    EasyLoading.instance.maskColor = Colors.red.withOpacity(0.1);

    if (type == ErrorMsgType.modal) {
      EasyLoading.showError(
        errorMsg,
        maskType: EasyLoadingMaskType.custom,
      );
    } else {
      EasyLoading.showToast(errorMsg, toastPosition: toastPosition);
    }
  }

  showInfo(
      {msg = 'Info',
      type = ErrorMsgType.modal,
      toastPosition = EasyLoadingToastPosition.top}) {
    EasyLoading.instance.backgroundColor = Colors.grey;
    EasyLoading.instance.maskColor = Colors.red.withOpacity(0.1);

    if (type == ErrorMsgType.modal) {
      EasyLoading.showError(
        msg,
        maskType: EasyLoadingMaskType.custom,
      );
    } else {
      EasyLoading.showToast(msg, toastPosition: toastPosition);
    }
  }
}
