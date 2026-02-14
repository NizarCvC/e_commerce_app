part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCartModel> cartItems;
  final double subTotal;

  CartLoaded({required this.cartItems, required this.subTotal});
}

final class CartError extends CartState {
  final String message;

  CartError({required this.message});
}

final class QuantityCounterLoaded extends CartState {
  final int value;
  final int productId;

  QuantityCounterLoaded({required this.value, required this.productId});
}

final class SubtotalUpdated extends CartState {
  final double subtotal;

  SubtotalUpdated({required this.subtotal});
}
