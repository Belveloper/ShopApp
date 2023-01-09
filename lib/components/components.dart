import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../constants/constants.dart';

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
  String? initalValue,
  String? hintText,
  TextStyle? style,
  TextStyle? hintStyle,
  bool? isEnabled,
  @required TextEditingController? controller,
  @required TextInputType? keyboardType,
  Function(String?)? onSubmit,
  var onChanged,
  String? Function(String?)? validate,
  var suffixPressedFuncion,
  String? label,
  IconData? prefixIcon,
  IconData? suffixIcon,
  bool isPassword = false,
}) =>
    TextFormField(
        enabled: isEnabled,
        onSaved: (newValue) {
          onSubmit;
        },
        initialValue: initalValue,
        style: style,
        validator: validate,
        obscureText: isPassword,
        onFieldSubmitted: onSubmit,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle ??
              defaultTitleTextStyle.copyWith(color: Colors.black12),
          border: InputBorder.none,
          label: Text(
            label ?? '',
            style: defaultTitleTextStyle.copyWith(fontSize: 15),
          ),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: IconButton(
            icon: Icon(suffixIcon),
            onPressed: suffixPressedFuncion,
          ),
        ));

Widget skeletonPorsuctItemWidget() => SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                height: 200,
                width: 400,
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Expanded(
                        child: SkeletonAvatar(
                          style: SkeletonAvatarStyle(height: 150),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: SkeletonAvatar(
                          style: SkeletonAvatarStyle(height: 100, width: 200),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: SkeletonAvatar(
                          style: SkeletonAvatarStyle(height: 100, width: 200),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            height: 150,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(height: 150, width: 100),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(height: 100, width: 200),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget skeletonCategoryItem() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) => SkeletonListTile(
        leadingStyle: const SkeletonAvatarStyle(height: 100, width: 100),
      ),
    ),
  );
}

Widget defaultTextField(
        {IconData? icon, String? hintText, TextStyle? hintStyle}) =>
    Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.all(5),
      height: 60,
      child: TextFormField(
        style: defaultTitleTextStyle,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black12,
          ),
          hintText: hintText,
          hintStyle: hintStyle ??
              defaultTitleTextStyle.copyWith(color: Colors.black12),
          border: InputBorder.none,
        ),
        
      ),
    );
