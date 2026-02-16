import 'package:e_commerce_app/models/product_item_model.dart';

import 'package:flutter/material.dart';

class AddToCartModel {
  final String productId;
  final int quantity;
  final Color? color;
  final ProductSize? size;

  AddToCartModel({
    required this.productId,
    required this.quantity,
    this.color,
    this.size,
  });

  ProductItemModel get productItem =>
      products.singleWhere((e) => e.id == productId);

  double get totalPrices => productItem.price * quantity;

  AddToCartModel copyWith({
    String? productId,
    int? quantity,
    Color? color,
    ProductSize? size,
  }) {
    return AddToCartModel(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }
}

List<AddToCartModel> cartItems = [
  AddToCartModel(productId: '2', quantity: 2, color: Colors.black),
  AddToCartModel(productId: '6', quantity: 1, size: ProductSize.M),
];
