import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Profile Picture
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://example.com/profile_picture.png", // Replace with your image URL
                ),
              ),
              const SizedBox(height: 10),

              // User Name
              const Text(
                "John Doe",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
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
              const SizedBox(height: 20),

              // Edit Profile Button
              ElevatedButton(
                onPressed: () {
                  // Implement edit profile functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                ),
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Settings List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 10),
                  children: [
                    _buildSettingItem(
                        context, "Booking History", Icons.history),
                    _buildSettingItem(
                        context, "Payment Methods", Icons.payment),
                    _buildSettingItem(
                        context, "Notifications", Icons.notifications),
                    _buildSettingItem(context, "Help & Support", Icons.help),
                    _buildSettingItem(context, "Logout", Icons.logout,
                        isLogout: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, IconData icon,
      {bool isLogout = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontSize: 18)),
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
