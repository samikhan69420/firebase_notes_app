// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BlurredCircle extends StatelessWidget {
  double dx;
  double dy;
  double radius;
  Color color;
  double blur;

  BlurredCircle({
    super.key,
    required this.dx,
    required this.dy,
    required this.radius,
    required this.color,
    required this.blur,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 700),
      curve: Curves.fastOutSlowIn,
      top: dy,
      left: dx,
      child: CircleAvatar(
        backgroundColor: color,
        radius: radius,
      ).animate(
        effects: <Effect>[
          BlurEffect(
            begin: Offset(blur, blur),
            end: Offset(blur, blur),
          ),
        ],
      ),
    );
  }
}
