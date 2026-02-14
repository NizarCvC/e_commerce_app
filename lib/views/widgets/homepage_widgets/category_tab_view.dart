import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            height: size.height * 0.18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                image: CachedNetworkImageProvider(categories[index].imageUrl),
                fit: .cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
