import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/constants/constants.dart';
import 'package:shopapp/controllers/Shop/cubit/states.dart';
import 'package:shopapp/models/shop/shop_home_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../controllers/Shop/cubit/cubit.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null,
            builder: (context) =>
                homeProductsBuilder(ShopCubit.get(context).homeModel, context),
            fallback: (context) => Center(
                  child: defaultLoadingIndicator(),
                ));
      },
    );
  }

  Widget homeProductsBuilder(HomeModel? model, BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: CarouselSlider(
              items: model?.data?.banners
                  ?.map(
                    (e) => Expanded(
                      child: CachedNetworkImage(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: e['image'],
                        placeholder: ((context, url) => defaultLoadingIndicator(
                            color: Colors.blue.shade900)),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                onPageChanged: ((index, reason) {
                  ShopCubit.get(context).toggleCarouselIndicator(index);
                }),
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: AnimatedSmoothIndicator(
            activeIndex: ShopCubit.get(context).carouselIndicatorIndex,
            effect: const WormEffect(
              dotHeight: 10,
              dotWidth: 20,
              dotColor: Colors.white10,
              activeDotColor: Colors.white,
            ),
            count: model!.data!.banners!.length,
          ),
        ),
      ],
    );
  }
}
