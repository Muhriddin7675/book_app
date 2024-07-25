import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firabase_book_app/data/model/book_data.dart';
import 'package:flutter_firabase_book_app/presenter/page/library/library_bloc.dart';
import 'package:flutter_firabase_book_app/util/component/category_name_shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../util/component/appbar.dart';
import '../../../util/component/book_item.dart';
import '../../../util/component/book_shimmer.dart';
import '../../../util/component/home_row_components.dart';
import '../../../util/utils.dart';
import '../../screen/all/all_bloc.dart';
import '../../screen/all/all_screen.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBarComponent(
          appBarName: 'Kategoriya',
          appBarColor: Theme.of(context).colorScheme.background,
          textColor: redColor,
          leadingIcon: null,
          action: null,
        ),
        body: BlocConsumer<LibraryBloc, LibraryState>(
          listener: (context, state) {
            if (state.status != Status.LOADING) {
              refreshController.refreshCompleted();
            }
          },
          builder: (context, state) {
            if (state.status == Status.SUCCESS) {
              return SmartRefresher(
                header: const ClassicHeader(),
                onRefresh: () => context.read<LibraryBloc>().add(LibraryLoadedEvent()),
                controller: refreshController,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: state.mapList?.entries.map((entry) {
                        String category = entry.key;
                        List<BookData> books = entry.value;
                        return Column(
                          children: [
                            HomeRowComponents(
                              componentName: category,
                              clickAll: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => BlocProvider(
                                            create: (ctxCreate) => AllBloc()..add(AllLoadEvent(listBook: books)),
                                            child: AllScreen(
                                              categoryName: category,
                                            ))));
                              },
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: books.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      left: (index == 0) ? 20 : 10,
                                      right: (index == books.length - 1) ? 20 : 0,
                                    ),
                                    child: BookItem(
                                      book: books,
                                      tag: 'library',
                                      index: index,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList() ??
                      [],
                ),
              );
            } else {
              return ListView(
                children: [
                  for (int i = 0; i < 3; i++)
                    Column(
                      children: [
                        CategoryNameShimmer(),
                        SizedBox(
                            height: 150,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 7,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: EdgeInsets.only(left: (index == 0) ? 20 : 10, right: ((7 - 1) == index) ? 20 : 0),
                                      child: const BookShimmer());
                                }))
                      ],
                    )
                ],
              );
            }
          },
        ));
  }
}
