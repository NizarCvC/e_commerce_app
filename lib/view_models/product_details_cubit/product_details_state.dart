part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductItemModel product;

  ProductDetailsLoaded({required this.product});
}

final class ProductDetailsError extends ProductDetailsState {
  final String message;

  ProductDetailsError({required this.message});
}

final class QuantityCounter extends ProductDetailsState {
  final int value;

  QuantityCounter({required this.value});
}

final class SizeSelected extends ProductDetailsState {
  final ProductSize size;

  SizeSelected({required this.size});
}

final class ColorSelected extends ProductDetailsState {
  final Color? color;

  ColorSelected({required this.color});
}

final class ProductAddingToCart extends ProductDetailsState {}

final class ProductAddedToCart extends ProductDetailsState {}
