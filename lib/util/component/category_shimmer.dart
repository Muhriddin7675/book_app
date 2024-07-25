import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.tertiary,
      highlightColor: Theme.of(context).colorScheme.onTertiary,
      child: Container(
        height: 50,
        width: 100,
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(8),
            color: Colors.white
        ),
      ),
    );
  }
}