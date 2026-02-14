import 'package:flutter/material.dart';

class LabelWithTextField extends StatefulWidget {
  final BuildContext context;
  final TextEditingController controller;
  final String title;
  final String hintText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;

  const LabelWithTextField({
    super.key,
    required this.context,
    required this.controller,
    required this.title,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<LabelWithTextField> createState() => _LabelWithTextFieldState();
}

class _LabelWithTextFieldState extends State<LabelWithTextField> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          widget.title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: .w600),
        ),
        SizedBox(height: size.height * 0.01),
        TextFormField(
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => value == null || value.isEmpty
              ? '${widget.title} cannot be empty!'
              : null,
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.grey[100],
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: .none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
