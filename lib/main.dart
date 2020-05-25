import 'package:flutter/material.dart';
import 'package:todowebappp/views/home.dart';
import 'package:todowebappp/views/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // uId = gnpH1r191xOYLMIsIZgvxNSx5X53;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "OverpassRegular",
        primaryColor: Color(0xff3185FC),
        scaffoldBackgroundColor: Color(0xffFFFAFF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:/*SingIn()*/ Home(),
    );
  }
}

