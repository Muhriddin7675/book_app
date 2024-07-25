import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookShimmer extends StatelessWidget {
  const BookShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.tertiary,
      highlightColor: Theme.of(context).colorScheme.onTertiary,
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width / 3 - 28,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)
        ),
      ),
    );
  }
}
