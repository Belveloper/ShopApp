import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopapp/controllers/Login/cubit/cubit.dart';
import 'package:shopapp/controllers/Shop/cubit/cubit.dart';
import 'package:shopapp/styles/themes.dart';
import 'package:shopapp/views/login_Screen.dart';
import 'package:shopapp/views/onBoarding_screen.dart';
import 'package:shopapp/views/shop_layout_screen.dart';
import 'package:shopapp/webServices/blocObserver/bloc_observer.dart';
import 'package:shopapp/webServices/login_api/dio_helper.dart';
import 'package:shopapp/webServices/token.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('Local');
  var cache = createLocalDB();
  // must be called when using SharedPrefrences .
  // NOTE: you must call init(); method of dio  in the main
  DioHelper.init(); //sbab lmashakil ... hhhhhh
  Bloc.observer = MyBlocObserver();
  createLocalDB();
  //----------------------------------local cache variables----------------------------------
  bool? onBoarding;
  //----------------------------------local cache variables----------------------------------
  Widget widget = const OnBoardingScreen();
  onBoarding = cache.get('onBoarding') ?? false;
  token = cache.get('token');
  print(token);
  if (onBoarding != null && onBoarding == true) {
    if (token != null) {
      widget = const ShopLayoutScreen();
    } else {
      widget = const LoginScreen();
    }
  } else {
    if (onBoarding == false) {
      widget = const OnBoardingScreen();
    }
  }
  //print(onBoarding);
  runApp(
    MyApp(
      onBoarding: onBoarding!,
      startWidget: widget,
    ),
  );
}

createLocalDB() {
  return Hive.box('Local');
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  final Widget startWidget;
  const MyApp({
    super.key,
    required this.onBoarding,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => ShopLoginCubit()),
        ),
        BlocProvider(
          create: ((context) => ShopCubit()
            ..getHomeData()
            ..getCategoryData()
            ..getFavouritesData()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
