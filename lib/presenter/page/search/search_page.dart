import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firabase_book_app/presenter/page/search/search_bloc.dart';

import '../../screen/now_playing/now_playing_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  void _handleTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: _searchController,
              onChanged: (value) => {
                context.read<SearchBloc>().add(SearchEvent(value)),
                _handleTextChanged()
              },
              cursorColor: const Color(0xffe95757),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: InkWell(
                  onTap: () {
                    _searchController.text = '';
                  },
                  child: const Icon(
                    Icons.cancel,
                    color: Color(0xff8E8E93),
                  ),
                ),
                labelText: 'search books',
              ),
            ),
          ),
          Expanded(child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              else if (state is SearchLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
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
                                            bookList: state.books, index: index)));
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
                                      image: NetworkImage(state.books[index].image),
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
              } else if (state is SearchError) {
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
