import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Color categoryColor;
  final String categoryText;
  final bool isHasCategory;
  final VoidCallback clickCategory;

  const CategoryItem({
    super.key,
    required this.categoryColor,
    required this.categoryText,
    required this.isHasCategory, required this.clickCategory,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap:clickCategory,
      child: Ink(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: (isHasCategory) ? categoryColor : categoryColor.withAlpha(20)),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            categoryText,
            style: TextStyle(
              color: (isHasCategory) ? Colors.white : categoryColor,
              fontSize: 12,
              fontFamily: 'Uni Neue',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
