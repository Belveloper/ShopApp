abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadinglState extends ShopLoginStates {}

class ShopLoginSucceslState extends ShopLoginStates {}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopLoginPasswordVsibilitylState extends ShopLoginStates {}

class ShopLoginPasswordControllerEmptylState extends ShopLoginStates {}
