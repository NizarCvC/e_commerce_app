import 'package:e_commerce_app/models/add_to_cart_model.dart';
import 'package:e_commerce_app/services/auth_services.dart';
import 'package:e_commerce_app/services/cart_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final _authServices = AuthServicesImpl();
  final _cartServices = CartServicesImpl();

  CartCubit() : super(CartInitial());
  int quantity = 1;

  Future<void> getCartItems() async {
    emit(CartLoading());
    try {
      final currentUser = _authServices.currentUser();
      final cartItems = await _cartServices.fetchCartItems(currentUser!.uid);
      final subtotal = cartItems.fold<double>(
        0,
        (prev, e) => prev + (e.productItem.price * e.quantity),
      );
      emit(CartLoaded(cartItems: cartItems, subTotal: subtotal));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void incrementCounter(int value, AddToCartModel cartItem) {
    cartItem = cartItem.copyWith(quantity: value + 1);
  }

  void decrementCounter(int value, AddToCartModel cartItem) {
    // quantity = value - 1;
    // int productIndex = cartItems.indexWhere((e) => e.productId == productId);
    // cartItems[productIndex] = cartItems[productIndex].copyWith(
    //   quantity: quantity,
    // );
    // emit(QuantityCounterLoaded(value: quantity, productId: productId));
    // emit(SubtotalUpdated(subtotal: _subTotal));
  }
}
