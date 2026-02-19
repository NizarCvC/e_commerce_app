import 'package:e_commerce_app/view_models/favorite_cubit/favorite_cubit.dart';
import 'package:e_commerce_app/views/widgets/favoriteItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = FavoriteCubit();
        cubit.getFavoriteProducts();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          final cubit = BlocProvider.of<FavoriteCubit>(context);
          return BlocBuilder<FavoriteCubit, FavoriteState>(
            bloc: cubit,
            buildWhen: (previous, current) =>
                current is FavoriteLoading ||
                current is FavoriteLoaded ||
                current is FavoriteError,
            builder: (context, state) {
              if (state is FavoriteLoading) {
                return const CircularProgressIndicator.adaptive();
              } else if (state is FavoriteLoaded) {
                final favoriteProducts = state.favoriteProducts;
                if (favoriteProducts.isEmpty) {
                  return const Center(child: Text("No favorite products"));
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await cubit.getFavoriteProducts();
                    },
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const Divider(thickness: 0.5),
                      itemCount: favoriteProducts.length,
                      itemBuilder: (context, index) => FavoriteItem(
                        favoriteProduct: favoriteProducts[index],
                        onTap: () {},
                      ),
                    ),
                  ),
                );
              } else if (state is FavoriteError) {
                return Center(
                  child: Text(
                    state.message,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineLarge!.copyWith(color: Colors.red),
                  ),
                );
              } else {
                return const Center(child: Text('Something went wrong!'));
              }
            },
          );
        },
      ),
    );
  }
}
