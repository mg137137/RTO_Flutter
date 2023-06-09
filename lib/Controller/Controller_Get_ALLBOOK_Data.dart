import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rto_flutter/Api%20Detail/api_Configration_file.dart';

import '../MVC/MVC VehicleNumber With ID.dart';

class Controller_Get_Allbook_Data {
  Future<dynamic> AllBookData(String? Token) async {
    var url = Uri.parse(api_get_all_book_list);

    final headers = {"Authorization": "Bearer $Token"};
    final response = await http.get(url, headers: headers);

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List<MVC_VehicleNumber_With_ID> finalListData = [];

      data.forEach((item) {
        finalListData.add(MVC_VehicleNumber_With_ID.fromJson(item));
      });
      return finalListData;
      // print(finalListData[0].MVC_Variable_VehcleNumber);
    } else {
      var errorResponse = jsonDecode(response.body);
      return errorResponse;
    }
  }
}
