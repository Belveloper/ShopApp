import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/constants/constants.dart';
import 'package:shopapp/controllers/Login/cubit/states.dart';
import 'package:shopapp/controllers/Profile/cubit/cubit.dart';
import 'package:shopapp/controllers/Profile/cubit/states.dart';
import 'package:shopapp/controllers/Shop/cubit/cubit.dart';
import 'package:shopapp/controllers/Shop/cubit/states.dart';
import 'package:shopapp/modules/settings/settings_screen.dart';
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
        var shopLogincubit = ShopLoginCubit.get(context);
        var profileCubit = ProfileCubit.get(context);

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
              child: BlocConsumer<ProfileCubit, ProfileStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  DrawerHeader(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Text(
                            profileCubit.profileModel!.data!.name![0],
                            style: defaultTitleTextStyle.copyWith(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                        Text(
                          profileCubit.profileModel!.data!.name!,
                          style: defaultTitleTextStyle.copyWith(
                              color: Colors.black, fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              profileCubit.profileModel!.data!.phone!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text('|'),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  profileCubit.profileModel!.data!.points!
                                      .toString(),
                                  style: defaultTitleTextStyle.copyWith(
                                      color: Colors.amber),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const SettingsScreen()));
                    },
                    child: Container(
                      width: 120,
                      height: 30,
                      decoration: BoxDecoration(
                          color: kDefaultOrangeColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          'My Profile',
                          textAlign: TextAlign.center,
                          style: defaultTitleTextStyle.copyWith(
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
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
                                navigateToAndFinish(
                                    context, const LoginScreen());
                              }).onError((error, stackTrace) {
                                print(error.toString());
                              });
                            }
                          },
                          child: GestureDetector(
                            onTap: (() {
                              showGeneralDialog(
                                  barrierColor: Colors.black.withOpacity(0.5),
                                  transitionBuilder: (context, a1, a2, widget) {
                                    return Transform.scale(
                                      scale: a1.value,
                                      child: Opacity(
                                        opacity: a1.value,
                                        child: AlertDialog(
                                          elevation: 0,
                                          shape: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          content:
                                              const Text('Confirm Sign Out ?'),
                                          actions: [
                                            TextButton(
                                              onPressed: (() {
                                                shopLogincubit.userLogOut();
                                              }),
                                              child: state
                                                      is ShopLogOutLoadinglState
                                                  ? defaultLoadingIndicator()
                                                  : Text(
                                                      'OK',
                                                      style:
                                                          defaultTitleTextStyle,
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
                                      ),
                                    );
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 200),
                                  barrierDismissible: false,
                                  barrierLabel: '',
                                  context: context,
                                  // NOTE: pageBuilder is requied so i putted a SizedBox instead of letting it empty .. it causes an error
                                  pageBuilder:
                                      (context, animation1, animation2) {
                                    return const SizedBox();
                                  });

                              // showDialog(
                              //   context: context,
                              //   builder: (context) =>
                              // );
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
              );
            },
          )),
        );
      },
    );
  }
}
