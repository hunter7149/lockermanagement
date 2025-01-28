import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> addDummyData() async {
  try {
    // Adding Dummy Users
    await _addUserData(userId: 'gVPA6N1OZfU80mJ3yLJXlSIwaNP2', email: 'admin@admin.com', role: 'admin');
    await _addUserData(userId: 'untS73kxgceP3fZ9AkjhwXR8Vwv1', email: 'emonnatbd@gmail.com', role: 'student');
    await _addUserData(userId: 'Hi2rkVGykDT1mItWIgN0zNOcjdG2', email: 'visitor@visitor.com', role: 'visitor');

    // Adding Dummy Admin, Student, and Visitor Data
    await _addAdminData(adminId: 'gVPA6N1OZfU80mJ3yLJXlSIwaNP2');
    await _addStudentData(studentId: 'untS73kxgceP3fZ9AkjhwXR8Vwv1');
    await _addVisitorData(visitorId: 'Hi2rkVGykDT1mItWIgN0zNOcjdG2');

    // Adding Dummy Lockers, Buildings, Reservations, and Keys
    await _addBuildingData(buildingId: 'building1');
    await _addLockerData(lockerId: 'locker1', buildingId: 'building1');
    await _addReservationData(reservationId: 'reservation1', userId: 'gVPA6N1OZfU80mJ3yLJXlSIwaNP2', lockerId: 'locker1');
    await _addKeyData(keyId: 'key1', lockerId: 'locker1');

    // Adding Dummy Reports
    await _addReportData(reportId: 'report1', adminId: 'gVPA6N1OZfU80mJ3yLJXlSIwaNP2');

    print('Dummy data successfully added.');
  } catch (e) {
    print('Error adding dummy data: $e');
  }
}

// Add User Data (admin, student, visitor)
Future<void> _addUserData({
  required String userId,
  required String email,
  required String role,
}) async {
  try {
    await _firestore.collection('users').doc(userId).set({
      'userID': userId,
      'username': 'Dummy $role User',
      'email': email,
      'phone': 1234567890,
      'role': role,  // Enum for admin, student, visitor
      'status': 'active', // Enum for active, block, suspend
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    print('$role data added');
  } catch (e) {
    print('Error adding user data: $e');
  }
}

// Add Admin Data
Future<void> _addAdminData({required String adminId}) async {
  try {
    await _firestore.collection('admins').doc(adminId).set({
      'userID': adminId,
      'rolePermissions': 'manage_lockers, view_reports, manage_reservations',
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    print('Admin data added');
  } catch (e) {
    print('Error adding admin data: $e');
  }
}

// Add Student Data
Future<void> _addStudentData({required String studentId}) async {
  try {
    await _firestore.collection('students').doc(studentId).set({
      'userID': studentId,
      'graduationDate': DateTime(2025, 5, 20),
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    print('Student data added');
  } catch (e) {
    print('Error adding student data: $e');
  }
}

// Add Visitor Data
Future<void> _addVisitorData({required String visitorId}) async {
  try {
    await _firestore.collection('visitors').doc(visitorId).set({
      'userID': visitorId,
      'contactNumber': 9876543210,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    print('Visitor data added');
  } catch (e) {
    print('Error adding visitor data: $e');
  }
}

// Add Building Data
Future<void> _addBuildingData({required String buildingId}) async {
  try {
    await _firestore.collection('buildings').doc(buildingId).set({
      'name': 'Dummy Building',
      'location': 'Campus Center',
      'total_locker': 50,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    print('Building data added');
  } catch (e) {
    print('Error adding building data: $e');
  }
}

// Add Locker Data
Future<void> _addLockerData({required String lockerId, required String buildingId}) async {
  try {
    await _firestore.collection('lockers').doc(lockerId).set({
      'buildingID': buildingId,
      'location': 'Ground Floor',
      'status': 'available',  // Enum for available, reserved, overdue
      'type': 'permanent',  // Enum for temporary, permanent
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    print('Locker data added');
  } catch (e) {
    print('Error adding locker data: $e');
  }
}

// Add Reservation Data
Future<void> _addReservationData({
  required String reservationId,
  required String userId,
  required String lockerId,
}) async {
  try {
    await _firestore.collection('reservations').doc(reservationId).set({
      'startDate': DateTime.now(),
      'endDate': DateTime.now().add(Duration(days: 7)),
      'lockerID': lockerId,
      'userID': userId,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    print('Reservation data added');
  } catch (e) {
    print('Error adding reservation data: $e');
  }
}

// Add Key Data
Future<void> _addKeyData({required String keyId, required String lockerId}) async {
  try {
    await _firestore.collection('keys').doc(keyId).set({
      'lockerID': lockerId,
      'status': 'available', // Enum for available, assigned, lost
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    print('Key data added');
  } catch (e) {
    print('Error adding key data: $e');
  }
}

// Add Report Data
Future<void> _addReportData({required String reportId, required String adminId}) async {
  try {
    await _firestore.collection('reports').doc(reportId).set({
      'totalReservations': 10,
      'lockerUsageRate': 0.8,  // Example: 80% usage
      'generationDate': FieldValue.serverTimestamp(),
      'adminID': adminId,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    print('Report data added');
  } catch (e) {
    print('Error adding report data: $e');
  }
}
