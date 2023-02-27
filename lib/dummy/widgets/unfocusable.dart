import 'package:flutter/material.dart';

class UnFocusable extends StatelessWidget {
  final Widget child;

  const UnFocusable({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
