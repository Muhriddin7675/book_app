import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util/component/appbar.dart';
import '../../../util/component/book_item.dart';
import '../../../util/component/book_shimmer.dart';
import '../../../util/utils.dart';
import 'all_bloc.dart';

class AllScreen extends StatelessWidget {
  final String categoryName;

  const AllScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        appBarName: categoryName,
        appBarColor: redColor,
        textColor: Colors.white,
        leadingIcon: Icons.arrow_back,
        action: null,
        iconColor: Colors.white,
      ),
      body: BlocConsumer<AllBloc, AllState>(
        listener: (context, state) {},
        builder: (context, state) {
          var fullSize = state.allList?.length ?? 6;
          var temp = (fullSize % 3 == 0) ? 0 : 1;
          var size = (fullSize ~/ 3) + temp;
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 24),
              for (int i = 0; i < size; i++)
                Column(
                  children: [
                    Row(
                      children: [
                        if ((i * 3) < fullSize)
                          Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: (state.status == Status.SUCCESS)
                                  ? BookItem(
                                      book: state.allList!,
                                      tag: 'all',
                                      index: (i * 3),
                                    )
                                  : const BookShimmer()),
                        if ((i * 3) + 1 < fullSize)
                          Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: (state.status == Status.SUCCESS)
                                  ? BookItem(
                                      book: state.allList!,
                                      tag: 'all',
                                      index: (i * 3) + 1,
                                    )
                                  : const BookShimmer()),
                        if ((i * 3) + 2 < fullSize)
                          Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: (state.status == Status.SUCCESS)
                                  ? BookItem(
                                      book: state.allList ?? [],
                                      tag: 'all',
                                      index: (i * 3) + 2,
                                    )
                                  : const BookShimmer()),
                      ],
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
