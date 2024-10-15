import 'package:flutter/material.dart';

class OptionButton extends StatefulWidget {
  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  // Variable to track the selected button
  String? selectedButton;

  @override
  void initState() {
    super.initState();
    selectedButton = 'Renter'; // Set Renter as the default selected button
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the container
        border: Border.all(color: theme.primaryColor), // Border color
        borderRadius: BorderRadius.circular(8.0), // Border radius
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedButton = 'Renter'; // Set Renter as selected
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0), // Padding around the button
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedButton == 'Renter'
                        ? theme.primaryColor // Selected button color
                        : Colors.white, // Unselected button color
                    borderRadius: BorderRadius.circular(8.0), // Border radius
                  ),
                  child: Text(
                    'Renter',
                    style: TextStyle(
                      color: selectedButton == 'Renter'
                          ? Colors.white // Text color for selected button
                          : theme.primaryColor, // Text color for unselected button
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedButton = 'Host'; // Set Host as selected
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0), // Padding around the button
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedButton == 'Host'
                        ? theme.primaryColor // Selected button color
                        : Colors.white, // Unselected button color
                    borderRadius: BorderRadius.circular(8.0), // Border radius
                  ),
                  child: Text(
                    'Host',
                    style: TextStyle(
                      color: selectedButton == 'Host'
                          ? Colors.white // Text color for selected button
                          : theme.primaryColor, // Text color for unselected button
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
