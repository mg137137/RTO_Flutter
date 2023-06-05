import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage3 extends StatefulWidget {
  final String token;

  MyHomePage3({required this.token});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage3> {
  String _response = '';
  SharedPreferences? _prefs;
  List<dynamic> _vehiclenumber = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    _prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('http://192.168.100.3:8003/mobileApprouter/getBookList'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );
    if (response.statusCode == 200) {
      setState(() {
        _response = response.body;

        // _vehiclenumber =
        //     (jsonDecode(response.body)['vehicleRegistrationNumber']);

        _vehiclenumber = json.decode(response.body);
      });
      _prefs?.setString('response', _response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: _vehiclenumber.isNotEmpty
          ? ListView.builder(
              itemCount: _vehiclenumber.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_vehiclenumber[index]['vehicleRegistrationId']),
                  subtitle:
                      Text(_vehiclenumber[index]['vehicleRegistrationNumber']),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
