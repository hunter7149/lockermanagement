import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locker_provider.dart';
import '../models/locker.dart';

class VisitorDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lockerProvider = Provider.of<LockerProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Visitor Dashboard")),
      body: FutureBuilder(
        future: lockerProvider.fetchLockers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final availableLockers = lockerProvider.lockers
              .where((locker) => locker.status == "Available")
              .toList();

          return ListView.builder(
            itemCount: availableLockers.length,
            itemBuilder: (context, index) {
              final locker = availableLockers[index];
              return ListTile(
                title: Text("Locker ID: ${locker.id}"),
                subtitle: Text("Status: ${locker.status}"),
                trailing: ElevatedButton(
                  onPressed: () async {
                    await lockerProvider.updateLockerStatus(locker.id, "Booked");
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
