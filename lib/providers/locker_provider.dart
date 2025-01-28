import 'package:flutter/material.dart';
import '../models/locker.dart';
import '../services/locker_service.dart';

class LockerProvider with ChangeNotifier {
  List<Locker> _lockers = [];

  List<Locker> get lockers => _lockers;

  Future<void> fetchLockers() async {
    try {
      _lockers = await LockerService().getLockers();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
