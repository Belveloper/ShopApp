import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controllers/Login/cubit/states.dart';
import 'package:shopapp/webServices/endpointa/end_points.dart';
import 'package:shopapp/webServices/login_api/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({@required String? email, @required String? password}) {
    emit(ShopLoginLoadinglState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      print(value.data);
      emit(ShopLoginSucceslState());
    }).catchError((onError) {
      emit(ShopLoginErrorState(onError.toString()));
    });
  }

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
