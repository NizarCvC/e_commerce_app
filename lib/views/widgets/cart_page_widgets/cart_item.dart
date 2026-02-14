import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/add_to_cart_model.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatelessWidget {
  final AddToCartModel cartItem;
  final bool hasCounter;

  const CartItem({super.key, required this.cartItem, required this.hasCounter});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productItem = products.singleWhere((e) => e.id == cartItem.productId);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          productImage(productItem, size),
          SizedBox(width: size.width * 0.05),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  productItem.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: size.height * 0.005),
                if (hasCounter) ...[
                  productProperty(productItem, context),
                  SizedBox(height: size.height * 0.005),
                  BlocBuilder<CartCubit, CartState>(
                    bloc: BlocProvider.of<CartCubit>(context),
                    buildWhen: (previous, current) =>
                        current is QuantityCounterLoaded &&
                        current.productId == productItem.id,
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          productCounter(
                            BlocProvider.of<CartCubit>(context),
                            state,
                            productItem,
                          ),
                          productPrice(
                            context: context,
                            state: state,
                            productItem: productItem,
                          ),
                        ],
                      );
                    },
                  ),
                ] else ...[
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      productProperty(productItem, context),
                      productPrice(context: context, productItem: productItem),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Counter productCounter(
    CartCubit cubit,
    CartState state,
    ProductItemModel productItem,
  ) {
    if (state is QuantityCounterLoaded) {
      return Counter(
        value: state.value,
        productId: productItem.id,
        cubit: cubit,
      );
    } else {
      return Counter(
        value: cartItem.quantity,
        productId: productItem.id,
        cubit: cubit,
      );
    }
  }

  Text productProperty(ProductItemModel productItem, BuildContext context) {
    return (productItem.availableColors != null)
        ? Text.rich(
            TextSpan(
              text: 'Color: ',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: Colors.grey),
              children: [
                TextSpan(
                  text: 'Black',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          )
        : Text.rich(
            TextSpan(
              text: 'Size: ',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: Colors.grey),
              children: [
                TextSpan(
                  text: cartItem.size!.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
  }

  Text productPrice({
    required BuildContext context,
    CartState? state,
    required ProductItemModel productItem,
  }) {
    if (state != null) {
      if (state is QuantityCounterLoaded) {
        return Text.rich(
          TextSpan(
            text: '\$',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.primary,
              fontWeight: .w600,
            ),
            children: [
              TextSpan(
                text: (state.value * productItem.price).toStringAsFixed(1),
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(fontWeight: .w600),
              ),
            ],
          ),
        );
      } else {
        return Text.rich(
          TextSpan(
            text: '\$',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.primary,
              fontWeight: .w600,
            ),
            children: [
              TextSpan(
                text: productItem.price.toStringAsFixed(1),
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(fontWeight: .w600),
              ),
            ],
          ),
        );
      }
    } else {
      return Text.rich(
        TextSpan(
          text: '\$',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppColors.primary,
            fontWeight: .w600,
          ),
          children: [
            TextSpan(
              text: productItem.price.toStringAsFixed(1),
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontWeight: .w600),
            ),
          ],
        ),
      );
    }
  }

  ClipRRect productImage(ProductItemModel productItem, Size size) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(8.0),
      child: CachedNetworkImage(
        imageUrl: productItem.imageUrl,
        width: size.width * 0.24,
        height: size.height * 0.12,
        fit: .cover,
      ),
    );
  }
}
