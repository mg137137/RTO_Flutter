import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rto_flutter/MVC/MVC_LOGIN.dart';

import '../Api Detail/api_Configration_file.dart';

class Controller_Post_Login {
  Future<dynamic> LoginUser(Map<String, dynamic> loginUserData) async {
    var url = Uri.parse(api_login);
    //String bodyData = jsonEncode(loginUserData);
    final response = await http.post(url, body: loginUserData);
    print('');
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      MVC_LOGIN loginData = MVC_LOGIN.fromJson(data);
      return loginData;
    } else {
      var errorResponse = jsonDecode(response.body);
      return errorResponse;
    }
  }
}
