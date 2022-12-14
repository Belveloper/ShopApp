import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'loginModel!.message',
              confirmBtnText: 'OK',
              animType: QuickAlertAnimType.slideInDown,
              confirmBtnColor: Colors.red);
        },
        child: const Text('click'),
      ),
    );
  }
}
