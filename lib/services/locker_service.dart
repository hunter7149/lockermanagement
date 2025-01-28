import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/locker.dart';

class LockerService {
  final CollectionReference _lockerCollection =
      FirebaseFirestore.instance.collection('lockers');

  Future<List<Locker>> getLockers() async {
    try {
      QuerySnapshot snapshot = await _lockerCollection.get();
      return snapshot.docs.map((doc) => Locker.fromFirestore(doc)).toList();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addLocker(Locker locker) async {
    try {
      await _lockerCollection.add(locker.toMap());
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateLocker(String lockerID, Map<String, dynamic> data) async {
    try {
      await _lockerCollection.doc(lockerID).update(data);
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteLocker(String lockerID) async {
    try {
      await _lockerCollection.doc(lockerID).delete();
    } catch (error) {
      throw error;
    }
  }
}
