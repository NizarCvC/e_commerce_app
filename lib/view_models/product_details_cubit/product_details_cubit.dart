import 'package:e_commerce_app/models/add_to_cart_model.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/services/auth_services.dart';
import 'package:e_commerce_app/services/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final _cartServices = CartServicesImpl();
  final _authServices = AuthServicesImpl();

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

  Future<void> addToCart(String productId) async {
    emit(ProductAddingToCart());
    try {
      final cartItem = AddToCartModel(
        id: DateTime.now().toIso8601String(),
        productId: productId,
        quantity: quantity,
        size: selectedSize,
        color: selectedColor,
      );
      final currentUser = _authServices.currentUser();
      await _cartServices.addToCart(currentUser!.uid, cartItem);
      emit(ProductAddedToCart());
    } catch (e) {
      emit(ProductAddToCartError(message: e.toString()));
    }
  }
}
