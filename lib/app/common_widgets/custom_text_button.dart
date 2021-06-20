import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final double height;
  final Widget child;
  final Color color;
  final VoidCallback onPressed;
  final double borderRadius;
  const CustomTextButton(
      {this.color,
      this.onPressed,
      this.child,
      this.borderRadius: 8.0,
      this.height: 50.0})
      : assert(borderRadius != null);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextButton(
        child: child,
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
