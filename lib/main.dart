import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:rto_flutter/Screens/Login%20Screnn/Login_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'rto agent',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login_Screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
