import 'package:shopapp/models/login/shop_login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadinglState extends ShopLoginStates {}

class ShopLoginSucceslState extends ShopLoginStates {
  ShopLoginModel? loginModel;
  ShopLoginSucceslState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  ShopLoginModel? loginModel;
  final String error;

  ShopLoginErrorState(this.error, this.loginModel);
}

class ShopLogOutLoadinglState extends ShopLoginStates {}

class ShopLogOutSucceslState extends ShopLoginStates {}

class ShopLogOutErrorState extends ShopLoginStates {
  ShopLoginModel? loginModel;
  final String error;

  ShopLogOutErrorState(this.error, this.loginModel);
}

class ShopLoginPasswordVsibilitylState extends ShopLoginStates {}

class ShopLoginPasswordControllerEmptylState extends ShopLoginStates {}
