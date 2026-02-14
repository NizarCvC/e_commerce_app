import 'package:flutter/material.dart';

class CheckoutHeadlineItem extends StatelessWidget {
  final String title;
  final int? numOfProducts;
  final VoidCallback? onTap;
  const CheckoutHeadlineItem({
    super.key,
    required this.title,
    this.numOfProducts,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            if (numOfProducts != null)
              Text(
                '($numOfProducts)',
                style: Theme.of(context).textTheme.titleLarge,
              ),
          ],
        ),
        if (onTap != null)
          TextButton(onPressed: onTap, child: Text('Edit'))
      ],
    );
  }
}
