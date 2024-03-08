import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    this.controller,
    this.hintText,
  });

  final TextEditingController? controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor),
        ),
        border: const OutlineInputBorder(),
        hintText: hintText ?? '',
      ),
      cursorColor: theme.primaryColor,
    );
  }
}
