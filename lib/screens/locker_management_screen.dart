import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/locker.dart';
import '../providers/locker_provider.dart';
import 'locker_form_screen.dart';

class LockerManagementScreen extends StatelessWidget {
  const LockerManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locker Management'),
      ),
      body: Consumer<LockerProvider>(
        builder: (context, lockerProvider, child) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LockerFormScreen()),
                  );
                },
                child: const Text('Add Locker'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: lockerProvider.lockers.length,
                  itemBuilder: (context, index) {
                    Locker locker = lockerProvider.lockers[index];
                    return ListTile(
                      title: Text('Locker ${locker.id}'),
                      subtitle: Text('Status: ${locker.status}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LockerFormScreen(locker: locker)),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              lockerProvider.deleteLocker(locker.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
