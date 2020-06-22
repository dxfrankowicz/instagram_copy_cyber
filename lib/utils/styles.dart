import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppStyles {
  static Color loginHintTextColor = Color.fromRGBO(142, 142, 142, 1.0);
  static Color loginBorderColor = Hexcolor("#dbdbdb");
  static Color loginBackgroundColor = Hexcolor("#fafafa"); //250 //"#fafafa"
  static Color loginButtonColor = Color.fromRGBO(0, 149, 246, 1);
  static Color loginButtonInactiveColor = Color.fromRGBO(0, 149, 246, 0.3);
  static Color darkGrey = Hexcolor("#999999");
  static Color darkBlueColor = Hexcolor("#00376b");

  static var textStyleBlack = new TextStyle(fontSize: 14.0, color: Colors.black);
  static var textStyleLoginHint = new TextStyle(fontSize: 14.0, color: loginHintTextColor);
  static var textStyleGrey = new TextStyle(fontSize: 12.5, color: Colors.grey);
  static var textStyleBlueGrey = new TextStyle(fontSize: 12.0, color: darkBlueColor);
}
