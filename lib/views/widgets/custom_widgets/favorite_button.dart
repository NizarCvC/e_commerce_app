import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

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
          onTap: () => setState(() => isFavorite = !isFavorite),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
