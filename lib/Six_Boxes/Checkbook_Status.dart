import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rto_flutter/Six_Boxes/vehicle_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api Detail/api_Configration_file.dart';
import '../Dashboard.dart';

late String id2;
late final String localtoken;

class Checkbook_Status extends StatefulWidget {
  final String token;
  final String dopdown_name;
  final bool filter;
  final String titletext;
  const Checkbook_Status(
      {super.key,
      required this.token,
      required this.dopdown_name,
      required this.filter,
      required this.titletext});

  @override
  State<Checkbook_Status> createState() => _Checkbook_StatusState();
}

class _Checkbook_StatusState extends State<Checkbook_Status> {
  TextEditingController _searchController = TextEditingController();
  String? _selectedItem;

  List<String> _dropdownItems = [
    'Pending',
    'Appointment',
    'Complete',
  ];
  static String value = 'Pending';
  bool isLoggedIn = false;
  String _response = '';
  SharedPreferences? _prefs;
  List<dynamic> _booklistdetail = [];
  List<dynamic> _filteredBookListDetail = [];

  // List<dynamic> _vehicleid = [];
  // List<dynamic> _filteredBookListDetail = [];
  int length = 0;
  @override
  void initState() {
    super.initState();
    _selectedItem = _dropdownItems[0];
    _fetchData();
    value = widget.dopdown_name;
    print('valu in initstat');
    print(value);
  }

  void _onTextChanged(String text) {
    setState(() {
      _filteredBookListDetail = _booklistdetail
          .where((item) => item['vehicleRegistrationNumber']
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList();
    });
  }

  Future<void> _fetchData() async {
    String searchWord = _searchController.text;
    if (value == 'Pending') {
      _prefs = await SharedPreferences.getInstance();
      final response = await http.get(
        Uri.parse(
            'http://$api_id/mobileApprouter/getBookList?searchWord=&workStatus=Pending&workCategory='),
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
          _filteredBookListDetail = List.from(_booklistdetail);
        });
        _prefs?.setString('response', _response);
      }
    }
    if (value == 'Appointment') {
      _prefs = await SharedPreferences.getInstance();
      final response = await http.get(
        Uri.parse(
            'http://$api_id/mobileApprouter/getBookList?searchWord=&workStatus=Appointment&workCategory='),
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
          _filteredBookListDetail = List.from(_booklistdetail);
        });
        _prefs?.setString('response', _response);
      }
    }
    if (value == 'Complete') {
      _prefs = await SharedPreferences.getInstance();
      final response = await http.get(
        Uri.parse(
            'http://$api_id/mobileApprouter/getBookList?searchWord=&workStatus=Complete&workCategory='),
        headers: {'Authorization': 'Bearer ${widget.token}'},
      );
      if (response.statusCode == 200) {
        setState(() {
          _response = response.body;

          // _vehiclenumber =
          //     (jsonDecode(response.body)['vehicleRegistrationNumber']);

          _booklistdetail = json.decode(response.body);
          _filteredBookListDetail = List.from(_booklistdetail);
          // _vehicleid = (jsonDecode(response.body)['vehicleRegistrationNumber']);
          length = _booklistdetail.length.toInt();
        });
        _prefs?.setString('response', _response);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double FixedHeight = MediaQuery.of(context).size.height;
    double FixedWidth = MediaQuery.of(context).size.width;

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
                                      token: '$stoken',
                                    )),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                        )),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                    Text(
                      '${widget.titletext}  $length',
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
                    child: widget.filter
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 120,
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
                                    value: _selectedItem,
                                    items: _dropdownItems.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item + ' ',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (values) {
                                      setState(() {
                                        _selectedItem = values;
                                        // print(_selectedItem);
                                        // print(_dropdownItems.indexOf('$_selectedItem'));

                                        value = values!;
                                        print(value);
                                        _fetchData();
                                      });
                                      //get value when changed
                                      // print("You selected $value");
                                    },
                                    style: TextStyle(
                                        color:
                                            Colors.black), // Set the text color
                                    iconEnabledColor: Colors
                                        .white, // Set the arrow icon color
                                    dropdownColor: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: 160,
                                child: TextFormField(
                                  onChanged: (value) {
                                    // Call a function to filter the list based on the entered search text
                                    _filteredBookListDetail;
                                  },
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
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "Enter Vehicle No."),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _fetchData();
                                  });

                                  SnackBar snackbar = SnackBar(
                                    content: Text('Search Button clicked ' +
                                        '$_selectedItem'),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                },
                                icon: const Icon(Icons.search),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 40,
                                width: 160,
                                child: TextFormField(
                                  controller: _searchController,
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
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "Enter Vehicle No."),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SnackBar snackbar = SnackBar(
                                    content: Text('Search Button clicked ' +
                                        '$_selectedItem'),
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
                            final String id =
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
                              id2 = id;
                              print(responseData);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => vehicle_detail(
                                          token: widget.token,
                                          id: '$id',
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
