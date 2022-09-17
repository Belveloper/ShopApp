import 'package:flutter/material.dart';
import 'package:shopapp/styles/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: const Scaffold(
        body: Center(
          child: Text('test'),
        ),
      ),
    );
  }
}
