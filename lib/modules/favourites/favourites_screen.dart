import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/models/Favourites/favourites_model.dart';

import '../../constants/constants.dart';
import '../../controllers/Shop/cubit/cubit.dart';
import '../../controllers/Shop/cubit/states.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context).favouritesModel;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return cubit!.data!.data!.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: ((context, index) => Container(
                          height: 120,
                          color: Colors.grey.shade100,
                          child: buildFavItem(cubit, context, index),
                        )),
                    separatorBuilder: ((context, index) => const Divider()),
                    itemCount: cubit.data!.data!.length),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('lib/assets/images/fav.zip'),
                  Text(
                    'No Favourites yet add some from Boutiqua',
                    style: defaultTitleTextStyle.copyWith(fontSize: 20),
                  )
                ],
              );
      },
    );
  }

  buildFavItem(FavouritesModel? model, context, int index) => Container(
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
                    placeholder: ((context, url) =>
                        defaultLoadingIndicator(color: kDefaultBlueColor)),
                    width: double.infinity,
                    height: 200,
                    imageUrl: model!.data!.data![index].product!.image!,
                  ),
                  if (model.data!.data![index].product!.discount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Discount',
                        style: defaultTitleTextStyle.copyWith(
                            fontSize: 12, color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
              child: Text(
                model.data!.data![index].product!.name!,
                style: defaultTitleTextStyle.copyWith(fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 2, 10),
                child: Text(
                  model.data!.data![index].product!.price.toString(),
                  style: defaultTitleTextStyle.copyWith(
                      fontSize: 12, color: kDefaultBlueColor),
                ),
              ),
              Text(
                "DZ",
                style: defaultTitleTextStyle.copyWith(
                    fontSize: 12, color: kDefaultBlueColor),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                model.data!.data![index].product!.discount == 0
                    ? ''
                    : model.data!.data![index].product!.oldPrice.toString(),
                style: defaultTitleTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 12,
                    decoration: TextDecoration.lineThrough),
              ),
            ],
          ),
        ],
      ));
}
