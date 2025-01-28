import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locker_provider.dart';
import '../models/locker.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lockerProvider = Provider.of<LockerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
      ),
      body: FutureBuilder(
        future: lockerProvider.fetchLockers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: lockerProvider.lockers.length,
            itemBuilder: (context, index) {
              final locker = lockerProvider.lockers[index];
              return ListTile(
                title: Text("Locker ID: ${locker.id}"),
                subtitle: Text("Status: ${locker.status}"),
                trailing: DropdownButton<String>(
                  value: locker.status,
                  items: ["Available", "Booked", "Under Maintenance"]
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  onChanged: (value) {
                    lockerProvider.updateLockerStatus(locker.id, value!);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
