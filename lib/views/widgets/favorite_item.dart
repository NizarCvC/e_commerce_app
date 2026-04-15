import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/view_models/favorite_cubit/favorite_cubit.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteItem extends StatelessWidget {
  final ProductItemModel favoriteProduct;
  final VoidCallback onTap;

  const FavoriteItem({
    super.key,
    required this.favoriteProduct,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<FavoriteCubit>(context);
    return ListTile(
      onTap: onTap,
      leading: CachedNetworkImage(
        imageUrl: favoriteProduct.imageUrl,
        height: size.height * 0.05,
        fit: .cover,
      ),
      title: Text(favoriteProduct.name),
      subtitle: Text('\$${favoriteProduct.price}'),
      trailing: BlocConsumer<FavoriteCubit, FavoriteState>(
        bloc: cubit,
        listenWhen: (previous, current) => current is FavoriteError,
        listener: (context, state) {
          if (state is FavoriteError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        buildWhen: (previous, current) =>
            (current is RemoveFavoriteLoading &&
                current.productId == favoriteProduct.id) ||
            (current is RemoveFavoriteSuccess &&
                current.productId == favoriteProduct.id),
        builder: (context, state) {
          if (state is RemoveFavoriteLoading) {
            return const CircularProgressIndicator.adaptive();
          }
          return FavoriteButton(
            onTap: () async {
              await cubit.removeFavorite(favoriteProduct);
            },
            isFavorite: true,
            iconColor: Colors.red,
          );
        },
      ),
    );
  }
}
