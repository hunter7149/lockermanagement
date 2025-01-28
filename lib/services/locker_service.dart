import '../models/locker.dart';

class LockerService {
  Future<List<Locker>> getLockers() async {
    // Replace with actual Firebase Firestore logic to fetch lockers
    return [
      Locker(id: "1", status: "Available"),
      Locker(id: "2", status: "Booked"),
    ];
  }

  Future<void> updateLockerStatus(String lockerId, String status) async {
    // Replace with actual Firebase Firestore update logic
  }
}
