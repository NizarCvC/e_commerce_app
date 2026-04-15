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

final class QuantityCounterLoading extends CartState {}

final class QuantityCounterLoaded extends CartState {
  final int value;
  final String productId;

  QuantityCounterLoaded({required this.value, required this.productId});
}

final class QuantityCounterError extends CartState {
  final String message;

  QuantityCounterError({required this.message});
}

final class SubtotalUpdated extends CartState {
  final double subtotal;

  SubtotalUpdated({required this.subtotal});
}
