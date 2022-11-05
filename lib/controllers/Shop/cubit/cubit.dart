import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controllers/Shop/cubit/states.dart';
import 'package:shopapp/models/modules/categories/categories_screen.dart';
import 'package:shopapp/models/modules/favourites/favourites_screen.dart';
import 'package:shopapp/models/modules/products/products_screen.dart';
import 'package:shopapp/models/modules/settings/settings_screen.dart';
import 'package:shopapp/models/shop/shop_home_model.dart';
import 'package:shopapp/webServices/endpoints/end_points.dart';
import 'package:shopapp/webServices/login_api/dio_helper.dart';
import 'package:shopapp/webServices/token.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitalState());

  static ShopCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;

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
      print(value.data);
      homeModel = HomeModel.fromJson(value.data);
      //print('the data came from homeModel :');
      //print(homeModel?.data?.products);
      emit(ShopSuccesHomeDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorHomeDataState(onError.toString()));
    });
  }
}
