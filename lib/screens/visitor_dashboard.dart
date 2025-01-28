import 'package:flutter/material.dart';
import '../screens/reservation_screen.dart';
import '../screens/notification_screen.dart';

class VisitorDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitor Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Reserve a Locker'),
            leading: Icon(Icons.lock_open),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReservationScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
