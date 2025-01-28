import 'package:cloud_firestore/cloud_firestore.dart';

class Locker {
  final String id;
  final String location;
  final String status;
  final String type;

  Locker({
    required this.id,
    required this.location,
    required this.status,
    required this.type,
  });

  factory Locker.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Locker(
      id: doc.id,
      location: data['location'] ?? '',
      status: data['status'] ?? '',
      type: data['type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location': location,
      'status': status,
      'type': type,
    };
  }
}
