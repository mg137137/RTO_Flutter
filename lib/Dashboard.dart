import 'dart:convert';

import 'package:darq/darq.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:rto_flutter/Controller/Controller_Get_ALLBOOK_Data.dart';
import 'package:rto_flutter/MVC/MVC%20VehicleNumber%20With%20ID.dart';
import 'package:rto_flutter/Six_Boxes/All_Book.dart';
import 'package:rto_flutter/Six_Boxes/Categorywise_Book.dart';
import 'package:rto_flutter/Six_Boxes/Checkbook_Status.dart';
import 'package:rto_flutter/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Api Detail/api_Configration_file.dart';
import 'Delar List Button/Delar List Home.dart';
import 'Six_Boxes/vehicle_detail.dart';

List<String> statess = [];
List<MVC_VehicleNumber_With_ID> searchDataList = [];
List<String> statess_id = [];
var findingid;
bool statess_check = false;
bool Logout = false;
String name = '';
String TotalBookNumber = '', Pendingbook = '', Appointment = '', Complete = '';
String stoken = '';
TextEditingController _vehiclesearch = TextEditingController();
String searchdata = '';

class Dashboard extends StatefulWidget {
  final String token;
  const Dashboard({super.key, required this.token});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late MVC_VehicleNumber_With_ID Local_VehicleNumber_And_Id;
  final controller_get_allbook_data = Controller_Get_Allbook_Data();
  Map<String, dynamic> data = {};
  List<dynamic> _booklistdetail = [];

  bool isLoggedIn = false;
  String _response = '';
  SharedPreferences? _prefs;
  List<dynamic> _delardetail = [];
  List<dynamic> _Totalbooknumber = [];

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
    _fetchData();
    _fetchNumber();

