import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF26B6C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/edit.png',
                width: 28,
                height: 28,
              )),
          const SizedBox(width: 16)
        ],
      ),
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color(0xFFF26B6C),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(24.0),
                        bottomLeft: Radius.circular(24.0),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 36,
                      ),
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            image: const DecorationImage(
                                image: AssetImage(
                                  'assets/person.jpg',
                                ),
                                fit: BoxFit.cover)),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(top: 24.0),
                          child: Text(
                            'Maria Akter Dipti',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ))),
          const Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(children: [
                      Text(
                        'User Name',
                        style:
                            TextStyle(color: Color(0xFFF26B6C), fontSize: 20),
                      ),
                      Spacer(),
                      Text(
                        'dipti_2020',
                        style: TextStyle(color: Colors.black54, fontSize: 20),
                      ),
                    ]),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Email',
                          style:
                              TextStyle(color: Color(0xFFF26B6C), fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          'mariadipti@gmail.com',
                          style: TextStyle(color: Colors.black54, fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Change password',
                          style:
                              TextStyle(color: Color(0xFFF26B6C), fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 24,
                          color: Colors.black54,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Notification',
                          style:
                              TextStyle(color: Color(0xFFF26B6C), fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.notifications_none,
                          size: 24,
                          color: Colors.black54,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Enable Dark Mode',
                          style:
                              TextStyle(color: Color(0xFFF26B6C), fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.dark_mode_outlined,
                          color: Colors.black54,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Settings',
                          style:
                              TextStyle(color: Color(0xFFF26B6C), fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.settings,
                          size: 24,
                          color: Colors.black54,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
