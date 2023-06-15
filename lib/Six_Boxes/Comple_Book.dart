import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rto_flutter/Six_Boxes/vehicle_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api Detail/API_Detail.dart';
import '../Screens/Dashboard Screen/Dashboard_Screen.dart';

late final String id1;
late final String localtoken;

class tto_Booklist extends StatefulWidget {
  final String token;
  const tto_Booklist({super.key, required this.token});

  @override
  State<tto_Booklist> createState() => _tto_BooklistState();
}

class _tto_BooklistState extends State<tto_Booklist> {
  bool isLoggedIn = false;
  String _response = '';
  SharedPreferences? _prefs;
  List<dynamic> _booklistdetail = [];
  // List<dynamic> _vehicleid = [];
  int length = 1;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    _prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse(
          'http://$API_Base/mobileApprouter/getBookList?searchWord=&workStatus=Complete&workCategory='),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );
    if (response.statusCode == 200) {
      setState(() {
        _response = response.body;

        // _vehiclenumber =
        //     (jsonDecode(response.body)['vehicleRegistrationNumber']);

        _booklistdetail = json.decode(response.body);
        // _vehicleid = (jsonDecode(response.body)['vehicleRegistrationNumber']);
        length = _booklistdetail.length.toInt();
      });
      _prefs?.setString('response', _response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                height: 110,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard(
                                      token: '${widget.token}',
                                    )),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                        )),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                    Text(
                      'TTO Book List   $length',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 40,
                left: 25,
                right: 25,
                child: Container(
                  alignment: Alignment.center,
                  height: 65,
                  width: 350,
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(4, 5),
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.3),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.blue,
                                  Colors.lightBlueAccent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              icon: const Icon(Icons.filter_list),
                              value: "Filter 1",
                              items: const [
                                //add items in the dropdown
                                DropdownMenuItem(
                                    value: "Filter 1", child: Text("Filter 1")),

                                DropdownMenuItem(
                                  value: "Filter 2",
                                  child: Text("Filter 2"),
                                ),

                                DropdownMenuItem(
                                  value: "Filter 3",
                                  child: Text("Filter 3"),
                                )
                              ],
                              onChanged: (value) {
                                //get value when changed
                                // print("You selected $value");
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 160,
                          child: TextFormField(
                            //controller: _phoneController,
                            // cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.black12,
                                ),
                                border: InputBorder.none,
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(5),
                                //   borderSide: const BorderSide(),
                                // ),
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Enter Vehicle No."),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            SnackBar snackbar = const SnackBar(
                              content: Text('Search Button clicked'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          },
                          icon: const Icon(Icons.search),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(4, 5),
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // margin: EdgeInsets.fromLTRB(10, 45, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _booklistdetail[index]['vehicleRegistrationNumber'],
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            String id =
                                _booklistdetail[index]['vehicleRegistrationId'];

                            // final url = Uri.parse(
                            //     'http://192.168.0.104:8003/vehicleRegistrationrouter/getVehicleRegistrationDetailsById?vehicleRegistrationId=$id');
                            //
                            // final response = await http.get(url);

                            final response = await http.get(
                              Uri.parse('$api_TTO_Book_List' + '$id'),
                              headers: {
                                'Authorization': 'Bearer ${widget.token}'
                              },
                            );

                            if (response.statusCode == 200) {
                              // If the server did return a 200 OK response, parse the JSON.
                              final responseData = json.decode(response.body);
                              id1 = id;
                              print(responseData);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => vehicle_detail(
                                          token: widget.token,
                                          id: '$id1',
                                        )),
                              );
                              return responseData;
                            } else {
                              // If the server did not return a 200 OK response, throw an error.
                              throw Exception('Failed to load data');
                            }
                            //
                            // print(id);
                            // final responseData = await fetchData(id);
                            // // Use the response data as needed
                            // print(responseData);
                          },
                          icon: const Icon(Icons.remove_red_eye_outlined),
                          label: const Text('View'),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: _booklistdetail.length,
            ),
          ),
        ),
      ],
    ));
  }
}
