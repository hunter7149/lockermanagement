import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/locker_service.dart';
import '../models/locker.dart';

class LockerProvider with ChangeNotifier {
  final LockerService _lockerService = LockerService();

  List<Locker> _lockers = [];

  List<Locker> get lockers => _lockers;

  Future<void> fetchLockers() async {

    _lockers = await _lockerService.getLockers();
    notifyListeners();
  }

  Future<void> updateLockerStatus(String lockerId, String status) async {
    await _lockerService.updateLockerStatus(lockerId, status);
    await fetchLockers();
  }
}
