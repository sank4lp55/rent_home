import 'package:flutter/material.dart';

class SlantedContainerWithFilterIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // Center the container horizontally
      children: [
        ClipPath(
          clipper: ReverseSlantClipper(),
          child: Container(
            color: theme.primaryColor, // Background color
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // Take only as much height as needed
              crossAxisAlignment: CrossAxisAlignment.center,
              // Center content horizontally
              children: [
                Text(
                  "Current location",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Center row content
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
          ),
        ),
      ],
    );
  }
}

class ReverseSlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Start at the top-left corner
    path.lineTo(size.width, 0); // Go straight to the top-right corner
    path.lineTo(
        size.width - 20, size.height); // Slant inward from the bottom-right
    path.lineTo(20, size.height); // Slant inward from the bottom-left
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
