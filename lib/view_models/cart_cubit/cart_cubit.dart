import 'package:e_commerce_app/models/add_to_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;

  double get _subTotal =>
      cartItems.fold<double>(0, (prev, e) => prev + (e.productItem.price * e.quantity));

  void getCartItems() {
    emit(CartLoading());
    Future.delayed(Duration(seconds: 1), () {
      emit(CartLoaded(cartItems: cartItems, subTotal: _subTotal));
    });
  }

  void incrementCounter(int value, int productId) {
    quantity = value + 1;
    int productIndex = cartItems.indexWhere((e) => e.productId == productId);
    cartItems[productIndex] = cartItems[productIndex].copyWith(
      quantity: quantity,
    );
    emit(QuantityCounterLoaded(value: quantity, productId: productId));
    emit(SubtotalUpdated(subtotal: _subTotal));
  }

  void decrementCounter(int value, int productId) {
    quantity = value - 1;
    int productIndex = cartItems.indexWhere((e) => e.productId == productId);
    cartItems[productIndex] = cartItems[productIndex].copyWith(
      quantity: quantity,
    );
    emit(QuantityCounterLoaded(value: quantity, productId: productId));
    emit(SubtotalUpdated(subtotal: _subTotal));
  }
}
