import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> login(String email, String password) async {
    UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String username,
    required String role,
    String? phone,
  }) async {
    UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
    String userID = userCredential.user!.uid;

    await _firestore.collection('users').doc(userID).set({
      'username': username,
      'email': email,
      'phone': phone,
      'role': role,
      'status': 'active',
    });

    if (role == 'student') {
      await _firestore.collection('students').doc(userID).set({'userID': userID});
    } else if (role == 'visitor') {
      await _firestore.collection('visitors').doc(userID).set({'userID': userID});
    } else if (role == 'admin') {
      await _firestore.collection('admins').doc(userID).set({'userID': userID});
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<Map<String, dynamic>?> getUser(String userID) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userID).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      throw Exception("Failed to fetch user: $e");
    }
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      return await getUser(user.uid);
    }
    return null;
  }
}
