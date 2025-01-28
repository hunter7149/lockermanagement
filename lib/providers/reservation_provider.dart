import 'package:flutter/material.dart';
import '../services/reservation_service.dart';

class ReservationProvider with ChangeNotifier {
  Future<void> reserveLocker({
    required String lockerID,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      await ReservationService().createReservation(
        lockerID: lockerID,
        startDate: startDate,
        endDate: endDate,
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
