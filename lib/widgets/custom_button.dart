// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    this.onTap,
  });
  final String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // margin: const EdgeInsets.only(top: 150),
        padding: const EdgeInsets.all(12),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(fontSize: 25),
        )),
      ),
    );
  }
}
