import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../page/home/home_bloc.dart';
import '../../page/home/home_screen.dart';
import '../../page/library/library_page.dart';
import '../../page/profil/profile_screen.dart';
import '../../page/search/search_bloc.dart';
import '../../page/search/search_page.dart';
import '../now_playing/now_playing_bloc.dart';
import '../now_playing/now_playing_screen.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            BlocProvider(
              create: (context) => HomeBloc()..add(LoadBooks("hammasi")),
              child: const HomeScreen(),
            ),
            BlocProvider(
              create: (context) => SearchBloc(),
              child: const SearchPage(),
            ),
            const LibraryPage(),
            const ProfileScreen(),
          ],
        ),
      ),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => NowPlayingBloc(),
                        child: const NowPlayingScreen(
                          bookList: [],
                          index: -1,
                        ),
                      )));
        },
        backgroundColor: Colors.red,
        // Orqa fon rangi
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        child: const Icon(
          Icons.play_arrow,
          size: 42,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 74,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBottomNavigationItem(Icons.home_outlined, 'Home', 0),
              _buildBottomNavigationItem(Icons.search_outlined, 'Search', 1),
              const SizedBox(width: 4), // Add a gap in the middle
              _buildBottomNavigationItem(
                  Icons.library_books_outlined, 'Library', 2),
              _buildBottomNavigationItem(Icons.person_outline, 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: _selectedIndex == index ? Colors.red : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
