import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      throw Exception("Authentication failed: $e");
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }


Future<String> getUserRole(String uid) async {
  try {
    // Fetch the document for the user with the given UID
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    // Check if the document exists
    if (userDoc.exists) {
      // Get the role field from the document
      String role = userDoc.get('role');
      return role; // Return the role
    } else {
      return 'Not found'; // Return if the document doesn't exist
    }
  } catch (e) {
    // Handle any errors that occur during the query
    return 'Error: $e';
  }
}
}
