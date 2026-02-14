import 'package:e_commerce_app/utils/app_routes.dart';
import 'package:e_commerce_app/view_models/home_cubit/home_cubit.dart';
import 'package:e_commerce_app/views/widgets/homepage_widgets/home_carousel_item.dart';
import 'package:e_commerce_app/views/widgets/homepage_widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (state is HomeLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                HomeCarouselItem(homeCarouselItems: state.carouselItems),
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      'New Arrivals',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'See All',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                GridView.builder(
                  itemCount: state.products.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: size.height * 0.02,
                    crossAxisSpacing: size.width * 0.02,
                    mainAxisExtent: size.height * 0.29,
                  ),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        AppRoutes.productDetailsRoute,
                        arguments: state.products[index],
                      );
                    },
                    child: ProductItem(productItem: state.products[index]),
                  ),
                ),
              ],
            ),
          );
        } else if (state is HomeError) {
          return Scaffold(
            body: Center(
              child: Text(
                state.message,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(color: Colors.red),
              ),
            ),
          );
        } else {
          return Scaffold(body: const Center(child: Text('Error')));
        }
      },
    );
  }
}
