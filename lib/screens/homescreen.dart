import 'package:flutter/material.dart';
import 'package:rent_home/screens/map_screen.dart';
import '../widgets/bottom_nav.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // Track selected role: 0 for Renter, 1 for Landlord
  int _selectedRoleIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.primaryColor,
                          border: Border.all(color: Colors.white),
                        ),
                        child: const Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Current location",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 18,
                              ),
                              Text(
                                "Sector 75, Golf City, ND",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.4)),
                      )
                    ],
                  ),
                ),
                // const SizedBox(height: 16),
                // Role Toggle
                ToggleButtons(
                  isSelected: [
                    _selectedRoleIndex == 0,
                    _selectedRoleIndex == 1
                  ],
                  onPressed: (int index) {
                    setState(() {
                      _selectedRoleIndex = index;
                    });
                  },
                  color: Colors.white,
                  selectedColor: Colors.black,
                  fillColor: Colors.white.withOpacity(0.4),
                  borderColor: Colors.white,
                  selectedBorderColor: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  constraints: const BoxConstraints(
                    minHeight: 30, // Minimum height for the toggle buttons
                  ),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8), // Reduced padding
                      child: Text('Renter'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8), // Reduced padding
                      child: Text('Host'),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
            const Expanded(child: MapScreen()),
          ],
        ),
      ),
    );
  }
}
