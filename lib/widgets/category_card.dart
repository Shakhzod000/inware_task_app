import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  const CategoryCard({this.onTap, this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 50,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: Colors.green),
        child: Center(
          child: Text(
            text!,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
