import 'package:e_commerce_app/models/add_to_cart_model.dart';
import 'package:e_commerce_app/models/location_item_model.dart';
import 'package:e_commerce_app/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  void getCartItems() {
    emit(CheckoutLoading());
    final items = cartItems;
    final subtotal = cartItems.fold(0.0, (prev, e) => prev + e.totalPrices);
    final numOfProduct = cartItems.fold(0, (prev, e) => prev + e.quantity);
    final paymentCard = (paymentCards.isEmpty)
        ? null
        : paymentCards.singleWhere(
            (e) => e.isChosen == true,
            orElse: () => paymentCards.first,
          );
    final location = (locations.isEmpty)
        ? null
        : locations.singleWhere(
            (e) => e.isChosen == true,
            orElse: () => locations.first,
          );
    Future.delayed(
      Duration(seconds: 0),
      () => emit(
        CheckoutLoaded(
          cartItems: items,
          totalAmount: subtotal + 10,
          numOfProducts: numOfProduct,
          chosenPaymentCard: paymentCard,
          chosenLocation: location,
        ),
      ),
    );
  }
}
