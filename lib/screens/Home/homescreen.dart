import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rent_home/screens/Home/map_screen.dart';
import 'package:rent_home/screens/notification_screen.dart';
import 'package:rent_home/widgets/custom_drawer.dart';
import 'package:rent_home/widgets/slanted_container.dart';
import 'package:rent_home/widgets/story_item.dart';
import '../../widgets/filter_dialog.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with TickerProviderStateMixin {
  int _selectedHotelIndex = -1;
  late AnimationController _animationController;
  late Timer _timer;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DraggableScrollableController _dragController = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      _playAnimation();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _playAnimation() {
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: const MapScreen(),
            ),
            // Top Bar
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SlantedContainerWithFilterIcon(),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Bottom Sheet with Swipe
            DraggableScrollableSheet(
              controller: _dragController,
              initialChildSize: 0.22,
              minChildSize: 0.22,
              maxChildSize: 0.38,
              builder: (context, scrollController) {
                return Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    // Main Bottom Sheet Content
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, -5),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            // Drag handle
                            Container(
                              height: 4,
                              width: 40,
                              margin: const EdgeInsets.symmetric(vertical: 0),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Hotel type blocks row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _hotelTypeBlock(0, "assets/teamwork.png", "Sharing"),
                                      _hotelTypeBlock(1, "assets/boy.png", "Single"),
                                      const SizedBox(width: 10),
                                      _hotelTypeBlock(2, "assets/couple.png", "Couple"),
                                      _hotelTypeBlock(3, "assets/girls.png", "Party"),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  // Find home button row
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: theme.primaryColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Find my home",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      InkWell(
                                        onTap: () {
                                          showFilterDialog(
                                            context: context,
                                            onApply: (selectedHotelType, selectedPriceRange, selectedAmenities, selectedDistance) {
                                              // Handle filters
                                              print('Selected Hotel Type: $selectedHotelType');
                                              print('Selected Price Range: ${selectedPriceRange.start} - ${selectedPriceRange.end}');
                                              print('Selected Amenities: $selectedAmenities');
                                              print('Selected Distance: $selectedDistance km');
                                            },
                                          );
                                        },

                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: theme.primaryColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Image.asset("assets/filter.png"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Image row
                                  const SizedBox(height: 20),

                                  SizedBox(
                                    height: 120,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                          child: StoryItem(index: index),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Lottie Animation positioned above the sheet
                    Positioned(
                      top: -125,
                      child: IgnorePointer(
                        child: SizedBox(
                          height: 250,
                          width: 250,
                          child: Lottie.asset(
                            'assets/7GTbKOIfmD.json',
                            controller: _animationController,
                            onLoaded: (composition) {
                              _animationController.duration = composition.duration;
                            },
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _hotelTypeBlock(int index, String image, String type) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        setState(() {
          if (_selectedHotelIndex == index) {
            _selectedHotelIndex = -1;
          } else {
            _selectedHotelIndex = index;
          }
        });
      },
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _selectedHotelIndex == index
                    ? theme.primaryColor
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Center(
              child: Image.asset(image, height: 30, width: 30),
            ),
          ),
          const SizedBox(height: 4),
          Text(type),
        ],
      ),
    );
  }
}
