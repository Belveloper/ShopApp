import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controllers/Shop/cubit/states.dart';
import 'package:shopapp/models/Categories/shop_categories_model.dart';
import 'package:shopapp/models/Favourites/favourites_model.dart';
import 'package:shopapp/models/ToggleFavourites/toogle_favourites_model.dart';
import 'package:shopapp/modules/categories/categories_screen.dart';
import 'package:shopapp/modules/favourites/favourites_screen.dart';
import 'package:shopapp/modules/products/products_screen.dart';
import 'package:shopapp/modules/settings/settings_screen.dart';
import 'package:shopapp/models/shop/shop_home_model.dart';
import 'package:shopapp/webServices/endpoints/end_points.dart';
import 'package:shopapp/webServices/login_api/dio_helper.dart';
import 'package:shopapp/webServices/token.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitalState());

  static ShopCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  Map<int, bool>? favourites = {};
  FavouritesModel? favouritesModel;

  int currentIndex = 0;
  int carouselIndicatorIndex = 0;
  List<Widget> bottomNavigationBarScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    const SettingsScreen(),
  ];

  void toggleBottomNavBarScreen(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavigationBarState());
  }

  void toggleCarouselIndicator(int index) {
    carouselIndicatorIndex = index;
    emit(ShopChangeCrouselIndicatorState());
  }

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      //print(value.data);
      homeModel = HomeModel.fromJson(value.data);
      //print('the data came from homeModel :');
      //print(homeModel?.data?.products);
      for (var element in homeModel!.data!.products!) {
        favourites!.addAll({element.id: element.in_favorites});
      }
      print(favourites);
      emit(ShopSuccesHomeDataState());
    }).catchError((onError) {
      print('home model data error:');
      print(onError.toString());
      emit(ShopErrorHomeDataState(onError.toString()));
    });
  }

  void getCategoryData() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(url: CATEGORIES).then((value) {
      print('categories');
      print(value.data);
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccesCategoriesState());
    }).onError((error, stackTrace) {
      print('error when categories api called');
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  ToggleFavouritesModel? toggleFavouritesModel;

  void toggleFavourites(int productId) {
    favourites![productId] = !favourites![productId]!;
    emit(ShopSuccesToggleFavIconState());
    DioHelper.postData(
      url: FAVOURITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      print(value.data);
      toggleFavouritesModel = ToggleFavouritesModel.fromJson(value.data);
      print('toggle favourite status :${toggleFavouritesModel!.status!}');

      if (!toggleFavouritesModel!.status!) {
        favourites![productId] = !favourites![productId]!;

        emit(ShopSuccesToggleFavIconState(model: toggleFavouritesModel!));
      } else {
        getFavouritesData();
      }

      emit(ShopSuccesToggleFavsState());
    }).catchError((onError) {
      favourites![productId] = !favourites![productId]!;
      emit(ShopErrorToggleFavsState(onError.toString()));

      //emit(ShopSuccesToggleFavIconState(model: toggleFavouritesModel));
    });
  }

  void getFavouritesData() {
    emit(ShopLoadingFavouritesDataState());
    DioHelper.getData(
      url: FAVOURITES,
      token: token,
    ).then((value) {
      if (value.data != null) {
        print('Favourites data :${value.data}');
        favouritesModel = FavouritesModel.fromJson(value.data);
        emit(ShopSuccesFavouritesDataState());
      }
    }).onError((error, stackTrace) {
      print(
          'error when getting favourites data from API:\n${error.toString()}');
      emit(ShopErrorFavouritesDataState(error.toString()));
    });
  }
}
