import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final bool filled;
  final String text;

  const Button({
    super.key,
    required this.onPressed,
    this.filled = false,
    this.text = 'Yes',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150,
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
          color:
              filled ? Colors.white : const Color.fromARGB(45, 255, 255, 255),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: filled ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }
}
