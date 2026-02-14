import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  Color _iconColorForBackground(Color? color) {
    return color!.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  List<Widget> _buildColorItems(
    BuildContext context,
    Size size,
    ProductDetailsCubit cubit,
    ProductDetailsLoaded state,
  ) {
    return [
      Text(
        'Colors',
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(fontWeight: .w600),
      ),
      SizedBox(height: size.height * 0.01),
      Row(
        children: state.product.availableColors!
            .map(
              (element) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is ColorSelected ||
                      current is ProductDetailsLoaded,
                  builder: (context, state) {
                    return InkWell(
                      onTap: () => cubit.selectColor(element),
                      child: SizedBox(
                        height: size.height * 0.05,
                        width: size.width * 0.08,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: element,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child:
                                state is ColorSelected && state.color == element
                                ? Icon(
                                    Icons.check,
                                    size: 20,
                                    color: _iconColorForBackground(element),
                                  )
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
            .toList(),
      ),
    ];
  }

  List<Widget> _buildSizeItems(
    BuildContext context,
    Size size,
    ProductDetailsCubit cubit,
    ProductDetailsLoaded stateOfProductDetailsLoaded,
  ) {
    return [
      Text(
        'Sizes',
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(fontWeight: .w600),
      ),
      SizedBox(height: size.height * 0.01),
      Row(
        children: stateOfProductDetailsLoaded.product.availableSizes!
            .map(
              (element) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SizedBox(
                  width: size.width * 0.08,
                  height: size.height * 0.05,
                  child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                    bloc: cubit,
                    buildWhen: (previous, current) =>
                        current is SizeSelected ||
                        current is ProductDetailsLoaded,
                    builder: (context, state) {
                      return InkWell(
                        onTap: () => cubit.selectSize(element),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color:
                                state is SizeSelected && state.size == element
                                ? AppColors.primary
                                : Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              element.name,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    color:
                                        state is SizeSelected &&
                                            state.size == element
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
            .toList(),
      ),
    ];
  }

  Widget _buildAddToCartButton(
    BuildContext context,
    ProductDetailsCubit cubit,
    int productId,
  ) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is ProductAddedToCart || current is ProductAddingToCart,
      builder: (context, state) {
        if (state is ProductAddingToCart) {
          return ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const CircularProgressIndicator.adaptive(),
          );
        } else if (state is ProductAddedToCart) {
          return ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: Text(
              'Added to Cart',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          );
        }
        return ElevatedButton.icon(
          onPressed: () {
            if (cubit.selectedColor != null || cubit.selectedSize != null) {
              cubit.addToCart(productId);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please select all required items.')),
              );
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          label: Text(
            'Add to Cart',
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(color: Colors.white),
          ),
          icon: Icon(Icons.shopping_bag_outlined, color: Colors.white),
        );
      },
    );
  }

  Widget _buildPriceItem(BuildContext context, ProductDetailsLoaded state) {
    return Text.rich(
      TextSpan(
        text: '\$',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: AppColors.primary,
          fontWeight: .w600,
        ),
        children: [
          TextSpan(
            text: '${state.product.price}',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.black,
              fontWeight: .w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<ProductDetailsCubit>(context);

    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is ProductDetailsLoading ||
          current is ProductDetailsLoaded ||
          current is ProductDetailsError,
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (state is ProductDetailsLoaded) {
          final product = state.product;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      shape: .circle,
                    ),
                    child: IconButton(
                      color: Colors.white70,
                      iconSize: size.height * 0.03,
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                SizedBox(
                  height: size.height * 0.48,
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    width: double.infinity,
                    fit: .cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.46),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16.0),
                        topLeft: Radius.circular(16.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Text(
                                    product.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(fontWeight: .w500),
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber),
                                      SizedBox(width: size.width * 0.01),
                                      Text(
                                        '${product.averageRate}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(fontWeight: .w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              BlocBuilder<
                                ProductDetailsCubit,
                                ProductDetailsState
                              >(
                                bloc: cubit,
                                buildWhen: (previous, current) =>
                                    current is QuantityCounter ||
                                    current is ProductDetailsLoaded,
                                builder: (context, state) {
                                  if (state is QuantityCounter) {
                                    return Counter(
                                      value: state.value,
                                      cubit: cubit,
                                    );
                                  } else if (state is ProductDetailsLoaded) {
                                    return Counter(value: 1, cubit: cubit);
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          if (state.product.availableColors != null)
                            ..._buildColorItems(context, size, cubit, state),
                          if (state.product.availableSizes != null)
                            ..._buildSizeItems(context, size, cubit, state),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: .w600),
                          ),
                          SizedBox(height: size.height * 0.01),
                          SizedBox(
                            height: size.height * 0.158,
                            child: Expanded(
                              child: SingleChildScrollView(
                                child: Text(
                                  state.product.description,
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .copyWith(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 6.0,
                              right: 6.0,
                            ),
                            child: Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                _buildPriceItem(context, state),
                                _buildAddToCartButton(
                                  context,
                                  cubit,
                                  state.product.id,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is ProductDetailsError) {
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
          return Scaffold(body: Center(child: const SizedBox.shrink()));
        }
      },
    );
  }
}
