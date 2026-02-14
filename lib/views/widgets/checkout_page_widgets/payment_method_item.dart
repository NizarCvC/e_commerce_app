import 'package:e_commerce_app/models/payment_card_model.dart';
import 'package:e_commerce_app/utils/app_assets.dart';
import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentCardModel paymentCard;
  final VoidCallback onTap;
  const PaymentMethodItem({
    super.key,
    required this.paymentCard,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: size.height * 0.085,
          decoration: BoxDecoration(
            border: BoxBorder.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListTile(
              leading: Image.asset(
                AppAssets.masterCardImage,
                height: size.height * 0.04,
                fit: .cover,
              ),
              title: Text('Master Card', style: textTheme.titleMedium),
              subtitle: Text(
                paymentCard.cardNumber,
                style: textTheme.labelMedium!.copyWith(color: Colors.grey[500]),
              ),
              trailing: const Icon(Icons.chevron_right_outlined),
            ),
          ),
        ),
      ),
    );
  }
}
