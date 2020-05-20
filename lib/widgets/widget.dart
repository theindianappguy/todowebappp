import 'package:flutter/material.dart';

class Widgets{

  Widget mainAppar(){
    return AppBar(
      title: Image.asset("assets/images/logo.png", height: 35,),
      centerTitle: false,
      elevation: 0.0,
    );
  }
}