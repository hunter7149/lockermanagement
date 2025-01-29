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
        backgroundColor:  Colors.blue.withOpacity(0.4),
        title: const Text('Locker Management'),
      ),
      body: Container(
                            decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.withOpacity(0.4),
              Colors.purple.withOpacity(0.5),
            ],
          ),
        ),
        child: FutureBuilder(
          future: Provider.of<LockerProvider>(context, listen: false).fetchLockers(),
          
          builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error loading users'));
              }
              else {
                    return Consumer<LockerProvider>(
              builder: (context, lockerProvider, child) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: lockerProvider.lockers.length,
                        itemBuilder: (context, index) {
                          Locker locker = lockerProvider.lockers[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                            tileColor: Colors.white,
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
                            ),
                          );
                        },
                      ),
                    ),
                                InkWell(
                          onTap:  () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LockerFormScreen()),
                        );
                      },
                          child: Container(
                            height: 60,
                            width: double.maxFinite,
                            decoration: BoxDecoration(color: Colors.purple.shade700),
                            child: Center(child: Text('Add User', style: TextStyle(color: Colors.white))),
                          ),
                        ),
                
                  ],
                );
              },
            );
         
              }
         }
        ),
      ),
    );
  }
}
