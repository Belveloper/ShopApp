import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controllers/Login/cubit/states.dart';
import 'package:shopapp/models/logOut/log_out_model.dart';
import 'package:shopapp/models/login/shop_login_model.dart';
import 'package:shopapp/webServices/endpoints/end_points.dart';

import 'package:shopapp/webServices/login_api/dio_helper.dart';
import 'package:shopapp/webServices/token.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  ShopLoginModel? loginModel;

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({@required String? email, @required String? password}) {
    emit(ShopLoginLoadinglState());
    DioHelper.postData(
            url: LOGIN,
            data: {'email': email.toString(), 'password': password.toString()})
        .then((value) {
      loginModel =
          value.data != null ? ShopLoginModel.fromJson(value.data) : loginModel;

      print(loginModel!.message);
      print(loginModel!.data!.token);

      print(value.data);
      emit(ShopLoginSucceslState(loginModel));
    }).catchError((onError) {
      print('ki maymshish cubit:$onError');

      emit(ShopLoginErrorState(onError.toString(), loginModel));
    });
  }

  void userLogOut() {
    emit(ShopLogOutLoadinglState());
    DioHelper.postData(url: LOGOUT, token: token).then((value) {
      print(value.data);
      print(ShopLogOutModel.fromJson(value.data).data!.token!);

      emit(ShopLogOutSucceslState());
    }).catchError((onError) {
      print('ki maymshish cubit:$onError');

      emit(ShopLogOutErrorState(onError.toString(), loginModel));
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
