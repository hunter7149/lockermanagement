import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/locker.dart';

class LockerService {

Future<List<Locker>> getLockers() async {
  try {
    // Fetch all the documents from the lockers collection
    QuerySnapshot lockerSnapshot = await FirebaseFirestore.instance.collection('lockers').get();

    // Map the documents to a list of Locker objects
    List<Locker> lockers = lockerSnapshot.docs.map((doc) {
      return Locker(
        id: doc.id, // Document ID is used as locker id
        status: doc.get('status'), // Access the 'status' field from the document
      );
    }).toList();

    return lockers; // Return the list of Locker objects
  } catch (e) {
    // Handle any errors that occur during the query
    print("Error fetching lockers: $e");
    return []; // Return an empty list if an error occurs
  }
}

Future<void> updateLockerStatus(String lockerId, String status) async {
  try {
    // Reference to the Firestore document for the specified locker
    DocumentReference lockerDoc = FirebaseFirestore.instance.collection('lockers').doc(lockerId);

    // Update the 'status' field of the specified document
    await lockerDoc.update({'status': status});
    print("Locker $lockerId updated successfully to status: $status");
  } catch (e) {
    // Handle any errors that occur during the update
    print("Error updating locker status: $e");
    throw e; // Optional: rethrow the error if you need to handle it elsewhere
  }
}

}
