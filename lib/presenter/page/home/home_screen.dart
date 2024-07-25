import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firabase_book_app/presenter/page/library/library_bloc.dart';
import 'package:flutter_firabase_book_app/presenter/page/library/library_page.dart';
import 'package:flutter_firabase_book_app/presenter/screen/all/all_bloc.dart';
import 'package:flutter_firabase_book_app/presenter/screen/all/all_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_bloc.dart';
import '../../../util/component/appbar.dart';
import '../../../util/component/book_item.dart';
import '../../../util/component/book_shimmer.dart';
import '../../../util/component/category_item.dart';
import '../../../util/component/category_shimmer.dart';
import '../../../util/component/home_row_components.dart';
import '../../../util/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = HomeBloc();
  final refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    bloc.add(Init(categoryIndex: 0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBarComponent(
            appBarName: 'Kutubxona',
            appBarColor: Theme.of(context).colorScheme.background,
            textColor: redColor,
            leadingIcon: null,
            action: null,
          ),
          body: BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state.status != Status.LOADING) {
                refreshController.refreshCompleted();
              }
            },
            child: SmartRefresher(
              onRefresh: () => bloc.add(Init(categoryIndex: 0)),
              header: const ClassicHeader(),
              controller: refreshController,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  HomeRowComponents(
                    componentName: 'Ommabop kitoblar',
                    clickAll: () {
                      if(context.read<HomeBloc>().state.allBooks != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => BlocProvider(
                                    create: (ctxCreate) => AllBloc()..add(AllLoadEvent(listBook: context.read<HomeBloc>().state.allBooks ?? [])),
                                    child: const AllScreen(categoryName: "Ommabop kitoblar"),
                                  )));
                      }
                    },
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) => (previous.books) != (current.books),
                    builder: (context, state) {
                      return SizedBox(
                          height: 150,
                          child: (state.status == Status.SUCCESS)
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.allBooks?.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: (index == 0) ? 20 : 10, right: (((state.allBooks?.length ?? 0) - 1) == index) ? 20 : 0),
                                      child: BookItem(
                                        book: state.allBooks!,
                                        tag: '',
                                        index: index,
                                      ),
                                    );
                                  })
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 7,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: EdgeInsets.only(left: (index == 0) ? 20 : 10, right: ((7 - 1) == index) ? 20 : 0),
                                        child: const BookShimmer());
                                  }));
                    },
                  ),
                  HomeRowComponents(
                    componentName: 'Kategoriya',
                    clickAll: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => BlocProvider(
                                    create: (context) => LibraryBloc()..add(LibraryLoadedEvent()),
                                    child: const LibraryPage(),
                                  )));
                    },
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return SizedBox(
                          height: 50,
                          child: (state.status == Status.SUCCESS)
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.category?.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: EdgeInsets.only(left: (index == 0) ? 20 : 10, right: ((7 - 1) == index) ? 20 : 0),
                                        child: CategoryItem(
                                          categoryColor: categoryColors[index],
                                          categoryText: state.category![index],
                                          isHasCategory: index == state.categoryIndex,
                                          clickCategory: () {
                                            if (state.categoryIndex != index) {
                                              bloc.add(ByCategoryBookEvent(categoryIndex: index));
                                            }
                                          },
                                        ));
                                  })
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 7,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: EdgeInsets.only(left: (index == 0) ? 20 : 10, right: ((7 - 1) == index) ? 20 : 0),
                                        child: const CategoryShimmer());
                                  }));
                    },
                  ),
                  HomeRowComponents(
                    componentName: 'Tavsiya etilgan kitoblar',
                    clickAll: () {
                      if(context.read<HomeBloc>().state.books != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => BlocProvider(
                                    create: (ctxCreate) => AllBloc()..add(AllLoadEvent(listBook: context.read<HomeBloc>().state.books!)),
                                    child: const AllScreen(
                                      categoryName: "Tavsiya etilgan kitoblar",
                                    ),
                                  )));
                      }
                    },
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) => (previous.books) != (current.books),
                      builder: (context, state) {
                        var fullSize = state.books?.length ?? 6;
                        var temp = (fullSize % 3 == 0) ? 0 : 1;
                        var size = (fullSize ~/ 3) + temp;

                        return Column(
                          children: [
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
                                                    book: state.books ?? [],
                                                    tag: '_',
                                                    index: (i * 3),
                                                  )
                                                : const BookShimmer()),
                                      if ((i * 3) + 1 < fullSize)
                                        Padding(
                                            padding: const EdgeInsets.only(left: 20.0),
                                            child: (state.status == Status.SUCCESS)
                                                ? BookItem(
                                                    book: state.books ?? [],
                                                    tag: '_',
                                                    index: (i * 3) + 1,
                                                  )
                                                : const BookShimmer()),
                                      if ((i * 3) + 2 < fullSize)
                                        Padding(
                                            padding: const EdgeInsets.only(left: 20.0),
                                            child: (state.status == Status.SUCCESS)
                                                ? BookItem(
                                                    book: state.books ?? [],
                                                    tag: '_',
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
                      }),
                  const SizedBox(height: 80)
                ],
              ),
            ),
          )),
    );
  }
}
