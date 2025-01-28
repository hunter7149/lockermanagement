import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locker_provider.dart';
import '../widgets/locker_tile.dart';

class LockerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lockerProvider = Provider.of<LockerProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Lockers')),
      body: FutureBuilder(
        future: lockerProvider.fetchLockers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching lockers'));
          } else {
            return ListView.builder(
              itemCount: lockerProvider.lockers.length,
              itemBuilder: (context, index) {
                return LockerTile(locker: lockerProvider.lockers[index]);
              },
            );
          }
        },
      ),
    );
  }
}
