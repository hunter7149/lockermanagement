import 'package:flutter/material.dart';
import '../models/locker.dart';

class LockerTile extends StatelessWidget {
  final Locker locker;

  const LockerTile({required this.locker});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(locker.location),
      subtitle: Text('Status: ${locker.status}'),
      trailing: Text(locker.type),
    );
  }
}
