import 'package:flutter/material.dart';
import 'package:todowebappp/widgets/widget.dart';

class Home extends StatefulWidget {
  final String username;
  final String userEmail;
  Home({this.username, this.userEmail});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets().mainAppar(),
      body: Container(
        child: Text("username: ${widget.username}"),
      ),
    );
  }
}
