import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Library',
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
        ),
        actions: const [
          Icon(Icons.more_vert, color: Colors.black54),
          SizedBox(width: 24),
        ],
        leading: const Icon(Icons.arrow_back, color: Colors.black54),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
              child: Row(
                children: [
                  Text(
                    "New Releases Book",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                  Spacer(),
                  Text(
                    "See All",
                    style: TextStyle(fontSize: 16, color: Colors.redAccent),
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: Colors.white54,
                      elevation: 10,
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage("assets/book.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 4),
              child: Row(
                children: [
                  Text(
                    "New Releases Book",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                  Spacer(),
                  Text(
                    "See All",
                    style: TextStyle(fontSize: 16, color: Colors.redAccent),
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: Colors.white54,
                      elevation: 10,
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage("assets/book.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 4),
              child: Row(
                children: [
                  Text(
                    "New Releases Book",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                  Spacer(),
                  Text(
                    "See All",
                    style: TextStyle(fontSize: 16, color: Colors.redAccent),
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: Colors.white54,
                      elevation: 10,
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage("assets/book.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 4),
              child: Row(
                children: [
                  Text(
                    "New Releases Book",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                  Spacer(),
                  Text(
                    "See All",
                    style: TextStyle(fontSize: 16, color: Colors.redAccent),
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: Colors.white54,
                      elevation: 10,
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage("assets/book.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 4),
              child: Row(
                children: [
                  Text(
                    "New Releases Book",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                  Spacer(),
                  Text(
                    "See All",
                    style: TextStyle(fontSize: 16, color: Colors.redAccent),
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: Colors.white54,
                      elevation: 10,
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage("assets/book.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
