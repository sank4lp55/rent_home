import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_home/screens/Home/map_screen.dart';
import 'package:rent_home/screens/notification_screen.dart';
import 'package:rent_home/widgets/custom_drawer.dart';
import 'package:rent_home/widgets/slanted_container.dart';
import 'package:rent_home/widgets/story_item.dart';

import '../../widgets/search_area_button.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedRoleIndex = -1; // Track selected bubble index

  // Function to show the collapsible bottom sheet
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(25.0)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 6,
                      width: 60,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    Text(
                      "Share Memorable Stories",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return StoryItem(index: index);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            const Expanded(child: MapScreen()),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Icon(
                                Icons.menu,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    SlantedContainerWithFilterIcon(),
                    Expanded(child: Container()),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (BuildContext context) =>
                                  NotificationsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  theme.primaryColor,
                                  theme.primaryColor.withOpacity(0.7)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.primaryColor.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              child: Text(
                                "Pre Booking",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRoleIndex = 0; // Update selected index
                              });
                            },
                            child: _hotelTypeBubble(Icons.people, _selectedRoleIndex == 0),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRoleIndex = 1; // Update selected index
                              });
                            },
                            child: _hotelTypeBubble(Icons.person, _selectedRoleIndex == 1),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRoleIndex = 2; // Update selected index
                              });
                            },
                            child: _hotelSearchBubble(_selectedRoleIndex == 2),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRoleIndex = 3; // Update selected index
                              });
                            },
                            child: _hotelTypeBubble(Icons.heart_broken, _selectedRoleIndex == 3),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRoleIndex = 4; // Update selected index
                              });
                            },
                            child: _hotelTypeBubble(Icons.celebration, _selectedRoleIndex == 4),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [SearchButton()],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 10,
              child: _storySheetArrowButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _hotelTypeBubble(IconData icon, bool isSelected) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : Colors.white, // Change color based on selection
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: theme.primaryColor,
            width: 2,
          ),
        ),
        child: Center(
            child: Icon(
              icon,
              color: isSelected ? Colors.white : theme.primaryColor, // Change icon color based on selection
            )),
      ),
    );
  }

  Widget _hotelSearchBubble(bool isSelected) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: GestureDetector(
        onTap: () {
          // Add your search functionality here
        },
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: isSelected ? theme.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: theme.primaryColor,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.primaryColor.withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 3,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 300),
              child: Icon(
                Icons.search,
                color: isSelected ? Colors.white : theme.primaryColor,
                size: 35,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _storySheetArrowButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: IconButton(
        onPressed: _showBottomSheet,
        icon: const Icon(Icons.keyboard_arrow_up),
      ),
    );
  }
}
