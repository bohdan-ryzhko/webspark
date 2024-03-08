import 'package:flutter/material.dart';

class UnfocusWrapper extends StatelessWidget {
  const UnfocusWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}
