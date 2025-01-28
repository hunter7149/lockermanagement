import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationService {
  final CollectionReference _reservationCollection =
      FirebaseFirestore.instance.collection('reservations');

  Future<void> createReservation({
    required String lockerID,
    required DateTime startDate,
    required DateTime endDate,
    required String userID,
  }) async {
    try {
      await _reservationCollection.add({
        'lockerID': lockerID,
        'startDate': startDate,
        'endDate': endDate,
        'userID': userID,
        'status': 'reserved',
      });
      await FirebaseFirestore.instance
          .collection('lockers')
          .doc(lockerID)
          .update({'status': 'reserved'});
    } catch (error) {
      throw error;
    }
  }

  Future<List<String>> fetchAvailableLockers() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('lockers')
          .where('status', isEqualTo: 'available')
          .get();
      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (error) {
      throw error;
    }
  }

  Future<void> approveReservation(String reservationID) async {
    try {
      await _reservationCollection
          .doc(reservationID)
          .update({'status': 'approved'});
    } catch (error) {
      throw error;
    }
  }

  Future<void> declineReservation(String reservationID) async {
    try {
      await _reservationCollection
          .doc(reservationID)
          .update({'status': 'declined'});
    } catch (error) {
      throw error;
    }
  }

  Future<void> cancelReservation(String reservationID) async {
    try {
      await _reservationCollection.doc(reservationID).delete();
    } catch (error) {
      throw error;
    }
  }

  Future<List<Map<String, dynamic>>> fetchActiveReservations() async {
    try {
      QuerySnapshot snapshot = await _reservationCollection
          .where('status', isEqualTo: 'approved')
          .get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (error) {
      throw error;
    }
  }
}
