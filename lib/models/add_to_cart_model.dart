import 'package:flutter/material.dart';
import 'package:e_commerce_app/models/product_item_model.dart';

class AddToCartModel {
  final String id;
  final String productId;
  final int quantity;
  final Color? color;
  final ProductSize? size;

  AddToCartModel({
    required this.id,
    required this.productId,
    required this.quantity,
    this.color,
    this.size,
  });

  ProductItemModel get productItem =>
      products.singleWhere((e) => e.id == productId);

  double get totalPrices => productItem.price * quantity;

  AddToCartModel copyWith({
    String? id,
    String? productId,
    int? quantity,
    Color? color,
    ProductSize? size,
  }) {
    return AddToCartModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'quantity': quantity,
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      id: map['id'] as String,
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
    );
  }
}

List<AddToCartModel> cartItems = [
  AddToCartModel(id: '1', productId: '2', quantity: 2, color: Colors.black),
  AddToCartModel(id: '2', productId: '6', quantity: 1, size: ProductSize.M),
];
