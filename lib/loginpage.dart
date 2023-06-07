import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:rto_flutter/Controller/Controller_Post_Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dashboard.dart';
import 'Globaly Accesible/Varibales.dart';
import 'MVC/MVC_LOGIN.dart';

late final String tokendata;

class Login_Page extends StatefulWidget {
  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  late MVC_LOGIN Local_Login_Detail;

  final controller_post_login = Controller_Post_Login();
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
    String username = _usernameController.text;
    String password = _passwordController.text;
    /* final Local_Data = await controller_post_login.LoginUser(
        {'agentEmailId': username, 'agentPassword': password});*/

    var loginResult = await controller_post_login.LoginUser(
        {'agentEmailId': username, 'agentPassword': password});
    if (loginResult is MVC_LOGIN) {
      // Handle successful login
      var loginData = loginResult;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', '${loginData.MVC_Variable_Token}');
      await prefs.setString('userName', '${loginData.MVC_Variable_UserName}');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Dashboard(token: '${loginData.MVC_Variable_Token}')));
      // ...
    } else {
      // Handle error response
      var errorResponse = loginResult;
      print(errorResponse);
      // ...
    }

    setState(() {
      //Local_Login_Detail = Local_Data!;
      _isLoading = false;
      _errorMessage = '';
    });

    /*var response = await http.post(Uri.parse('$api_login'),
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
    }*/
  }

  @override
  Widget build(BuildContext context) {
    // For Full Screen View
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    double FixedHeight = MediaQuery.of(context).size.height;
    double FixedWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                  padding: EdgeInsets.only(bottom: 500, top: 50),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        Color(0xd34897ce),
                        Color(0xff0724e7),
                      ])),
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
                            controller: _usernameController,
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
                            controller: _passwordController,
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
    ));
  }
}
