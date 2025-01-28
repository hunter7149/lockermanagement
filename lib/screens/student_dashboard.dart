import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locker_provider.dart';
import '../models/locker.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  late Future<void> _fetchLockersFuture;

  @override
  void initState() {
    super.initState();
    // Fetch the lockers once when the widget is initialized
    _fetchLockersFuture = context.read<LockerProvider>().fetchLockers();
  }

  @override
  Widget build(BuildContext context) {
    final lockerProvider = context.watch<LockerProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Student Dashboard")),
      body: FutureBuilder(
        future: _fetchLockersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final availableLockers = lockerProvider.lockers
              .where((locker) => locker.status.toLowerCase() == "available")
              .toList();

          if (availableLockers.isEmpty) {
            return Center(child: Text("No available lockers."));
          }

          return ListView.builder(
            itemCount: availableLockers.length,
            itemBuilder: (context, index) {
              final locker = availableLockers[index];
              return ListTile(
                title: Text("Locker ID: ${locker.id}"),
                subtitle: Text("Status: ${locker.status}"),
                trailing: ElevatedButton(
                  onPressed: () async {
                    await lockerProvider.updateLockerStatus(locker.id, "booked");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Locker ${locker.id} booked!")),
                    );
                  },
                  child: Text("Book"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}