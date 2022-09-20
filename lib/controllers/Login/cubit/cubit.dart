import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controllers/Login/cubit/states.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool passwordIsVisible = true;

  TextEditingController passwordController = TextEditingController();

  IconData suffixIcon = Icons.visibility_off_outlined;

  void changePasswordVisibility() {
    passwordIsVisible = !passwordIsVisible;

    if (passwordIsVisible) {
      suffixIcon = Icons.visibility_off_outlined;
    } else {
      suffixIcon = Icons.visibility_outlined;
    }

    emit(ShopLoginPasswordVsibilitylState());
  }
}
