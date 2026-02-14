import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? hight;
  final bool isLoading;

  MainButton({
    super.key,
    this.title = '',
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.hight,
    this.isLoading = false,
  }) {
    assert(title != null || isLoading == true);
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return SizedBox(
        width: double.infinity,
        height: hight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
          ),
          child: Text(title!),
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: null,
          child: const CircularProgressIndicator.adaptive(),
        ),
      );
    }
  }
}
