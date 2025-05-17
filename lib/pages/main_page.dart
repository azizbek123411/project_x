import 'package:flutter/material.dart';
import 'package:project_x/pages/navbar_pages/home_page.dart';
import 'package:project_x/service/auth/auth_service.dart';

import 'navbar_pages/profile_page.dart';
import 'navbar_pages/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {




  int initialIndex=0;
  final List _pages=[
    HomePage(),
    SearchPage(),
    ProfilePage(uid: AuthService().getCurrentUid(),),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children:[ _pages[initialIndex]],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: initialIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(
          color: Colors.white
        ),

        onTap: (index){
          setState(() {
            initialIndex=index;
          });
        },
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      ),
  );
  }
}