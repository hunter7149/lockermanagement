import 'package:cloud_firestore/cloud_firestore.dart';

class ReportService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch a specific report by its ID
  Future<Map<String, dynamic>> fetchReport(String reportID) async {
    DocumentSnapshot doc =
        await _firestore.collection('reports').doc(reportID).get();

    if (!doc.exists) {
      throw Exception('Report not found');
    }

    return doc.data() as Map<String, dynamic>;
  }

  // Add a new report to Firestore
  Future<void> createReport({
    required int totalReservations,
    required double lockerUsageRate,
    required String adminID,
  }) async {
    await _firestore.collection('reports').add({
      'totalReservations': totalReservations,
      'lockerUsageRate': lockerUsageRate,
      'generationDate': DateTime.now(),
      'adminID': adminID,
    });
  }
}
