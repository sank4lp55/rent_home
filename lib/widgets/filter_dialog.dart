import 'package:flutter/material.dart';

typedef FilterCallback = void Function(int selectedHotelType, RangeValues selectedPriceRange, List<bool> selectedAmenities, double selectedDistance);

Future<void> showFilterDialog({
  required BuildContext context,
  required FilterCallback onApply,
}) {
  int selectedHotelType = -1; // Default: no selection
  RangeValues selectedPriceRange = const RangeValues(500, 10000); // Updated max price to 1000
  List<String> amenities = ["Wi-Fi", "Parking", "Swimming Pool", "Gym"];
  List<bool> selectedAmenities = [false, false, false, false]; // Default: all false
  double selectedDistance = 10.0; // Default distance value
  List<String> hotelTypes = ["Sharing", "Single", "Couple", "Party"]; // Updated hotel types

  // Get the theme's primary color
  final theme = Theme.of(context);
  double screenWidth = MediaQuery.of(context).size.width;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              "Filter Options",
              style: TextStyle(
                color: theme.primaryColor, // Use primary color for title
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Container(
              width: screenWidth - 10, // Set the width of the dialog
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hotel Type",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.primaryColor),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      children: List<Widget>.generate(
                        hotelTypes.length,
                            (int index) {
                          return ChoiceChip(
                            label: Text(hotelTypes[index]),
                            selected: selectedHotelType == index,
                            selectedColor: theme.primaryColor.withOpacity(0.3),
                            onSelected: (bool selected) {
                              setState(() {
                                selectedHotelType = selected ? index : -1;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Price Range",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.primaryColor),
                    ),
                    RangeSlider(
                      values: selectedPriceRange,
                      min: 500,
                      max: 10000, // Updated max price to 1000
                      divisions: 10,
                      labels: RangeLabels(
                        '₹${selectedPriceRange.start.round()}',
                        '₹${selectedPriceRange.end.round()}',
                      ),
                      activeColor: theme.primaryColor,
                      onChanged: (RangeValues values) {
                        setState(() {
                          selectedPriceRange = values;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Amenities",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.primaryColor),
                    ),
                    Column(
                      children: List<Widget>.generate(
                        amenities.length,
                            (int index) {
                          return CheckboxListTile(
                            activeColor: theme.primaryColor,
                            contentPadding: EdgeInsets.zero,
                            title: Text(amenities[index]),
                            value: selectedAmenities[index],
                            onChanged: (bool? value) {
                              setState(() {
                                selectedAmenities[index] = value ?? false;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Distance (km)",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.primaryColor),
                    ),
                    Slider(
                      value: selectedDistance,
                      min: 0,
                      max: 50,
                      divisions: 10,
                      label: '${selectedDistance.round()} km',
                      activeColor: theme.primaryColor,
                      onChanged: (double value) {
                        setState(() {
                          selectedDistance = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text("Clear Filters", style: TextStyle(color: theme.primaryColor)),
                onPressed: () {
                  setState(() {
                    // Reset all filter selections
                    selectedHotelType = -1;
                    selectedPriceRange = const RangeValues(500, 10000); // Reset price range to 100 - 1000
                    selectedAmenities = [false, false, false, false];
                    selectedDistance = 10.0;
                  });
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                ),
                child: const Text("Apply Filters",style: TextStyle(color: Colors.white),),
                onPressed: () {
                  onApply(selectedHotelType, selectedPriceRange, selectedAmenities, selectedDistance);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}
