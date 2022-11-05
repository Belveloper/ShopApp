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
