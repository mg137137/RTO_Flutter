import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rto_flutter/Screens/Login%20Screnn/MVC_Login_Screen.dart';

import '../../Api Detail/API_Detail.dart';

class Controller_Login_Screen {
  Future<dynamic> LoginUser(Map<String, dynamic> loginUserData) async {
    var url = Uri.parse(API_Login_Screen);
    final response = await http.post(url, body: loginUserData);
    print('');
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      MVC_Login_Screen loginData = MVC_Login_Screen.fromJson(data);
      return loginData;
    } else {
      var errorResponse = jsonDecode(response.body);
      return errorResponse;
    }
  }
}
