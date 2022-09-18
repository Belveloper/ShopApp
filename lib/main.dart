import 'package:flutter/material.dart';
import 'package:shopapp/styles/themes.dart';
import 'package:shopapp/views/onBoarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: OnBoardingScreen(),
    );
  }
}
