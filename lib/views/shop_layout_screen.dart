import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:shopapp/controllers/Shop/cubit/cubit.dart';
import 'package:shopapp/controllers/Shop/cubit/states.dart';

class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.white,
          body: cubit.bottomNavigationBarScreens[cubit.currentIndex],
          bottomNavigationBar: SnakeNavigationBar.color(
            unselectedItemColor: Colors.blueGrey,
            selectedItemColor: Colors.white,
            snakeViewColor: const Color.fromARGB(237, 0, 32, 97),
            elevation: 0,
            onTap: (value) => cubit.toggleBottomNavBarScreen(value),
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: 'tickets'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.date_range), label: 'calendar'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.podcasts), label: 'microphone'),
            ],
          ),
        );
      },
    );
  }
}
