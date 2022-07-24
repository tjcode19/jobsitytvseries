import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'custom_exception.dart';
import 'shared_preference.dart';
import '/constants/enums.dart';

// import 'CustomException.dart';

class ApiProvider {
  final String _baseUrl = "https://api.tvmaze.com/";
  final SharedPreferenceApp? _sharedPreferenceQS = SharedPreferenceApp();

  String? token;
  Map<String, String>? headers;
  Map<String, String>? headerLogin;
  var timeOut = 60;

  getTokenPref() async {
    try {
      token = await _sharedPreferenceQS!
          .getSharedPrefs(sharedType: spDataType.string, fieldName: 'token');
    } catch (e) {
      print(e);
    }

    headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
  }

  Future<dynamic> get(String url) async {
    var responseJson;
    await getTokenPref();
    try {
      final response =
          await http.get(Uri.parse(_baseUrl + url), headers: headers);

         
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthorisedException {
      throw UnauthorisedException('Token Expired');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var responseJson;
    await getTokenPref();
    try {
      final response =
          await http.delete(Uri.parse(_baseUrl + url), headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthorisedException {
      throw UnauthorisedException('Token Expired');
    }
    return responseJson;
  }

 

  Future<Map<String, dynamic>> post(String url, Map body) async {
    var responseJson;
    await getTokenPref();
    try {
      final response = await http
          .post(
        Uri.parse(_baseUrl + url),
        headers: headers,
        body: jsonEncode(body),
      )
          .timeout(
        Duration(seconds: timeOut),
        onTimeout: () {
          // return null;
          throw TimeoutException('Time out');
        },
      );
       inspect(response);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthorisedException {
      throw UnauthorisedException('Token Expired');
    }
    return responseJson;
  }


  dynamic _response(http.Response response) {
    // var tokenExp =
    //     jsonEncode({"response_code": "06", 'response_description': 'Failed'});

    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        log('ApiProdider: $responseJson');
        return responseJson;

      case 401:
        var responseJson = json.decode(response.body.toString());
        log('ApiProdider: $responseJson');
        return responseJson;

      default:
        var responseJson = json.decode(response.body.toString());
        log('ApiProdider: $responseJson');
        // print(response);
        return responseJson;
    }
  }
}
