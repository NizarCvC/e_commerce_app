import 'package:e_commerce_app/models/add_to_cart_model.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final int value;
  final dynamic cubit;
  final AddToCartModel? cartItem;
  const Counter({
    super.key,
    required this.value,
    required this.cubit,
    this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.044,
      width: size.width * 0.3,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Row(
        mainAxisAlignment: .spaceEvenly,
        children: [
          Container(
            height: size.height * 0.038,
            decoration: BoxDecoration(shape: .circle, color: Colors.white),
            child: IconButton(
              iconSize: size.height * 0.02,
              onPressed: () => (value > 1)
                  ? ((cartItem != null)
                        ? cubit.decrementCounter(value, cartItem)
                        : cubit.decrementCounter(value))
                  : {},
              icon: Icon(
                Icons.remove,
                color: (value == 1) ? Colors.grey[400] : null,
              ),
            ),
          ),
          Text('$value', style: Theme.of(context).textTheme.titleMedium),
          Container(
            height: size.height * 0.038,
            decoration: BoxDecoration(shape: .circle, color: Colors.white),
            child: IconButton(
              iconSize: size.height * 0.02,
              onPressed: () => (value < 100)
                  ? ((cartItem != null)
                        ? cubit.incrementCounter(value, cartItem)
                        : cubit.incrementCounter(value))
                  : {},
              icon: Icon(
                Icons.add,
                color: (value == 99) ? Colors.grey[400] : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
