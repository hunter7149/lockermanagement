import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationService {
  final CollectionReference _reservationCollection =
      FirebaseFirestore.instance.collection('reservations');

  Future<void> createReservation({
    required String lockerID,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      await _reservationCollection.add({
        'lockerID': lockerID,
        'startDate': startDate,
        'endDate': endDate,
        'status': 'reserved',
      });
    } catch (error) {
      throw error;
    }
  }
}
