import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '/constants/enums.dart';

class SharedPreferenceApp {
  getSharedPrefs({spDataType? sharedType, fieldName}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(rem);

    switch (sharedType) {
      case spDataType.string:
        var res = prefs.getString(fieldName);
        return res;
      case spDataType.int:
        return prefs.getInt(fieldName);
      case spDataType.bool:
        return prefs.getBool(fieldName);
      case spDataType.double:
        return prefs.getDouble(fieldName);
      case spDataType.object:
        final rawJson = prefs.getString(fieldName);
        Map<String, dynamic> map = jsonDecode(rawJson!);
        return map;
      default:
        break;
    }
  }

  Future<void> setData({spDataType? sharedType, fieldName, fieldValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (sharedType) {
      case spDataType.string:
        prefs.setString(fieldName, fieldValue);
        break;
      case spDataType.int:
        prefs.setInt(fieldName, fieldValue);
        break;
      case spDataType.bool:
        prefs.setBool(fieldName, fieldValue);
        break;
      case spDataType.double:
        prefs.setDouble(fieldName, fieldValue);
        break;
      case spDataType.object:
        prefs.setString(fieldName, jsonEncode(fieldValue.toJson()));
        break;
      default:
        break;
    }
  }

  clearSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }

  removeOnly(String fieldName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(fieldName);
  }
}
