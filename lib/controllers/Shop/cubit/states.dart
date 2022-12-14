import 'package:shopapp/models/ToggleFavourites/toogle_favourites_model.dart';

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

class ShopSuccesToggleFavsState extends ShopStates {}

class ShopErrorToggleFavsState extends ShopStates {
  final String error;
  ShopErrorToggleFavsState(this.error);
}

class ShopSuccesToggleFavIconState extends ShopStates {
  ToggleFavouritesModel? model;
  ShopSuccesToggleFavIconState({this.model});
}


class ShopLoadingFavouritesDataState extends ShopStates {}

class ShopSuccesFavouritesDataState extends ShopStates {}

class ShopErrorFavouritesDataState extends ShopStates {
  final String error;
  ShopErrorFavouritesDataState(this.error);
}
