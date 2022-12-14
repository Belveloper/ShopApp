import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/constants/constants.dart';
import 'package:shopapp/controllers/Shop/cubit/states.dart';
import 'package:shopapp/models/Categories/shop_categories_model.dart';
import 'package:skeletons/skeletons.dart';

import '../../components/components.dart';
import '../../controllers/Shop/cubit/cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopLoadingCategoriesState) {
          skeletonCategoryItem();
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.categoriesModel != null,
          builder: ((context) => Container(
                color: Colors.grey.shade100,
                child: buildCategoryItem(cubit.categoriesModel!),
              )),
          fallback: (context) => skeletonCategoryItem(),
        );
      },
    );
  }

  buildCategoryItem(CategoriesModel model) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: ((context, index) => Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CachedNetworkImage(
                        placeholder: (context, url) => const SkeletonAvatar(
                              style: SkeletonAvatarStyle(height: 100, width: 120
                                  // borderRadius: BorderRadius.circular(13),
                                  ),
                            ),
                        height: 100,
                        fit: BoxFit.cover,
                        imageUrl: model.data!.data![index].image!),
                    Text(
                      model.data!.data![index].name!,
                      style:
                          defaultTitleTextStyle.copyWith(color: Colors.black),
                    ),
                    IconButton(
                        onPressed: (() {}),
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.grey.shade400,
                        ))
                  ],
                ),
              ),
            )),
        separatorBuilder: ((context, index) => const SizedBox(
              height: 10,
            )),
        itemCount: model.data!.data!.length);
  }
}
