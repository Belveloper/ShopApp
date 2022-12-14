abstract class ShopStates {}

class ShopInitalState extends ShopStates {}

class ShopChangeBottomNavigationBarState extends ShopStates {}

class ShopChangeCrouselIndicatorState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccesHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopSuccesCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final String error;
  ShopErrorCategoriesState(this.error);
}
