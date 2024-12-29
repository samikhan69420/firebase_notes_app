import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final double fontSize;
  final String text;
  final TextEditingController? controller;
  final int? maxLines;
  final void Function(String)? onTapNext;
  final FocusNode? focusNode;

  const MyFormField({
    super.key,
    this.text = '',
    this.fontSize = 40,
    this.controller,
    this.maxLines,
    this.focusNode,
    this.onTapNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        onFieldSubmitted: onTapNext,
        focusNode: focusNode,
        cursorColor: Colors.white,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontWeight: FontWeight.normal,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
