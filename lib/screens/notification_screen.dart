import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Booking Confirmed',
      'message': 'Your booking at City Hotel is confirmed.',
      'date': 'Oct 19, 2024',
      'isRead': false,
    },
    {
      'title': 'Host Message',
      'message': 'Your host has sent you a message.',
      'date': 'Oct 18, 2024',
      'isRead': true,
    },
    {
      'title': 'New Offer',
      'message': '20% off on your next stay! Use code: STAY20.',
      'date': 'Oct 17, 2024',
      'isRead': false,
    },
    {
      'title': 'Payment Received',
      'message': 'We have received your payment for the last stay.',
      'date': 'Oct 15, 2024',
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
        title: const Text('Notifications',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Stack(
            children: [
              Card(
                elevation: 2.0,
                margin: const EdgeInsets.symmetric(vertical: 8),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.notifications,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    notification['title'],
                    style: TextStyle(
                      fontWeight: notification['isRead']
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification['message']),
                      const SizedBox(height: 4),
                      Text(
                        notification['date'],
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    // Define what happens when a notification is clicked
                  },
                ),
              ),
              // Green dot for unread notifications
              if (!notification['isRead'])
                Positioned(
                  right: 5,
                  top: 15,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
