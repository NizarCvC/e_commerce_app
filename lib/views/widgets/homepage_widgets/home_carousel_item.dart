import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/home_carousel_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomeCarouselItem extends StatelessWidget {
  final List<HomeCarouselItemModel> homeCarouselItems;

  const HomeCarouselItem({super.key, required this.homeCarouselItems});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      itemCount: homeCarouselItems.length,
      itemBuilder: (context, itemIndex, pageViewIndex) => Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16.0),
              child: CachedNetworkImage(
                imageUrl: homeCarouselItems[itemIndex].imageUrl,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator.adaptive()),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: Colors.red),
                fit: .cover,
              ),
            ),
          );
        },
      ),
      options: FlutterCarouselOptions(
        height: 200.0,
        showIndicator: true,
        slideIndicator: CircularWaveSlideIndicator(),
        enableInfiniteScroll: true,
        autoPlay: true,
      ),
    );
  }
}
