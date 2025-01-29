import 'package:flutter/material.dart';
import '../services/reservation_service.dart';

class ReservationProvider with ChangeNotifier {
  bool _isLoading = false;
  List<String> _availableLockers = [];
  DateTime? _startDate;
  DateTime? _endDate;

  bool get isLoading => _isLoading;
  List<String> get availableLockers => _availableLockers;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  Future<void> fetchAvailableLockers() async {
    _isLoading = true;
    notifyListeners();
    try {
      _availableLockers = await ReservationService().fetchAvailableLockers();
    } catch (error) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> reserveLocker({
    required String userID,
    required String lockerID,
    required DateTime startDate,
    required DateTime endDate,
    required String userType,
  }) async {
    // Implement logic to handle different user types and booking expiration
    // For example, set different expiration times for students and visitors
    try {
      await ReservationService().createReservation(
        userID: userID,
        lockerID: lockerID,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (error) {
      // Handle error
    }
  }

  Future<void> selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      if (isStartDate) {
        _startDate = picked;
      } else {
        _endDate = picked;
      }
      notifyListeners();
    }
  }

  Future<void> approveReservation(String reservationID) async {
    try {
      await ReservationService().approveReservation(reservationID);
    } catch (error) {
      throw error;
    }
  }

  Future<void> declineReservation(String reservationID) async {
    try {
      await ReservationService().declineReservation(reservationID);
    } catch (error) {
      throw error;
    }
  }

  Future<void> cancelReservation(String reservationID) async {
    try {
      await ReservationService().cancelReservation(reservationID);
    } catch (error) {
      throw error;
    }
  }

  Future<List<Map<String, dynamic>>> fetchActiveReservations() async {
    try {
      return await ReservationService().fetchActiveReservations();
    } catch (error) {
      throw error;
    }
  }

  Future<void> autoCancelExpiredReservations() async {
    try {
      await ReservationService().autoCancelExpiredReservations();
    } catch (error) {
      // Handle error
    }
  }

  // Method to auto-cancel expired bookings
  void autoCancelExpiredBookings() {
    // Implement logic to check and cancel expired bookings
  }

  // Method to fetch active reservations
 
}
