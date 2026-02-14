import 'package:e_commerce_app/models/add_to_cart_model.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  Color? selectedColor;
  ProductSize? selectedSize;
  int quantity = 1;

  void getProductDetails(ProductItemModel product) {
    emit(ProductDetailsLoading());
    Future.delayed(
      const Duration(seconds: 1),
      () => emit(ProductDetailsLoaded(product: product)),
    );
  }

  void incrementCounter(int value) {
    quantity = value + 1;
    emit(QuantityCounter(value: quantity));
  }

  void decrementCounter(int value) {
    quantity = value - 1;
    emit(QuantityCounter(value: quantity));
  }

  void selectSize(ProductSize size) {
    emit(SizeSelected(size: size));
    selectedSize = size;
  }

  void selectColor(Color? color) {
    emit(ColorSelected(color: color));
    selectedColor = color;
  }

  void addToCart(int productId) {
    emit(ProductAddingToCart());
    final cartItem = AddToCartModel(
      productId: productId,
      quantity: quantity,
      size: selectedSize,
      color: selectedColor,
    );
    cartItems.add(cartItem);
    Future.delayed(Duration(seconds: 1), () {
      emit(ProductAddedToCart());
    });
  }
}
