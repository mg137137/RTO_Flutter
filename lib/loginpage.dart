import 'dart:convert';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Api Detail/api_Configration_file.dart';
import 'Dashboard.dart';
import 'Globaly Accesible/Varibales.dart';

late final String tokendata;

class Login_Page extends StatefulWidget {
  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  Future<void> _checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? U_Name = prefs.getString('userName');

    if (token != null && U_Name != null) {
      Global_Token = token;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Dashboard(
                  token: '$token',
                )),
      );
    }
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    String username = _usernameController.text;
    String password = _passwordController.text;
    var response = await http.post(Uri.parse('$api_login'),
        body: {'agentEmailId': username, 'agentPassword': password});

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      String token = json['token'];
      String U_Name = (jsonDecode(response.body)['userName']).toString();
      Global_Token = token;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('userName', U_Name);
      print(token);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Dashboard(token: '$token')));
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Invalid username or password';
        final snackBar = SnackBar(
          content: Text('$_errorMessage'),
          // backgroundColor: (Colors.black),
          // action: SnackBarAction(label: 'dismiss', onPressed: () { },)
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
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
            child: Container(
          height: FixedHeight,
          width: FixedWidth,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color(0xd34897ce),
                Color(0xff0724e7),
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Circle Image
              Container(
                  margin: EdgeInsets.fromLTRB(0, FixedHeight * 0.06, 0, 0),
                  height: FixedHeight * 0.2,
                  width: FixedWidth * 0.4,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/download.jpg'),
                  )),

              Container(
                // height: FixedHeight*0.6,
                width: FixedWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(FixedHeight * 0.06),
                      topLeft: Radius.circular(FixedHeight * 0.06)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          0, FixedHeight * 0.04, FixedHeight * 0.34, 0),
                      child: Text(
                        'Sign in to',
                        style: TextStyle(
                          fontSize: FixedHeight * 0.04,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, FixedHeight * 0.24, 0),
                      child: Text(
                        'Your Account !',
                        style: TextStyle(
                            fontSize: FixedHeight * 0.04,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: FixedHeight * 0.08),
                    Container(
                      height: FixedHeight * 0.08,
                      width: FixedHeight * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(FixedHeight * 0.03),
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
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          // filled: true,
                          // fillColor: Color.fromRGBO(0, 0, 0, 0.10),
                          border: InputBorder.none,
                          // labelText: 'Email Address',
                          contentPadding: EdgeInsets.fromLTRB(15, 18, 10, 20),
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
                      height: FixedHeight * 0.016,
                    ),
                    Container(
                      height: FixedHeight * 0.08,
                      width: FixedHeight * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
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
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          // filled: true,
                          // fillColor: Color.fromRGBO(0, 0, 0, 0.10),
                          border: InputBorder.none,
                          // labelText: 'Email Address',
                          contentPadding: EdgeInsets.fromLTRB(15, 18, 10, 20),

                          hintText: 'Password',
                          isDense: true,
                          suffixIcon: Icon(
                            Icons.remove_red_eye_outlined,
                            size: 17,
                          ),
                        ),
                      ),
                    ),

                    // For Forgot Password Text
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(20, 10, 40, 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: const [
                    //       Text(
                    //         'Forgot Password',
                    //         style: TextStyle(color: Colors.blueAccent),
                    //       )
                    //     ],
                    //   ),
                    // ),

                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, FixedHeight * 0.05, 0, FixedHeight * 0.16),
                      child: SizedBox(
                        height: FixedHeight * 0.065,
                        width: FixedHeight * 0.45,
                        child: ElevatedButton(
                          child: const Text('LOGIN'),
                          onPressed: () {
                            if (_isLoading != null) {
                              _login();
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
