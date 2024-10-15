import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Soft background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Profile Picture with border and shadow
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  "https://example.com/profile_picture.png", // Replace with your image URL
                ),
                backgroundColor: Colors.blueAccent,
              ),
              const SizedBox(height: 15),

              // User Name with modern font
              const Text(
                "John Doe",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),

              // User Email
              const Text(
                "john.doe@example.com",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),

              // Edit Profile Button
              ElevatedButton(
                onPressed: () {
                  // Implement edit profile functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded button
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  elevation: 5, // Shadow effect
                ),
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Settings List with a card style and shadows
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 10),
                  children: [
                    _buildSettingItem(context, "Booking History", Icons.history),
                    _buildSettingItem(context, "Payment Methods", Icons.payment),
                    _buildSettingItem(context, "Notifications", Icons.notifications),
                    _buildSettingItem(context, "Help & Support", Icons.help),
                    _buildSettingItem(context, "Logout", Icons.logout, isLogout: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, IconData icon, {bool isLogout = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3, // Shadow effect for card
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent, size: 28),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {
          // Implement navigation for each setting
          if (isLogout) {
            // Handle logout
          } else {
            // Navigate to the respective screen
          }
        },
      ),
    );
  }
}
