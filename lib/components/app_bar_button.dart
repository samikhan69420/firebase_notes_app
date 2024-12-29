import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onTap;
  const AppBarButton({super.key, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(45, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
