import 'package:flutter/material.dart';

enum Variant {
  primary,
  secondary,
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.variant,
    required this.text,
    required this.onPressed,
    this.margin,
  });

  final Variant variant;
  final String text;
  final Function()? onPressed;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color getBGColor(Variant variant) {
      switch (variant) {
        case Variant.primary:
          return theme.primaryColor;
        case Variant.secondary:
          return Colors.white;
        default:
          return Colors.white;
      }
    }

    Color getTextColor(Variant variant) {
      switch (variant) {
        case Variant.primary:
          return Colors.white;
        case Variant.secondary:
          return theme.primaryColor;
        default:
          return Colors.white;
      }
    }

    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 50, right: 20, left: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            side: BorderSide(
              color:
                  onPressed == null ? Colors.transparent : theme.primaryColor,
              width: 1,
            ),
            backgroundColor: getBGColor(variant),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: getTextColor(variant)),
          ),
        ),
      ),
    );
  }
}
