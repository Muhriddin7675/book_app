import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryNameShimmer extends StatelessWidget {
  const CategoryNameShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 26.0, bottom: 20, top: 24),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.tertiary,
        highlightColor: Theme.of(context).colorScheme.onTertiary,
        child: Row(
          children: [
            Container(
              height: 32,
              width: 150,
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white
              ),
            ),
            const Spacer(),
            Container(
              height: 24,
              width: 64,
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
