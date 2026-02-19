import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/view_models/home_cubit/home_cubit.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItem;

  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<HomeCubit>(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        children: [
          Stack(
            alignment: .topCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: productItem.imageUrl,
                  height: size.height * 0.2,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator.adaptive()),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, color: Colors.red),
                  fit: .fitHeight,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: BlocBuilder<HomeCubit, HomeState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      (current is SetFavoriteLoading && current.productId == productItem.id) ||
                      (current is SetFavoriteSuccess && current.productId == productItem.id) ||
                      (current is SetFavoriteError && current.productId == productItem.id),
                  builder: (context, state) {
                    if (state is SetFavoriteLoading) {
                      return Center(child: const CircularProgressIndicator.adaptive());
                    } else if (state is SetFavoriteSuccess) {
                      if (state.isFavorite) {
                        return FavoriteButton(
                          onTap: () async {
                            await cubit.setFavorite(productItem);
                          },
                          isFavorite: true,
                        );
                      } else {
                        return FavoriteButton(
                          onTap: () async {
                            await cubit.setFavorite(productItem);
                          },
                          isFavorite: false,
                        );
                      }
                    }
                    return FavoriteButton(
                      onTap: () async {
                        await cubit.setFavorite(productItem);
                      },
                      isFavorite: productItem.isFavorite,
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.005),
          Text(
            productItem.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: size.height * 0.001),
          Text(
            productItem.category,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(color: Colors.grey[600]),
          ),
          SizedBox(height: size.height * 0.005),
          Text('\$${productItem.price}'),
        ],
      ),
    );
  }
}
