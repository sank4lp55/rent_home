import 'dart:async'; // Import Timer
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

class NewHomescreen extends StatefulWidget {
  const NewHomescreen({super.key});

  @override
  State<NewHomescreen> createState() => _NewHomescreenState();
}

class _NewHomescreenState extends State<NewHomescreen>
    with TickerProviderStateMixin {
  int _selectedHotelIndex = -1; // Track selected hotel type
  late AnimationController _animationController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Adjust duration as necessary
    );

    // Start the timer to play animation every 15 seconds
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
    // Reset and play the animation
    _animationController.forward(from: 0);
  }

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
                    const Text(
                      "Share Memorable Stories",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
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
                    const Expanded(child: SizedBox()),
                    SlantedContainerWithFilterIcon(),
                    const Expanded(child: SizedBox()),
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
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24.0),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _hotelTypeBlock(
                                    0, "assets/teamwork.png", "Sharing"),
                                _hotelTypeBlock(1, "assets/boy.png", "Single"),
                                SizedBox(
                                  width: 10,
                                ),
                                _hotelTypeBlock(
                                    2, "assets/couple.png", "Couple"),
                                _hotelTypeBlock(3, "assets/girls.png", "Party"),
                              ],
                            ),
                            const SizedBox(height: 16),
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
                                      onApply: (int selectedHotelType,
                                          RangeValues selectedPriceRange,
                                          List<bool> selectedAmenities) {
                                        // Handle the selected filters here
                                        print(
                                            'Selected Hotel Type: $selectedHotelType');
                                        print(
                                            'Selected Price Range: ${selectedPriceRange.start} - ${selectedPriceRange.end}');
                                        print(
                                            'Selected Amenities: $selectedAmenities');
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color:
                                          theme.primaryColor.withOpacity(0.1),
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
                          ],
                        ),
                      ),
                      Positioned(
                        top: -125,
                        // Adjust this to control how far the Lottie animation is above the container
                        left: 0,
                        right: 0,
                        child: IgnorePointer(
                          child: Center(
                            child: SizedBox(
                              height: 250, // Adjusted height
                              width: 250, // Adjusted width
                              child: Lottie.asset(
                                'assets/7GTbKOIfmD.json',
                                controller: _animationController,
                                // Set the controller
                                onLoaded: (composition) {
                                  // Set the duration of the animation
                                  _animationController.duration =
                                      composition.duration;
                                },
                                fit: BoxFit
                                    .cover, // Ensures the animation fills the box
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // Modified hotel type block to handle border toggle on tap
  Widget _hotelTypeBlock(int index, String image, String type) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        setState(() {
          // Toggle border: if already selected, deselect
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
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _selectedHotelIndex == index
                    ? theme.primaryColor
                    : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(image),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            type,
            style: TextStyle(
              fontSize: 12,
              fontWeight: _selectedHotelIndex == index
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