    print('before all book');
    _AllBook();
  }

  @override
  void dispose() {
    _vehiclesearch.dispose();
    super.dispose();
  }

  Future<void> _AllBook() async {
    dynamic delar_list_result =
        await controller_get_allbook_data.AllBookData('${widget.token}');

    if (delar_list_result is List<MVC_VehicleNumber_With_ID>) {
      print(delar_list_result.length);
      searchDataList = delar_list_result;
      for (var i = 0; i < searchDataList.length; i++) {
        setState(() {
          statess.add(searchDataList[i].MVC_Variable_VehcleNumber!);
        });
      }
    } else {
      var errorResponse = delar_list_result;
      print('THE EROOR RESPONSE IS ' + errorResponse);
    }
  }

  Future<void> _fetchData() async {
    _prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('$api_Dashboard_Dealer_List'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );
    if (response.statusCode == 200) {
      setState(() {
        _response = response.body;

        // _vehiclenumber =
        //     (jsonDecode(response.body)['vehicleRegistrationNumber']);

        _delardetail = json.decode(response.body);
      });
      _prefs?.setString('response', _response);
    }
  }

  Future<void> _fetchNumber() async {
    _prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('$api_Dashboard_Count_Number'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );
    _response = response.body;

    if (response.statusCode == 200) {
      setState(() {
        print(_response);
        // print(_response.('AllBook'));
        // data = (jsonDecode(response.body)[AllBook]);
        TotalBookNumber = (jsonDecode(response.body)['AllBook']).toString();
        Pendingbook = (jsonDecode(response.body)['AllPendingBook']).toString();
        Appointment =
            (jsonDecode(response.body)['AllAppointmentBook']).toString();
        Complete = (jsonDecode(response.body)['AllCompleteBook']).toString();
        print(TotalBookNumber);
        // print(data);
      });
      _prefs?.setString('response', _response);
    }
  }

  Future<void> _checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? U_Name = prefs.getString('userName');

    setState(() {
      isLoggedIn = token != null && U_Name != null;
      name = U_Name.toString();
      stoken = token.toString();
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userName');

    setState(() {
      isLoggedIn = false;
    });
  }

  final TextEditingController _typeAheadController = TextEditingController();

  final Decoration sixboxdecoration = BoxDecoration(boxShadow: [
    BoxShadow(
      offset: const Offset(4, 5),
      blurRadius: 5,
      color: Colors.black.withOpacity(0.3),
    ),
  ], borderRadius: BorderRadius.circular(10), color: Colors.white);

  @override
  Widget build(BuildContext context) {
    double FixedHeight = MediaQuery.of(context).size.height;
    double FixedWidth = MediaQuery.of(context).size.width;
    // For Full Screen View
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Container(
              //   color: Colors.white,
              // ),

              Container(
                height: FixedHeight * 0.31,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: [
                              Text(
                                'RTO Agent Management',
                                style: TextStyle(
                                    fontSize: FixedHeight * 0.025,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Work for RTO',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FixedHeight * 0.021,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (isLoggedIn) {
                                _logout();

                                print('logout sucessful');
                                Logout = true;
                                if (Logout = true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login_Page()),
                                  );
                                }
                              } else {
                                print('the else part called');
                              }
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => Loginpage()),
                              // );
                            },
                            child: Column(
                              children: const [
                                Icon(Icons.logout),
                                Text("logout"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: FixedHeight * 0.04,
                              top: FixedHeight * 0.01,
                              right: FixedHeight * 0.01),
                          child: SizedBox(
                            height: FixedHeight * 0.15,
                            width: FixedWidth * 0.25,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/download.jpg'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: [
                              Text(
                                'Welcome',
                                style: TextStyle(
                                  fontSize: FixedHeight * 0.025,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '$name',
                                style: TextStyle(
                                    fontSize: FixedHeight * 0.035,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
// middle screen of searchbar and dropdown and enter vehicle number field here
              Positioned(
                top: FixedHeight * 0.26,
                left: FixedHeight * 0.04,
                right: FixedHeight * 0.04,
                child: Container(
                  alignment: Alignment.center,
                  height: FixedHeight * 0.08,
                  width: FixedWidth * 0.35,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(4, 5),
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.3),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: FixedHeight * 0.01, right: FixedHeight * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: IconButton(
                            onPressed: () {
                              searchdata = _vehiclesearch.text;

                              SnackBar snackbar = SnackBar(
                                content: Text(searchdata),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            },
                            icon: const Icon(Icons.search),
                          ),
                        ),
                        Container(
                          width: FixedWidth * 0.7,
                          child: TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintText: 'Enter Vehicle Number'),
                                controller: _typeAheadController,
                              ),
                              suggestionsCallback: (pattern) async {
                                return await StateService.getSuggestions(
                                    pattern);
                              },
                              transitionBuilder:
                                  (context, suggestionsBox, controller) {
                                return suggestionsBox;
                              },
                              itemBuilder: (context, suggestion) {
                                return InkWell(
                                  onTap: () {
                                    var findigvariable = suggestion;
                                    print(findigvariable);
                                    var list = searchDataList;

                                    for (var item in list) {
                                      print(item.MVC_Variable_VehcleNumber);
                                      if (findigvariable ==
                                          item.MVC_Variable_VehcleNumber) {
                                        setState(() {
                                          findingid =
                                              item.MVC_Variable_VehicleID;
                                          print(findingid);
                                        });
                                      }
                                    }

                                    // var result = list.select((element, index) => element.MVC_Variable_VehicleID).where((element) => (i)=>)
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                vehicle_detail(
                                                    token: '${widget.token}',
                                                    id: '$findingid')));
                                  },
                                  child: ListTile(
                                    title: Text(suggestion),
                                  ),
                                );
                              },
                              onSuggestionSelected: (suggestion) {
                                _typeAheadController.text = suggestion;
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, FixedHeight * 0.36, 0, 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: FixedHeight * 0.06,
                      width: FixedWidth * 0.75,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(4, 5),
                              blurRadius: 20,
                              color: Colors.black.withOpacity(0.3),
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(FixedHeight * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Book :- ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: FixedHeight * 0.03),
                            ),
                            Text(
                              '$TotalBookNumber',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: FixedHeight * 0.03),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, FixedHeight * 0.02, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            // alignment: Alignment.center,
                            decoration: sixboxdecoration,
                            height: FixedHeight * 0.11,
                            width: FixedWidth * 0.25,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Checkbook_Status(
                                            token: '$stoken',
                                            dopdown_name: 'Pending',
                                            filter: false,
                                            titletext: 'Pending Books',
                                          )),
                                );
                              },
                              child: Text(
                                '$Pendingbook' + '\nPending' + '\nDocuments',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            height: FixedHeight * 0.11,
                            width: FixedWidth * 0.25,
                            decoration: sixboxdecoration,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Checkbook_Status(
                                            token: '$stoken',
                                            dopdown_name: 'Appointment',
                                            filter: false,
                                            titletext: 'Appointment Books',
                                          )),
                                );
                              },
                              child: Text(
                                '$Appointment' +
                                    '\nAppoitment' +
                                    '\nVehicleDetail',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            height: FixedHeight * 0.11,
                            width: FixedWidth * 0.25,
                            decoration: sixboxdecoration,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Checkbook_Status(
                                            token: '$stoken',
                                            dopdown_name: 'Complete',
                                            filter: false,
                                            titletext: 'Complete Books',
                                          )),
                                );
                              },
                              child: Text(
                                '$Complete' + '\nComplete' + '\nTTO Book',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, FixedHeight * 0.02, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: FixedHeight * 0.11,
                            width: FixedWidth * 0.25,
                            decoration: sixboxdecoration,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => All_Book(
                                            token: '$stoken',
                                          )),
                                );
                              },
                              child: const Text(
                                'All Book',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          // Container(
                          //   height: FixedHeight * 0.11,
                          //   width: FixedWidth * 0.25,
                          //   decoration: sixboxdecoration,
                          //   child: TextButton(
                          //     onPressed: () {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => testing_delar(
                          //                   token: '$stoken',
                          //                   id: 'Dealer_1684852413669_li0dmin9',
                          //                 )),
                          //       );
                          //     },
                          //     child: const Text(
                          //       'TESTING BOOK',
                          //       style: TextStyle(fontWeight: FontWeight.bold),
                          //     ),
                          //   ),
                          // ),
                          Container(
                            height: FixedHeight * 0.11,
                            width: FixedWidth * 0.25,
                            decoration: sixboxdecoration,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Catogerywise_Book(
                                            token: '$stoken',
                                            dropdown_Value: 0,
                                          )),
                                );
                              },
                              child: Text(
                                '  Category \n Wise Book',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: FixedHeight * 0.11,
                            width: FixedWidth * 0.25,
                            decoration: sixboxdecoration,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Checkbook_Status(
                                            token: '$stoken',
                                            dopdown_name: 'Pending',
                                            filter: true,
                                            titletext: 'Book Status',
                                          )),
                                );
                              },
                              child: const Text(
                                'Check Book\n     Status',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //Delar List Button

              Padding(
                padding: EdgeInsets.fromLTRB(
                    FixedHeight * 0.025, FixedHeight * 0.71, 0, 0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Delar_List_home(
                                  token: '$stoken',
                                )),
                      );
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: FixedHeight * 0.06,
                        width: FixedWidth * 0.9,
                        child: Text(
                          'Delar List',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: FixedHeight * 0.028,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    FixedHeight * 0.025, FixedHeight * 0.79, 0, 0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Delar_List_home(
                                  token: '$stoken',
                                )),
                      );
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: FixedHeight * 0.06,
                        width: FixedWidth * 0.9,
                        child: Text(
                          'Document List',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: FixedHeight * 0.028,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StateService {
  static List<String> getSuggestions(String query) {
    var vehicalNumberList = searchDataList
        .select((element, index) => element.MVC_Variable_VehcleNumber!)
        .toList();

    List<String> returnData = vehicalNumberList;
    returnData.retainWhere(
        (element) => element.toLowerCase().contains(query.toLowerCase()));
    return returnData.toList();
    Set<String> matches = Set<String>.from(statess);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches.toList();
  }
}
