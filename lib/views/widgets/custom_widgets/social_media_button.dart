import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final String text;
  final String imageUrl;
  final VoidCallback onTap;

  const SocialMediaButton({
    super.key,
    required this.text,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      clipBehavior: .antiAlias,
      borderRadius: BorderRadius.circular(32),
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: BoxBorder.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(32.0),
          ),
          child: Align(
            alignment: .center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: size.height * 0.035,
                  ),
                  SizedBox(width: size.width * 0.02),
                  Text(text, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
