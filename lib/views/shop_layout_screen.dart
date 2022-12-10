import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopapp/constants/constants.dart';
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
          extendBody: true,
          backgroundColor: Colors.white,
          body: RefreshIndicator(
              onRefresh: () async {
                cubit.getHomeData();
                cubit.getCategoryData();
              },
              child: cubit.bottomNavigationBarScreens[cubit.currentIndex]),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DotNavigationBar(
              margin: const EdgeInsets.only(left: 10, right: 10),
              currentIndex: cubit.currentIndex,
              backgroundColor: Colors.white70.withOpacity(0.6),
              //itemPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 0), ,
              onTap: (value) => cubit.toggleBottomNavBarScreen(value),
              // dotIndicatorColor: Colors.black,
              items: [
                //
                DotNavigationBarItem(
                    icon: const Icon(
                      FontAwesomeIcons.bagShopping,
                    ),
                    selectedColor: kDefaultOrangeColor,
                    unselectedColor: kDefaultBlueColor),

                //
                DotNavigationBarItem(
                    icon: const Icon(FontAwesomeIcons.list),
                    selectedColor: kDefaultOrangeColor,
                    unselectedColor: kDefaultBlueColor),

                //
                DotNavigationBarItem(
                    icon: const Icon(FontAwesomeIcons.star),
                    selectedColor: kDefaultOrangeColor,
                    unselectedColor: kDefaultBlueColor),

                //
                // DotNavigationBarItem(
                //     icon: const Icon(Icons.settings_outlined),
                //     selectedColor: kDefaultOrangeColor,
                //     unselectedColor: kDefaultBlueColor),
              ],
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.black87,
                ),
              )
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Builder(builder: (context) {
                  return IconButton(
                    onPressed: (() => Scaffold.of(context).openDrawer()),
                    icon: const Icon(
                      FontAwesomeIcons.barsStaggered,
                      color: Colors.black87,
                    ),
                  );
                }),
                const SizedBox(
                  width: 70,
                ),
                Text(
                  'Boutiqua',
                  style: defaultTitleTextStyle.copyWith(
                      fontSize: 30, color: Colors.black),
                ),
              ],
            ),
          ),
          drawer: const Drawer(
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Text(
                'Version 1.0.0',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        );
      },
    );
  }
}
