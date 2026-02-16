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
      id: documentId,
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

List<ProductItemModel> products = [
  ProductItemModel(
    id: '1',
    name: 'Bulova Watch',
    imageUrl:
        'https://media.beaverbrooks.co.uk/i/beaverbrooks/bulova-collections-marine-star-0425?fmt=jpg&fmt.jpeg.interlaced=true&img404=default-404',
    price: 399,
    category: 'Watch',
    averageRate: 4.8,
    availableColors: [Colors.black, Colors.brown, Colors.grey, Colors.yellow],
  ),
  ProductItemModel(
    id: '2',
    name: 'Zala bag',
    imageUrl:
        'https://nestasia.in/cdn/shop/files/Handbag_2_f448355a-317a-428f-8903-66fc11ff61f9.jpg?v=1706518975',
    price: 59,
    category: 'Bag',
    averageRate: 4.2,
    availableColors: [Colors.black, Colors.brown, Colors.pink, Colors.red],
  ),
  ProductItemModel(
    id: '3',
    name: 'Ayta Slippers',
    imageUrl:
        'https://img.joomcdn.net/2808a78f4970336f7e234b2d633341bc0003d6c7_400_400.jpeg',
    price: 19,
    category: 'Slippers',
    averageRate: 4.5,
    availableColors: [Colors.blueGrey, Colors.brown],
  ),
  ProductItemModel(
    id: '4',
    name: 'Circle Earrings',
    imageUrl:
        'https://img.joomcdn.net/ab5a1533cccddf36290e94772a988b0f15765395_400_400.jpeg',
    price: 99,
    category: 'Accessories',
    averageRate: 4.6,
    availableColors: [Colors.amber, Colors.grey[400]],
  ),
  ProductItemModel(
    id: '5',
    name: 'Sheepskin Leather',
    imageUrl:
        'https://img.joomcdn.net/cfb5c6929cc5a7343ed5ca80d4196adda3c33e59_400_400.jpeg',
    price: 29,
    category: 'Phone cover',
    averageRate: 4.0,
    availableColors: [
      Colors.black,
      Colors.deepPurple,
      Colors.green,
      Colors.orange,
    ],
  ),
  ProductItemModel(
    id: '6',
    name: 'Polo Shirt',
    imageUrl:
        'https://img.joomcdn.net/902bd5fff39252e52f53da8f527b63836c154f6c_400_400.jpeg',
    price: 59,
    category: 'Shirt',
    averageRate: 4.9,
    availableSizes: [
      ProductSize.S,
      ProductSize.M,
      ProductSize.L,
      ProductSize.XL,
    ],
  ),
];
