import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Api Detail/api_Configration_file.dart';

late final String localtoken;

class Delar_Detail extends StatefulWidget {
  final String token;
  final String id;

  const Delar_Detail({super.key, required this.token, required this.id});

  @override
  State<Delar_Detail> createState() => _Delar_DetailState();
}

class _Delar_DetailState extends State<Delar_Detail> {
  Map<String, dynamic> data = {};
  Future<void> getData() async {
    final response = await http.get(
      Uri.parse(
          'http://$api_id/dealerrouter/getDealerDetailsById?dealerId=${widget.id}'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );

    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  // late Map<String, dynamic> data;
  // bool isLoggedIn = false;
  // String _response = '';
  // SharedPreferences? _prefs;
  // List<dynamic> _booklistdetail = [];
  // int length = 1;
  //
  // List<modelclass> detailist = [];

  @override
  void initState() {
    // fetchData();
    super.initState();
    getData();
  }
  // Future<List<modelclass>> fetchData() async {
  //   // _prefs = await SharedPreferences.getInstance();
  //   final response = await http.get(
  //     Uri.parse('http://192.168.0.114:8003/mobileApprouter/getBookList'),
  //     headers: {'Authorization': 'Bearer ${widget.token}'},
  //   );
  //   var data = jsonDecode(response.body.toString());
  //   if (response.statusCode == 200) {
  //     for (Map i in data) {
  //       // print(i['Vehicle Details']);
  //       Map<String, dynamic> data = jsonDecode(response.body);
  //       print(data['Vehicle Details']);
  //       // print(data['Owner Details']['Address']);
  //       // print(data['Insurance Details']['Policy Number']);
  //       // print(data['Status']['Status']);
  //       // print(data['Customer Details']['workType']);
  //     }
  //     return detailist;
  //   } else {
  //     return detailist;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final Decoration Bluebox_Decoration = BoxDecoration(
      color: Colors.blue,
      boxShadow: [
        BoxShadow(
          offset: Offset(4, 5),
          blurRadius: 5,
          color: Colors.black.withOpacity(0.3),
        ),
      ],
      borderRadius: BorderRadius.circular(10),
    );

    var arraybox_title = [
      'vehicle detail',
      'vehicle buyer detail',
      'vehicle insurance detail',
      'vehicle insurance detail',
    ];
    var arrayname_title = [
      'Name',
      'Name',
      'Name',
      'Name',
    ];
    var arrayname_data = ['mihie', 'mihir', 'gandhi', 'hello'];

    var arrayaddresh_title = ['addresh', 'addresh', 'addresh', 'addresh'];
    var arrayaddresh_data = ['rajkot', 'junagadh', 'jamnagar', 'ahemdabad'];

    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //         begin: Alignment.topLeft,
                //         end: Alignment.bottomRight,
                //         colors: [
                //       Color(0xff1a73e8),
                //       Color(0xff1a73e8),
                //     ])),
                height: 60,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => Dashboard(
                          //             token: '$stoken',
                          //           )),
                          // );
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                        )),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                    Text(
                      'Delar Detail',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              new Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40)),
                  ),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var key = data.keys.elementAt(index);
                      var value = data[key];
                      print(value.toString());

                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(4, 5),
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.fromLTRB(20, 40, 20, 10),
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              margin: EdgeInsets.fromLTRB(20, 45, 0, 0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var entry in value.entries)
                                      Text(
                                        entry.key +
                                            ' :- ' +
                                            entry.value.toString(),
                                        style: TextStyle(fontSize: 15),
                                        textAlign: TextAlign.left,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -10,
                            left: 30,
                            right: 30,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 350,
                              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                              decoration: Bluebox_Decoration,
                              child: Text(
                                key,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    itemCount: data.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
