import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Color kDefaultColor = Colors.deepOrange;
Widget defaultLoadingIndicator() => SpinKitThreeBounce(
      size: 30,
      color: kDefaultColor,
    );

TextStyle defaultTitleTextStyle = TextStyle(
    fontFamily: 'Righteous', fontSize: 15, color: Colors.grey.shade600);
