import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Color kDefaultColor = Colors.deepOrange;
Widget defaultLoadingIndicator() => SpinKitThreeBounce(
      size: 30,
      color: kDefaultColor,
    );

TextStyle defaultTitleTextStyle = TextStyle(
    fontFamily: 'Righteous', fontSize: 15, color: Colors.grey.shade600);

void navigateToAndFinish(context, widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget defaultTextButton({required onPressed, required String text}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: defaultTitleTextStyle.copyWith(
            fontSize: 15, color: Colors.deepOrange),
      ),
    );

Widget defaultFormField({
  @required TextEditingController? controller,
  @required TextInputType? keyboardType,
  var onSubmit,
  var onChanged,
  String? Function(String?)? validate,
  var suffixPressedFuncion,
  @required String? label,
  IconData? prefixIcon,
  IconData? suffixIcon,
  bool isPassword = false,
}) =>
    TextFormField(
        validator: validate,
        obscureText: isPassword,
        onFieldSubmitted: onSubmit,
        onChanged: onChanged,
        decoration: InputDecoration(
          label: Text(
            label!,
            style: defaultTitleTextStyle.copyWith(fontSize: 15),
          ),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: IconButton(
            icon: Icon(suffixIcon),
            onPressed: suffixPressedFuncion,
          ),
        ));
