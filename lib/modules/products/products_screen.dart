import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopapp/constants/constants.dart';
import 'package:shopapp/controllers/Shop/cubit/states.dart';
import 'package:shopapp/models/shop/shop_home_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../components/components.dart';
import '../../controllers/Shop/cubit/cubit.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccesToggleFavIconState) {
          if (!state.model!.status!) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.model!.message!)));
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null,
            builder: (context) => Container(
                color: Colors.grey.shade100,
                child: homeProductsBuilder(
                    ShopCubit.get(context).homeModel, context)),
            fallback: (context) => skeletonPorsuctItemWidget());
      },
    );
  }

  Widget homeProductsBuilder(HomeModel? model, BuildContext context) {
    return model!.data == null
        ? skeletonPorsuctItemWidget()
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: CarouselSlider(
                          items: model.data?.banners
                              ?.map(
                                (e) => Image(
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(e.image)),
                              )
                              .toList(),
                          options: CarouselOptions(
                            onPageChanged: ((index, reason) {
                              ShopCubit.get(context)
                                  .toggleCarouselIndicator(index);
                            }),
                            height: 250,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            viewportFraction: 1.0,
                            autoPlay: true,
                            autoPlayAnimationDuration:
                                const Duration(seconds: 3),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: AnimatedSmoothIndicator(
                        activeIndex:
                            ShopCubit.get(context).carouselIndicatorIndex,
                        effect: const WormEffect(
                          dotHeight: 10,
                          dotWidth: 20,
                          dotColor: Colors.white10,
                          activeDotColor: Colors.white,
                        ),
                        count: model.data!.banners!.length,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(
                      thickness: 1.5,
                    ),
                  ),
                ),
                GridView.custom(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverWovenGridDelegate.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    pattern: [
                      const WovenGridTile(1),
                      const WovenGridTile(
                        5 / 7,
                        crossAxisRatio: 0.9,
                        alignment: AlignmentDirectional.centerEnd,
                      ),
                    ],
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    childCount: model.data!.products!.length,
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child:
                              buildGridProducts(model.data!, index, context)),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

Widget buildGridProducts(HomeDataModel model, int index, context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              CachedNetworkImage(
                width: double.infinity,
                height: 200,
                imageUrl: model.products![index].image,
              ),
              if (model.products![index].discount != 0)
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
      Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
        child: Text(
          model.products![index].name,
          style: defaultTitleTextStyle.copyWith(fontSize: 13),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 2, 10),
            child: Text(
              model.products![index].price.toString(),
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
            model.products![index].discount == 0
                ? ''
                : model.products![index].oldPrice.toString(),
            style: defaultTitleTextStyle.copyWith(
                color: Colors.black,
                fontSize: 12,
                decoration: TextDecoration.lineThrough),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                ShopCubit.get(context)
                    .toggleFavourites(model.products![index].id);
                print('pressed of favourite icon');
              },
              icon: Icon(
                ShopCubit.get(context).favourites![model.products![index].id]!
                    ? Icons.favorite_outlined
                    : Icons.favorite_outline_rounded,
                color: ShopCubit.get(context)
                        .favourites![model.products![index].id]!
                    ? Colors.red
                    : kDefaultBlueColor,
              ))
        ],
      )
    ],
  );
}
