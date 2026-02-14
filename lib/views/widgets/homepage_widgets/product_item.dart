import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItem;

  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        children: [
          Stack(
            alignment: .topCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: productItem.imageUrl,
                  height: size.height * 0.2,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator.adaptive()),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, color: Colors.red),
                  fit: .fitHeight,
                ),
              ),
              Align(alignment: Alignment.topRight, child: FavoriteButton()),
            ],
          ),
          SizedBox(height: size.height * 0.005),
          Text(
            productItem.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: size.height * 0.001),
          Text(
            productItem.category,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(color: Colors.grey[600]),
          ),
          SizedBox(height: size.height * 0.005),
          Text('\$${productItem.price}'),
        ],
      ),
    );
  }
}
