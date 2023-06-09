import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:rto_flutter/Constants/Global_Variabales.dart';
import 'package:rto_flutter/Screens/Login%20Screnn/Controller_Login_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Dashboard.dart';
import '../../Globaly Accesible/Varibales.dart';
import 'MVC_Login_Screen.dart';

class Login_Screen extends StatefulWidget {
  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  //Model List
  late MVC_Login_Screen Local_Login_Detail_Type_MVC;

  final Controller_Post_Login_Screen = Controller_Login_Screen();
  final TextEditingController TEC_Username = TextEditingController();
  final TextEditingController TEC_Password = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Check_Alrady_Logged_In();
  }

  Future<void> Check_Alrady_Logged_In() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Local_Store_Token = prefs.getString('Local_Store_Token');
    String? Local_Store_UserName = prefs.getString('Local_Store_UserName');

    if (Local_Store_Token != null && Local_Store_UserName != null) {
      Global_Token = Local_Store_Token;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Dashboard(
                  token: '$Local_Store_Token',
                )),
      );
    }
  }

  Future<void> _login() async {
    String username = TEC_Username.text;
    String password = TEC_Password.text;

    var loginResult = await Controller_Post_Login_Screen.LoginUser(
        {'agentEmailId': username, 'agentPassword': password});

    if (loginResult is MVC_Login_Screen) {
      // When Sucess Of Login
      var loginData = loginResult;

      // Store in Local Storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'Local_Store_Token', '${loginData.MVC_Variable_Token}');
      await prefs.setString(
          'Local_Store_UserName', '${loginData.MVC_Variable_UserName}');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Dashboard(token: '${loginData.MVC_Variable_Token}')));
    } else {
      // Handle error response
      var errorResponse = loginResult;
      print('Error Response is :- ' + errorResponse);
    }
  }

  @override
  Widget build(BuildContext context) {
    // For Full Screen View
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    double FixedHeight = MediaQuery.of(context).size.height;
    double FixedWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 500, top: 50),
                    decoration: const BoxDecoration(
                        gradient: Global_Variabales.GL_Blue_Gradient),
                    width: MediaQuery.of(context).size.width,
                    child: CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('assets/download.jpg')),
                  ),
                ),
                Positioned(
                  top: 300,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 600,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      'Sign in to',
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: const Text(
                                      'Your Account !',
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(0, 0, 0, 0.10),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, -4),
                                  blurRadius: 4,
                                  color: Color.fromRGBO(0, 0, 0, 0.10),
                                  inset: true,
                                ),
                                BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                  color: Color.fromRGBO(0, 0, 0, 0.50),
                                  inset: true,
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: TEC_Username,
                              decoration: InputDecoration(
                                // filled: true,
                                // fillColor: Color.fromRGBO(0, 0, 0, 0.10),
                                border: InputBorder.none,
                                // labelText: 'Email Address',
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 18, 10, 20),
                                // border: OutlineInputBorder(
                                //     // borderSide: BorderSide(color: Colors.white),
                                //     // borderRadius: BorderRadius.circular(10.0),
                                // ),

                                hintText: 'Enter Username',
                                isDense: true,
                                suffixIcon: Icon(
                                  Icons.mail,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(0, 0, 0, 0.10),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, -4),
                                  blurRadius: 4,
                                  color: Color.fromRGBO(0, 0, 0, 0.10),
                                  inset: true,
                                ),
                                BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                  color: Color.fromRGBO(0, 0, 0, 0.50),
                                  inset: true,
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: TEC_Password,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 18, 10, 20),
                                hintText: 'Enter Password',
                                isDense: true,
                                suffixIcon: Icon(
                                  Icons.mail,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          _isLoading == true
                              ? CircularProgressIndicator()
                              : Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: SizedBox(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      child: const Text('LOGIN'),
                                      onPressed: () {
                                        _login();
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
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
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
