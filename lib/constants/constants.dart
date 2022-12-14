import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Color kDefaultOrangeColor = Colors.deepOrange;
Color kDefaultBlueColor = Colors.blue.shade900;
Widget defaultLoadingIndicator({Color? color}) => SpinKitThreeBounce(
      size: 30,
      color: color ?? kDefaultOrangeColor,
    );

TextStyle defaultTitleTextStyle = TextStyle(
    fontFamily: 'Righteous', fontSize: 15, color: Colors.grey.shade600);
