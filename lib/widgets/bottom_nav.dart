import 'package:flutter/material.dart';
import 'package:rent_home/screens/homescreen.dart';
import 'package:rent_home/screens/profile_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController pageController = PageController(initialPage: 0);
  bool isHomeActive = true;
  bool isMessageActive = false;
  bool isBookmarkActive = false;
  bool isProfileActive = false;
  late ValueNotifier<int> _selectedIndex =  ValueNotifier(0);

  final pages = [
    Homescreen(),
    ProfileScreen(),
    Homescreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        // extendBody: true,
        body: ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          },
        ),
      ),
      Positioned(
        bottom: 30,
        left: 30,
        right: 30,
        child: _bottomNavBar(context),
      ),
    ]);
  }

  Widget _bottomNavBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      // Center the container horizontally
      child: Container(
        width: screenWidth - 30, // Set the width to screen width - 30
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navBarItem(
              icon: Icons.home_filled,
              label: 'Home',
              isActive:  _selectedIndex.value==0,
              onTap: () {
                setState(() {
                  _selectedIndex.value=0;
                });
                pageController.jumpToPage(0);
              },
            ),
            _navBarItem(
              icon: Icons.chat,
              label: 'Chat',
              isActive: _selectedIndex.value==1,
              onTap: () {
                setState(() {
                  _selectedIndex.value=1;
                });
                pageController.jumpToPage(1);
              },
            ),
            _navBarItem(
              icon: Icons.bookmark_outline,
              label: 'Bookmark',
              isActive: _selectedIndex.value==2,
              onTap: () {
                setState(() {
                  _selectedIndex.value=2;
                });
                pageController.jumpToPage(2);
              },
            ),
            _navBarItem(
              icon: Icons.person_outline,
              label: 'Profile',
              isActive: _selectedIndex.value==3,
              onTap: () {
                setState(() {
                  _selectedIndex.value=3;
                });
                pageController.jumpToPage(3);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _navBarItem(
      {IconData? icon,
      String? label,
      required bool isActive,
      VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor:
                isActive ? Theme.of(context).primaryColor : Colors.grey,
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
