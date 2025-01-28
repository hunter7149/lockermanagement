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

  Future<void> addLocker(Locker locker) async {
    try {
      await LockerService().addLocker(locker);
      fetchLockers();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateLocker(String lockerID, Map<String, dynamic> data) async {
    try {
      await LockerService().updateLocker(lockerID, data);
      fetchLockers();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteLocker(String lockerID) async {
    try {
      await LockerService().deleteLocker(lockerID);
      fetchLockers();
    } catch (error) {
      throw error;
    }
  }
}
