import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rto_flutter/API%20Detail/API_Detail.dart';

import 'MVC_Dashboard_Screen.dart';

class Controller_Dashboard_Screen {
  // Get All Book Data
  Future<dynamic> AllBookData(String? Token) async {
    var url = Uri.parse(Api_Dashboard_Screen_All_Book_List);

    final headers = {"Authorization": "Bearer $Token"};
    final response = await http.get(url, headers: headers);

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List<MVC_Dashboard_Screen> finalListData = [];

      data.forEach((item) {
        finalListData.add(MVC_Dashboard_Screen.fromJson(item));
      });
      return finalListData;
      // print(finalListData[0].MVC_Variable_VehcleNumber);
    } else {
      var errorResponse = jsonDecode(response.body);
      return errorResponse;
    }
  }
}
