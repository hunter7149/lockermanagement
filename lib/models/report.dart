import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String id;
  final int totalReservations;
  final double lockerUsageRate;
  final DateTime generationDate;
  final String adminID;

  Report({
    required this.id,
    required this.totalReservations,
    required this.lockerUsageRate,
    required this.generationDate,
    required this.adminID,
  });

  factory Report.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Report(
      id: doc.id,
      totalReservations: data['totalReservations'] ?? 0,
      lockerUsageRate: (data['lockerUsageRate'] as num).toDouble(),
      generationDate: (data['generationDate'] as Timestamp).toDate(),
      adminID: data['adminID'] ?? '',
    );
  }
}
