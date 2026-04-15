import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/location_item_model.dart';
import 'package:e_commerce_app/models/payment_card_model.dart';
import 'package:e_commerce_app/utils/app_routes.dart';
import 'package:e_commerce_app/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:e_commerce_app/view_models/payment_method_cubit/payment_method_cubit.dart';
import 'package:e_commerce_app/views/widgets/cart_item.dart';
import 'package:e_commerce_app/views/widgets/checkout_page_widgets/checkout_headline_item.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/main_button.dart';
import 'package:e_commerce_app/views/widgets/checkout_page_widgets/payment_method_bottom_sheet.dart';
import 'package:e_commerce_app/views/widgets/checkout_page_widgets/payment_method_item.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/total_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  Widget _buildPaymentMethodItem(
    BuildContext context,
    String title,
    VoidCallback onTap,
    PaymentCardModel? paymentCard,
    CheckoutCubit cubit,
  ) {
    if (paymentCard == null) {
      return _buildEmptyAddingItem(context, 'Add Payment Method', onTap);
    } else {
      return PaymentMethodItem(
        paymentCard: paymentCard,
        onTap: () {
          showModalBottomSheet(
            backgroundColor: Colors.grey.shade100,
            showDragHandle: true,
            isScrollControlled: true,
            context: context,
            builder: (_) {
              return BlocProvider(
                create: (context) {
                  final cubit = PaymentMethodCubit();
                  cubit.fetchPaymentMethods();
                  return cubit;
                },
                child: PaymentMethodBottomSheet(),
              );
            },
          ).then((onValue) => cubit.getCartItems());
        },
      );
    }
  }

  Widget _buildLocationItem(BuildContext context, LocationItemModel location) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(16.0),
          child: CachedNetworkImage(
            imageUrl: location.imageUrl,
            height: size.height * 0.1,
            width: size.width * 0.3,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: size.width * 0.03),
        Column(
          crossAxisAlignment: .start,
          children: [
            Text(location.city, style: textTheme.titleLarge),
            Text(
              '${location.city}, ${location.country}',
              style: textTheme.labelLarge!.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyAddingItem(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(16.0),
        child: Column(
          children: [
            IconButton(onPressed: onTap, icon: Icon(Icons.add)),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<CheckoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: BlocBuilder<CheckoutCubit, CheckoutState>(
          bloc: cubit,
          buildWhen: (previous, current) =>
              current is CheckoutLoading ||
              current is CheckoutLoaded ||
              current is CheckoutError,
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator.adaptive()),
              );
            } else if (state is CheckoutLoaded) {
              final cartItems = state.cartItems;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CheckoutHeadlineItem(
                      title: 'Address',
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.chooseLocationPageRoute)
                            .then((onValue) => cubit.getCartItems());
                      },
                    ),
                    SizedBox(height: size.height * 0.002),
                    if (state.chosenLocation != null) ...[
                      _buildLocationItem(context, state.chosenLocation!),
                    ] else ...[
                      _buildEmptyAddingItem(
                        context,
                        'Add Address for Shipping',
                        () {
                          Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.chooseLocationPageRoute);
                        },
                      ),
                    ],
                    SizedBox(height: size.height * 0.02),
                    CheckoutHeadlineItem(
                      title: 'Product ',
                      numOfProducts: state.numOfProducts,
                    ),
                    SizedBox(height: size.height * 0.01),
                    ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) => CartItem(
                        cartItem: cartItems[index],
                        hasCounter: false,
                      ),
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.grey[300]),
                    ),
                    CheckoutHeadlineItem(title: 'Payment'),
                    SizedBox(height: size.height * 0.02),
                    _buildPaymentMethodItem(
                      context,
                      'Add Payment Method',
                      () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.addNewCardPageRoute)
                            .then((onValue) => cubit.getCartItems());
                      },
                      state.chosenPaymentCard,
                      cubit,
                    ),
                    SizedBox(height: size.height * 0.01),
                    Divider(color: Colors.grey[300]),
                    TotalPrice(title: 'Total Amount', total: state.totalAmount),
                    SizedBox(height: size.height * 0.02),
                    MainButton(title: 'Proceed to Buy', onPressed: () {}),
                  ],
                ),
              );
            } else if (state is CheckoutError) {
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
        ),
      ),
    );
  }
}
