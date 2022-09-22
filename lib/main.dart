import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/styles/themes.dart';
import 'package:shopapp/views/onBoarding.dart';
import 'package:shopapp/webServices/blocObserver/bloc_observer.dart';
import 'package:shopapp/webServices/login_api/dio_helper.dart';

void main() {
  // NOTE: you must call init(); method of dio  in the main
  DioHelper.init(); //sbab lmashakil ... hhhhhh

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const OnBoardingScreen(),
    );
  }
}
