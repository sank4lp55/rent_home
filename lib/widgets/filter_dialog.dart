import 'package:flutter/material.dart';

typedef FilterCallback = void Function(int selectedHotelType, RangeValues selectedPriceRange, List<bool> selectedAmenities);

Future<void> showFilterDialog({
  required BuildContext context,
  required FilterCallback onApply,
}) {
  int selectedHotelType = -1; // Default: no selection
  RangeValues selectedPriceRange = const RangeValues(100, 500);
  List<String> amenities = ["Wi-Fi", "Parking", "Swimming Pool", "Gym"];
  List<bool> selectedAmenities = [false, false, false, false]; // Default: all false

  // Get the theme's primary color
  final theme = Theme.of(context);
  double screenWidth = MediaQuery.of(context).size.width;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            // backgroundColor: theme.primaryColor.withOpacity(0.05), // Use primary color as background with opacity
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
                      spacing: 8.0, // Reduced spacing between chips
                      children: List<Widget>.generate(
                        3, // Assume 3 hotel types for this example
                            (int index) {
                          return ChoiceChip(
                            label: Text('Type $index'),
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
                      min: 50,
                      max: 1000,
                      divisions: 10,
                      labels: RangeLabels(
                        '\$${selectedPriceRange.start.round()}',
                        '\$${selectedPriceRange.end.round()}',
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
                            contentPadding: EdgeInsets.zero, // Remove padding
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
                    selectedPriceRange = const RangeValues(100, 500);
                    selectedAmenities = [false, false, false, false];
                  });
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor, // Set primary color for apply button
                ),
                child: const Text("Apply Filters"),
                onPressed: () {
                  onApply(selectedHotelType, selectedPriceRange, selectedAmenities);
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
