import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screen/now_playing/now_playing_screen.dart';
import 'category_item.dart';
import 'home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var _category = "hammasi";
  var listCategory = ['hammasi', "badiiy", "shaxsiy rivojlanish", "biografiya"];

  @override
  void initState() {
    super.initState();
  }

  // ignore: unused_field
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Explore',
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
        ),
        actions: const [
          Icon(Icons.more_vert, color: Colors.black54),
          SizedBox(width: 24),
        ],
        leading: const Icon(Icons.arrow_back, color: Colors.black54),
      ),
      body: Column(
        children: [
          BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 8.0),
                  child: Row(
                    children: [
                      CategoryItem(
                          colorIndex: 0,
                          isChosen: _category == listCategory[0],
                          category: listCategory[0],
                          onClick: () {
                            context
                                .read<HomeBloc>()
                                .add(LoadBooks(listCategory[0]));
                            _category = listCategory[0];
                          }),
                      CategoryItem(
                          colorIndex: 1,
                          isChosen: _category == listCategory[1],
                          category: listCategory[1],
                          onClick: () {
                            context
                                .read<HomeBloc>()
                                .add(LoadBooks(listCategory[1]));
                            _category = listCategory[1];
                          }),
                      CategoryItem(
                          colorIndex: 2,
                          isChosen: _category == listCategory[2],
                          category: listCategory[2],
                          onClick: () {
                            context
                                .read<HomeBloc>()
                                .add(LoadBooks(listCategory[2]));
                            _category = listCategory[2];
                          }),
                      CategoryItem(
                          colorIndex: 3,
                          category: listCategory[3],
                          isChosen: _category == listCategory[3],
                          onClick: () {
                            context
                                .read<HomeBloc>()
                                .add(LoadBooks(listCategory[3]));
                            _category = listCategory[3];
                          }),
                    ],
                  ),
                ),
              );
            },
          ),
          Expanded(child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              else if (state is HomeLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                        child: Row(
                          children: [
                            Text(
                              "New Releases Book",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black),
                            ),
                            Spacer(),
                            Text(
                              "See All",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.redAccent),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 160,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.allBooks.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadowColor: Colors.white54,
                                elevation: 10,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NowPlayingScreen(
                                                    bookList: state.allBooks,
                                                    index: index)));
                                  },
                                  child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            state.allBooks[index].image),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Text(
                              "Featured Books",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black),
                            ),
                            Spacer(),
                            Text(
                              "See All",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.redAccent),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            childAspectRatio: 3 / 4,
                          ),
                          itemCount: state.books.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NowPlayingScreen(
                                            bookList: state.books,
                                            index: index)));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadowColor: Colors.white54,
                                elevation: 10,
                                child: Container(
                                  height: 146,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          state.books[index].image),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is HomeError) {
                return Center(
                    child: Text('Failed to load books: ${state.message}'));
              } else {
                return Container();
              }
            },
          ))
        ],
      ),
    );
  }
}
