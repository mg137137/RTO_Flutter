import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:rto_flutter/Dashboard.dart';

late final String localtoken;

class Document_List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Decoration Bluebox_Decoration = BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.lightBlueAccent,
          ],
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 5),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.white);

    var arraydocument_name = [
      'Name1',
      'Name2',
      'Name3',
      'Name4',
      'Name1',
      'Name2',
      'Name3',
      'Name4',
      'Name1',
      'Name2',
      'Name3',
      'Name4',
      'Name1',
      'Name2',
      'Name3',
      'Name4',
    ];

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.blue,
            // gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: [
            //  Colors.blueAccent,
            //   Color(0xff1a73e8),
            // ])
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  // gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //     colors: [
                  //   Color(0xff1a73e8),
                  //   Color(0xff1a73e8),
                  // ])
                ),
                height: 60,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                    Text(
                      'Documents',
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
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(4, 5),
                              blurRadius: 1,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          // margin: EdgeInsets.fromLTRB(10, 45, 5, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                arraydocument_name[index],
                              ),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.print),
                                label: Text('print'),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: arraydocument_name.length,
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
