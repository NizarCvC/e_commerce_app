import 'package:e_commerce_app/utils/app_assets.dart';
import 'package:e_commerce_app/utils/app_routes.dart';
import 'package:e_commerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/views/widgets/cart_page_widgets/cart_item.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/main_button.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/total_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) {
        final cubit = CartCubit();
        cubit.getCartItems();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          final cubit = BlocProvider.of<CartCubit>(context);
          return BlocBuilder<CartCubit, CartState>(
            bloc: cubit,
            buildWhen: (previous, current) =>
                current is CartLoading ||
                current is CartLoaded ||
                current is CartError,
            builder: (context, state) {
              if (state is CartLoading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator.adaptive()),
                );
              } else if (state is CartLoaded) {
                final cartItems = state.cartItems;
                if (cartItems.isEmpty) {
                  return Column(
                    mainAxisAlignment: .start,
                    children: [
                      Image.asset(AppAssets.emptyStateImage),
                      Text(
                        'No products added to cart',
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.025),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final cartItem = cartItems[index];
                              return CartItem(
                                cartItem: cartItem,
                                hasCounter: true,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                Divider(color: Colors.grey[300]),
                          ),
                          BlocBuilder<CartCubit, CartState>(
                            bloc: cubit,
                            buildWhen: (previous, current) =>
                                current is SubtotalUpdated,
                            builder: (context, subtotalState) {
                              if (subtotalState is SubtotalUpdated) {
                                return Column(
                                  children: [
                                    TotalPrice(
                                      title: 'subtotal',
                                      total: subtotalState.subtotal,
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    TotalPrice(title: 'shipping', total: 10.0),
                                    SizedBox(height: size.height * 0.01),
                                    Dash(
                                      dashColor: Colors.grey,
                                      length: size.width * 0.92,
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    TotalPrice(
                                      title: 'total',
                                      total: subtotalState.subtotal + 10,
                                    ),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    TotalPrice(
                                      title: 'subtotal',
                                      total: state.subTotal,
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    TotalPrice(title: 'shipping', total: 10.0),
                                    SizedBox(height: size.height * 0.01),
                                    Dash(
                                      dashColor: Colors.grey,
                                      length: size.width * 0.85,
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    TotalPrice(
                                      title: 'total',
                                      total: state.subTotal + 10,
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                          SizedBox(height: size.height * 0.02),
                          MainButton(
                            title: 'Checkout',
                            onPressed: () {
                              Navigator.of(
                                context,
                                rootNavigator: true,
                              ).pushNamed(AppRoutes.checkoutPageRoute);
                            },
                          ),
                          SizedBox(height: size.height * 0.02),
                        ],
                      ),
                    ),
                  );
                }
              } else if (state is CartError) {
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
                return Scaffold(
                  body: const Center(child: Text('Something went wrong!')),
                );
              }
            },
          );
        },
      ),
    );
  }
}
