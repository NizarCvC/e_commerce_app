import 'package:flutter/material.dart';

enum ProductSize {
  S,
  M,
  L,
  // ignore: constant_identifier_names
  XL,
}

class ProductItemModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final bool isFavorite;
  final String category;
  final double averageRate;
  final String description;
  final List<ProductSize>? availableSizes;
  final List<Color?>? availableColors;

  ProductItemModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.isFavorite = false,
    required this.category,
    required this.averageRate,
    this.description =
        "Hello World Hello World Hello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World",
    this.availableSizes,
    this.availableColors,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      //'isFavorite': isFavorite,
      'category': category,
      'averageRate': averageRate,
      'description': description,
      // 'availableSizes': availableSizes.map((x) => x?.toMap()).toList(),
      // 'availableColors': availableColors.map((x) => x?.toMap()).toList(),
    };
  }

  factory ProductItemModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return ProductItemModel(
      id: map['id'] ?? documentId,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      price: (map['price'] as num).toDouble(),
      // isFavorite: map['isFavorite'] as bool,
      category: map['category'] as String,
      averageRate: (map['averageRate'] as num).toDouble(),
      description:
          (map['description'] as String?) ??
          "Hello World Hello World Hello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World",
      // availableSizes: map['availableSizes'] != null ? List<ProductSize>.from((map['availableSizes'] as List<int>).map<ProductSize?>((x) => ProductSize.fromMap(x as Map<String,dynamic>),),) : null,
      // availableColors: map['availableColors'] != null ? List<Color?>.from((map['availableColors'] as List<int>).map<Color??>((x) => Color?.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }
}

// TODO: you have to deleted
List<ProductItemModel> products = []; 
