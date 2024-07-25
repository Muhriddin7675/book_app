import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firabase_book_app/presenter/page/search/search_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../util/component/book_item.dart';
import '../../../util/component/book_shimmer.dart';
import '../../../util/utils.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _init();
    // Qo'shimcha kod - TextEditingController va FocusNode ni qayta sozlash
    _searchController.clear();
    _focusNode.unfocus();
  }

  void _init() {
    context.read<SearchBloc>().add(SearchCursorEvent(cursor: ""));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: KeyboardVisibilityBuilder(
                builder: (_ , bool isKeyboardVisible) {
                  if(!isKeyboardVisible){
                    _focusNode.unfocus();
                  }else{

                  }

                  return TextFormField(
                    focusNode: _focusNode,
                    controller: _searchController,
                    onChanged: (value) {
                      context.read<SearchBloc>().add(SearchCursorEvent(cursor: value));
                      setState(() {});
                    },
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                      color: tintColor,
                      fontSize: 12,
                      fontFamily: 'Uni Neue',
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      fillColor: const Color(0xFFF3F3F3),
                      filled: false,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: redColor,
                            width: 1,
                          )),
                      hintText: 'kitoblarni qidirish',
                      hintStyle: TextStyle(
                        color: tintColor,
                        fontSize: 12,
                        fontFamily: 'Uni Neue',
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.arrow_back),
                      prefixIconColor: tintColor,
                    ),
                  );

                },
              ),
            ),
            SizedBox(height: 8),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.status == Status.ERROR) {
                  return Container();
                } else if (state.books != null &&  state.books!.isEmpty) {
                  var width = MediaQuery.of(context).size.width / 2;
                  return Expanded(
                    child: Center(
                      child: Image.asset("assets/empty.png", height: width, width: width),
                    ),
                  );
                } else {
                  var fullSize = state.books?.length ?? 6;
                  var temp = (fullSize % 3 == 0) ? 0 : 1;
                  var size = (fullSize ~/ 3) + temp;
                  return SingleChildScrollView(
                    child: Column(
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
                                                tag: 'search',
                                                index: (i * 3),
                                              )
                                            : const BookShimmer()),
                                  if ((i * 3) + 1 < fullSize)
                                    Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: (state.status == Status.SUCCESS)
                                            ? BookItem(
                                                book: state.books ?? [],
                                                tag: 'search',
                                                index: (i * 3) + 1,
                                              )
                                            : const BookShimmer()),
                                  if ((i * 3) + 2 < fullSize)
                                    Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: (state.status == Status.SUCCESS)
                                            ? BookItem(
                                                book: state.books ?? [],
                                                tag: 'search',
                                                index: (i * 3) + 2,
                                              )
                                            : const BookShimmer()),
                                ],
                              ),
                              const SizedBox(height: 20)
                            ],
                          ),
                      ],
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
