import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controllers/Shop/cubit/states.dart';
import 'package:shopapp/models/modules/categories/categories_screen.dart';
import 'package:shopapp/models/modules/favourites/favourites_screen.dart';
import 'package:shopapp/models/modules/products/products_screen.dart';
import 'package:shopapp/models/modules/settings/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitalState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
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
}
