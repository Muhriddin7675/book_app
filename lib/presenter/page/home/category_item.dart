import 'package:flutter/material.dart';

final colorList = [
  (const Color(0xffead4d4), Colors.red), // Lighter red
  (const Color(0xffeef6e0), Colors.green), // Lighter green
  (const Color(0xb386bfee),
  Colors.blue), // Original blue
  (const Color(0xfffcf8eb), Colors.yellow), // Original yellow
  (const Color(0xffc695e3), Colors.purple), // Original purple
  (const Color(0xffe1be9a), Colors.orange), // Original orange
  (const Color(0xffe7b1c8), Colors.pink), // Original pink
  (const Color(0xffc9e1c0), Colors.teal), // Original teal
  (const Color(0xffe1e5f8), Colors.indigo), // Original indigo
];

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.colorIndex,
    required this.category,
    required this.onClick,
    this.isChosen = false,
  });

  final int colorIndex;
  final String category;
  final VoidCallback onClick;
  final bool isChosen;


  @override
  Widget build(BuildContext context) {
    int colorIndex = this.colorIndex;

    return InkWell(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        height: 56,
        width: 128,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isChosen ? colorList[colorIndex % 9].$2 : colorList[colorIndex % 9].$1,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            category,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isChosen ? Colors.white : colorList[colorIndex % 9].$2,
                ),
          ),
        ),
      ),
    );
  }
}
