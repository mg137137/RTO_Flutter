import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Api Detail/api_Configration_file.dart';

late final String localtoken;

class Delar_Detail extends StatefulWidget {
  final String token;
  final String id;

  const Delar_Detail({Key? key, required this.token, required this.id})
      : super(key: key);

  @override
  State<Delar_Detail> createState() => _Delar_DetailState();
}

class _Delar_DetailState extends State<Delar_Detail> {
  Map<String, dynamic> data = {};
  Map<String, dynamic> testing = {};
  Map<String, dynamic> expandata = {};

  Future<void> getData() async {
    final response = await http.get(
      Uri.parse(
          'http://$api_id/dealerrouter/getDealerDetailsById?dealerId=${widget.id}'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );

    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
        expandata = data['Dealerdetails'];
        print('This is a expanded Delat Detail :- ' + '$expandata');

        testing = data['DealerCounterdetails'];
        print('The response data is ' + "$testing");
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final Decoration blueBoxDecoration = BoxDecoration(
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
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                      Text(
                        'Dealer Detail',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          var key = data.keys.elementAt(index);
                          var value = data[key];

                          return Stack(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          20, 40, 20, 10),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(4, 5),
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 5),
                                        margin: const EdgeInsets.fromLTRB(
                                            20, 45, 0, 0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              for (var entry in value.entries)
                                                Text(
                                                  '${entry.key} :- ${entry.value}',
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                  textAlign: TextAlign.left,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  decoration: blueBoxDecoration,
                                  child: Text(
                                    key,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          // Display the static buttons
                          int buttonIndex = index - 1;

                          var key = testing.keys.elementAt(buttonIndex);
                          var value =
                              testing[testing.keys.elementAt(buttonIndex)];

                          return Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                            margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                            height: 40,
                            // width: 50,
                            color: Colors.blue,
                            child: InkWell(
                              onTap: () {
                                // Handle button press based on buttonIndex
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('$key'),
                                  Text('$value'),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      itemCount: data.length +
                          testing.length -
                          1, // Add 1 for the first index and the static buttons
                      // Add 6 for the static buttons
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Map<String, dynamic> data = {};
  // Map<String, dynamic> testing = {};
  // Map<String, dynamic> expandata = {};
  //
  // Future<void> getData() async {
  //   final response = await http.get(
  //     Uri.parse(
  //         'http://$api_id/dealerrouter/getDealerDetailsById?dealerId=${widget.id}'),
  //     headers: {'Authorization': 'Bearer ${widget.token}'},
  //   );
  //
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       data = jsonDecode(response.body);
  //       expandata = data['Dealerdetails'];
  //       print('This is a expanded Delat Detail :- ' + '$expandata');
  //
  //       testing = data['DealerCounterdetails'];
  //       print('The response data is ' + "$testing");
  //     });
  //   } else {
  //     print('Request failed with status: ${response.statusCode}');
  //   }
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   final Decoration blueBoxDecoration = BoxDecoration(
  //     color: Colors.blue,
  //     boxShadow: [
  //       BoxShadow(
  //         offset: Offset(4, 5),
  //         blurRadius: 5,
  //         color: Colors.black.withOpacity(0.3),
  //       ),
  //     ],
  //     borderRadius: BorderRadius.circular(10),
  //   );
  //
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: SafeArea(
  //         child: Container(
  //           height: MediaQuery.of(context).size.height,
  //           width: MediaQuery.of(context).size.width,
  //           decoration: const BoxDecoration(
  //             color: Colors.blue,
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Container(
  //                 height: 60,
  //                 width: MediaQuery.of(context).size.width,
  //                 margin: EdgeInsets.zero,
  //                 padding: EdgeInsets.zero,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     IconButton(
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                       icon: const Icon(
  //                         Icons.arrow_back_ios_new_outlined,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                     const Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
  //                     Text(
  //                       'Dealer Detail',
  //                       style: const TextStyle(
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Container(
  //                   padding: const EdgeInsets.only(top: 7),
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: const BorderRadius.only(
  //                       topRight: Radius.circular(40),
  //                       topLeft: Radius.circular(40),
  //                     ),
  //                   ),
  //                   child: ListView.builder(
  //                     itemBuilder: (context, index) {
  //                       if (index < data.length) {
  //                         var key = data.keys.elementAt(index);
  //                         var value = data[key];
  //
  //                         return Stack(
  //                           children: [
  //                             Container(
  //                               child: Column(
  //                                 children: [
  //                                   Container(
  //                                     decoration: BoxDecoration(
  //                                       boxShadow: [
  //                                         BoxShadow(
  //                                           offset: Offset(4, 5),
  //                                           blurRadius: 10,
  //                                           color:
  //                                               Colors.black.withOpacity(0.3),
  //                                         ),
  //                                       ],
  //                                       color: Colors.white,
  //                                       borderRadius: BorderRadius.circular(10),
  //                                     ),
  //                                     margin: const EdgeInsets.fromLTRB(
  //                                         20, 40, 20, 10),
  //                                     width: MediaQuery.of(context).size.width,
  //                                     child: Container(
  //                                       padding: const EdgeInsets.fromLTRB(
  //                                           0, 0, 0, 5),
  //                                       margin: const EdgeInsets.fromLTRB(
  //                                           20, 45, 0, 0),
  //                                       child: SingleChildScrollView(
  //                                         child: Column(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.start,
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             for (var entry in value.entries)
  //                                               Text(
  //                                                 '${entry.key} :- ${entry.value}',
  //                                                 style: const TextStyle(
  //                                                     fontSize: 15),
  //                                                 textAlign: TextAlign.left,
  //                                               ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             Positioned(
  //                               top: -10,
  //                               left: 30,
  //                               right: 30,
  //                               child: Container(
  //                                 alignment: Alignment.center,
  //                                 height: 50,
  //                                 width: 350,
  //                                 margin:
  //                                     const EdgeInsets.fromLTRB(0, 30, 0, 0),
  //                                 decoration: blueBoxDecoration,
  //                                 child: Text(
  //                                   key,
  //                                   style: const TextStyle(
  //                                       fontSize: 15, color: Colors.black),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         );
  //                       } else {
  //                         // Display the static buttons
  //                         int buttonIndex = index - data.length;
  //
  //                         var key = testing.keys.elementAt(buttonIndex);
  //                         var value =
  //                             testing[testing.keys.elementAt(buttonIndex)];
  //
  //                         return Container(
  //                           margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
  //                           child: ElevatedButton(
  //                             onPressed: () {
  //                               // Handle button press based on buttonIndex
  //                             },
  //                             child: Text('$key' + '$value'),
  //                           ),
  //                         );
  //                       }
  //                     },
  //                     itemCount: expandata.length +
  //                         testing.length, // Add 6 for the static buttons
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
