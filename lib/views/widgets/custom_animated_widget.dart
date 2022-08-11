import 'package:flutter/material.dart';

class CustomAnimatedWidget extends StatelessWidget {
  const CustomAnimatedWidget({
    Key? key,
    required this.child,
    this.top = 0,
    this.bottom = 0,
    this.left = 0,
    this.right = 0,
  }) : super(key: key);
  final Widget child;
  final double top;
  final double bottom;
  final double left;
  final double right;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      child: child,
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeIn,
      builder: (BuildContext context, double _val, Widget? child) {
        return Opacity(
          opacity: _val,
          child: Padding(
              padding: EdgeInsets.only(
                top: _val * top,
                bottom: _val * bottom,
                left: _val * left,
                right: _val * right,
              ),
              child: child),
        );
      },
    );
  }
}
