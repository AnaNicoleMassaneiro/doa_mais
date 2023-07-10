import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final String text;

  const TextComponent({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xFFD54444),
        fontSize: 30,
        fontWeight: FontWeight.w700,
        fontFamily: 'Inter',
      ),
      textAlign: TextAlign.center,
    );
  }
}
