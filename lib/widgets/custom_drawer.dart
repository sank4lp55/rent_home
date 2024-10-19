import 'package:flutter/material.dart';
import 'package:rent_home/widgets/option_button.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Total height of the screen
    double totalHeight = MediaQuery.of(context).size.height;

    // Height of the top and bottom padding (safe area)
    double safeAreaVerticalPadding = MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom;

    // Height available for the content (excluding safe area)
    double safeAreaHeight = totalHeight - safeAreaVerticalPadding;

    return Drawer(
      child: Column(
        children: <Widget>[
          // Custom profile header
          Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.fromLTRB(16, safeAreaVerticalPadding + 16, 16, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile picture
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://i.pinimg.com/originals/f0/30/08/f03008c04c5976c7f33f39a1e92478e7.jpg', // Your profile picture URL
                  ),
                ),
                const SizedBox(width: 16), // Space between profile picture and text
                // Name and rating
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Host Name", // Host name
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4), // Space between name and rating
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "4.5", // Rating of the host
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Drawer items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text('City'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text('History'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.security),
                  title: Text('Safety'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.question_answer),
                  title: Text('FAQ'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.support),
                  title: Text('Support'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.contact_phone),
                  title: Text('Contact'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.call),
                  title: Text('Call Support'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.brightness_6),
                  title: Text('Theme'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About'),
                  onTap: () {},
                ),
              ],
            ),
          ),

          // Button to switch between renter and host
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 25),
            child: OptionButton()
          ),

          // Social media icons at the bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.facebook),
                  color: Colors.blue,
                  onPressed: () {
                    // Facebook icon action
                  },
                ),
                IconButton(
                  icon: Icon(Icons.photo_camera), // Use proper icon for Instagram
                  color: Colors.pinkAccent,
                  onPressed: () {
                    // Instagram icon action
                  },
                ),
                IconButton(
                  icon: Icon(Icons.alternate_email), // Use proper icon for Twitter
                  color: Colors.lightBlue,
                  onPressed: () {
                    // Twitter icon action
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
