import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rent_home/screens/Home/map_screen.dart';
import 'package:rent_home/widgets/slanted_container.dart';

import '../../widgets/search_area_button.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedRoleIndex = 0;

  // Function to show the collapsible bottom sheet
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // Allows the height to adapt to its content
      backgroundColor: Colors.transparent,
      // Transparent background for glassmorphism effect
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            // Semi-transparent for glassmorphism
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
                  // Makes the sheet wrap its content
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

                    // Title or Heading of the bottom sheet
                    Text(
                      "Share Memorable Stories",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(height: 15),

                    // // Horizontal image scrolling with increased height and reduced width
                    // SizedBox(
                    //   height: 10, // Increased height of the image scroll area
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 10, // Number of images
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return Container(
                    //         margin: const EdgeInsets.symmetric(horizontal: 8),
                    //         width: 100, // Reduced width
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(12),
                    //           image: DecorationImage(
                    //             image: NetworkImage(
                    //               'https://source.unsplash.com/random?house,$index',
                    //             ),
                    //             fit: BoxFit.cover,
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),

                    const SizedBox(height: 10),

                    // Mock containers in horizontal scroll
                    SizedBox(
                      height: 150, // Height of the containers scroll area
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5, // Number of mock containers
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[300],
                            ),
                            child: Center(
                              child: Text(
                                'Item ${index + 1}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                    // Spacing to the bottom of the sheet
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            const Expanded(child: MapScreen()),
            // Map or other content in the background

            // Small upward arrow button at the bottom-right corner

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                    Expanded(child: Container()),
                    SlantedContainer(),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                            decoration:
                                BoxDecoration(color: theme.primaryColor,borderRadius: BorderRadius.circular(10)),
                            
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              child: Text(
                                "Pre Booking",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _hotelTypeBubble(Icons.people),
                          _hotelTypeBubble(Icons.person),
                          _hotelSearchBubble(),
                          _hotelTypeBubble(Icons.heart_broken),
                          _hotelTypeBubble(Icons.celebration),
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
                child: _storySheetArrowButton())
          ],
        ),
      ),
    );
  }

  Widget _hotelTypeBubble(IconData icon) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: theme.primaryColor, borderRadius: BorderRadius.circular(25)),
        child: Center(
            child: Icon(
          icon,
          color: Colors.white,
        )),
      ),
    );
  }

  Widget _hotelSearchBubble() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            color: theme.primaryColor, borderRadius: BorderRadius.circular(40)),
        child: Center(
            child: Icon(
          Icons.search,
          color: Colors.white,
          size: 35,
        )),
      ),
    );
  }

  Widget _storySheetArrowButton() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
      child: GestureDetector(
        onTap: _showBottomSheet,
        // Show bottom sheet when arrow is tapped
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: const Icon(
            Icons.keyboard_arrow_up,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
