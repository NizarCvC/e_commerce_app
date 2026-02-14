import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/location_item_model.dart';
import 'package:flutter/material.dart';

class LocationItem extends StatelessWidget {
  const LocationItem({
    super.key,
    required this.locationModel,
    required this.onTap,
    this.borderColor = Colors.grey,
  });

  final LocationItemModel locationModel;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Material(
        clipBehavior: .antiAlias,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: size.height * 0.1,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: borderColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        locationModel.city,
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: .w600,
                        ),
                      ),
                      Text(
                        '${locationModel.city}, ${locationModel.country}',
                        style: textTheme.titleSmall!.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      locationModel.imageUrl,
                    ),
                    radius: size.width * 0.08,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
