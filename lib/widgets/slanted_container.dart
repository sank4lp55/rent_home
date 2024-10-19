import 'package:flutter/material.dart';

class SlantedContainerWithFilterIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      clipBehavior: Clip.none, // Allows the icon to be positioned outside the slanted container
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the container horizontally
          children: [
            ClipPath(
              clipper: ReverseSlantClipper(),
              child: Container(
                color: theme.primaryColor, // Background color
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Take only as much height as needed
                  crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
                  children: [
                    Text(
                      "Current location",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center row content
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
        ),
        Positioned(
          bottom: -10, // Moves the icon outside of the container
          right: -20,  // Moves the icon to the right outside of the slanted container
          child: Container(
            padding: const EdgeInsets.all(10),
            // decoration: BoxDecoration(
            //   color: theme.primaryColor,
            //   shape: BoxShape.circle,
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.black.withOpacity(0.2),
            //       blurRadius: 10,
            //       offset: Offset(0, 5),
            //     ),
            //   ],
            // ),
            child: const Icon(
              Icons.filter_list_outlined,
              color: Colors.black,
              size: 24,
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
    path.lineTo(size.width - 20, size.height); // Slant inward from the bottom-right
    path.lineTo(20, size.height); // Slant inward from the bottom-left
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
