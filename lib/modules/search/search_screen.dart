import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/controllers/Search/cubit/cubit.dart';
import 'package:shopapp/controllers/Search/cubit/states.dart';
import 'package:shopapp/models/Search/search_model.dart';
import 'package:shopapp/views/shop_layout_screen.dart';

import '../../constants/constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<FormState>();
    TextEditingController searchController = TextEditingController();
    return BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: Colors.grey.shade200,
                body: Form(
                  key: key,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.all(5),
                          height: 60,
                          child: defaultFormField(
                              style: defaultTitleTextStyle,
                              // validate: (p0) {
                              //   if (p0!.isEmpty) {
                              //     return 'enter something to search';
                              //   }
                              //   return null;
                              // },
                              suffixIcon: FontAwesomeIcons.magnifyingGlass,
                              controller: searchController,
                              keyboardType: TextInputType.text,
                              hintText: 'Search a Product',
                              onSubmit: (value) {
                                if (key.currentState!.validate()) {
                                  searchController.text = value!;
                                  SearchCubit.get(context)
                                      .search(searchController.text);
                                  searchController.clear();
                                  // print(SearchCubit.get(context).searchModel!.data!);
                                }
                              },
                              onChanged: (value) {
                                Future.delayed(const Duration(seconds: 3))
                                    .then((val) {
                                  if (key.currentState!.validate()) {
                                    searchController.text = value!;
                                    SearchCubit.get(context)
                                        .search(searchController.text);
                                    // print(SearchCubit.get(context).searchModel!.data!);

                                  } else {
                                    searchController.clear();
                                  }
                                });
                              }),
                        ),
                        if (state is SearchLoadingState)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 10,
                        ),
                        if (state is SearchgetDataSuccesState &&
                            SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data!
                                .isNotEmpty)
                          Expanded(
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: ((context, index) =>
                                    GestureDetector(
                                        child: buildFavItem(
                                            SearchCubit.get(context)
                                                .searchModel,
                                            context,
                                            index),
                                        onTap: () {
                                          navigateTo(context,
                                              const ShopLayoutScreen());
                                          SearchCubit.get(context)
                                              .searchModel!
                                              .data!
                                              .data!
                                              .clear();
                                        })),
                                separatorBuilder: ((context, index) =>
                                    const SizedBox(
                                      height: 5,
                                    )),
                                itemCount: SearchCubit.get(context)
                                    .searchModel!
                                    .data!
                                    .data!
                                    .length),
                          )
                        else if (state is SearchLoadingState)
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('lib/assets/images/search.gif'),
                                Text(
                                  'searching...',
                                  style: defaultTitleTextStyle.copyWith(
                                      fontSize: 25),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                )),
          );
        });
  }

  buildFavItem(SearchModel? model, context, int index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    CachedNetworkImage(
                      // fit: BoxFit.scaleDown,
                      placeholder: ((context, url) =>
                          defaultLoadingIndicator(color: kDefaultBlueColor)),
                      width: double.infinity,
                      height: 120,
                      imageUrl: model!.data!.data![index].image!,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                child: Text(
                  model.data!.data![index].name!,
                  //   model.data!.data![index].product!.name!,
                  style: defaultTitleTextStyle.copyWith(fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 2, 10),
              child: Row(
                children: [
                  Text(
                    model.data!.data![index].price.toString(),
                    // model.data!.data![index].product!.price.toString(),
                    style: defaultTitleTextStyle.copyWith(
                        fontSize: 12, color: kDefaultBlueColor),
                  ),
                  Text(
                    ' DZ',
                    style: defaultTitleTextStyle.copyWith(
                        color: kDefaultBlueColor, fontSize: 12),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
