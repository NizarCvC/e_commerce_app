import 'package:flutter/material.dart';

class TotalPrice extends StatelessWidget {
  final String title;
  final double total;
  const TotalPrice({super.key, required this.title, required this.total});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: Colors.grey),
          ),
          Text(
            '\$${total.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
