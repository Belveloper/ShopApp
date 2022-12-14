import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/constants/constants.dart';
import 'package:shopapp/controllers/Login/cubit/states.dart';
import 'package:shopapp/controllers/Shop/cubit/cubit.dart';
import 'package:shopapp/controllers/Shop/cubit/states.dart';
import 'package:shopapp/views/login_Screen.dart';

import '../controllers/Login/cubit/cubit.dart';

class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cache = Hive.box('Local');
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var ShopLogincubit = ShopLoginCubit.get(context);

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
          drawer: Drawer(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const DrawerHeader(child: Text('Header')),
              const Divider(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: BlocListener<ShopLoginCubit, ShopLoginStates>(
                      listener: (context, state) {
                        if (state is ShopLogOutSucceslState) {
                          cache.delete('token').then((value) {
                            Navigator.pop(context);
                            navigateToAndFinish(context, const LoginScreen());
                          }).onError((error, stackTrace) {
                            print(error.toString());
                          });
                        }
                      },
                      child: GestureDetector(
                        onTap: (() {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: const Text('Confirm Sign Out ?'),
                              actions: [
                                TextButton(
                                  onPressed: (() {
                                    ShopLogincubit.userLogOut();
                                  }),
                                  child: state is ShopLogOutLoadinglState
                                      ? defaultLoadingIndicator()
                                      : Text(
                                          'OK',
                                          style: defaultTitleTextStyle,
                                        ),
                                ),
                                TextButton(
                                  onPressed: (() {
                                    Navigator.pop(context);
                                  }),
                                  child: Text(
                                    'Cancel',
                                    style: defaultTitleTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          );
                          //
                        }),
                        child: Container(
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red.shade600),
                          child: Center(
                            child: state is ShopLogOutLoadinglState
                                ? defaultLoadingIndicator()
                                : Text(
                                    'Sign-Out',
                                    textAlign: TextAlign.center,
                                    style: defaultTitleTextStyle.copyWith(
                                        color: Colors.white),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Version 1.0.0')
            ],
          )),
        );
      },
    );
  }
}
