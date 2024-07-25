import 'package:flutter/material.dart';

import '../utils.dart';


class HomeRowComponents extends StatelessWidget {
  final String componentName;
  final VoidCallback clickAll;

  const HomeRowComponents({super.key, required this.componentName, required this.clickAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 30.0, bottom: 22, top: 27),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            componentName,
            style: TextStyle(
              fontFamily: 'Uni Neue',
              fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: 20
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: clickAll,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Ink(
                child: Text(
                  'Hammasi',
                  style: TextStyle(
                      fontFamily: 'Uni Neue',
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: redColor
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
