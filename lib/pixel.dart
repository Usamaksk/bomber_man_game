import 'package:flutter/material.dart';

class MyPixels extends StatelessWidget {
  const MyPixels({super.key, this.innerColor, this.child, this.outerColor});

  final innerColor;
  final outerColor;
  final child;

  @override
  Widget build(BuildContext context) {
    ;
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.all(5),
            color: outerColor,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: innerColor,
                child: Center(
                  child: child,
                ),
              ),
            ),
          ),
        ));
  }
}
