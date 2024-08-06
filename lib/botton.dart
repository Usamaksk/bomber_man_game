import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, this.color, this.child, this.function});

  final color;
  final child;
  final function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: GestureDetector(
        onTap: function,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: color,
            height: 70,
            width: 70,
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
