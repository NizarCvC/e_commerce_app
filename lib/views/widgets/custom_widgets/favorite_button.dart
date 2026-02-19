import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;
  final Color? iconColor;
  const FavoriteButton({
    super.key,
    required this.onTap,
    required this.isFavorite, this.iconColor = Colors.white70,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 6.0),
      child: Container(
        height: size.height * 0.04,
        width: size.width * 0.09,
        decoration: BoxDecoration(shape: .circle, color: Colors.white12),
        child: InkWell(
          onTap: onTap,
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
