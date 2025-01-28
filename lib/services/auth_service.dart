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
    // Replace with actual Firebase Firestore query to fetch user role
    return "Admin"; // For demonstration purposes
  }
}
