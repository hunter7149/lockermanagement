import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> login(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String username,
    required String role,
    String? phone,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    String userID = userCredential.user!.uid;

    await _firestore.collection('users').doc(userID).set({
      'username': username,
      'email': email,
      'phone': phone,
      'role': role,
      'status': 'active',
    });

    if (role == 'student') {
      await _firestore
          .collection('students')
          .doc(userID)
          .set({'userID': userID});
    } else if (role == 'visitor') {
      await _firestore
          .collection('visitors')
          .doc(userID)
          .set({'userID': userID});
    } else if (role == 'admin') {
      await _firestore.collection('admins').doc(userID).set({'userID': userID});
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<Map<String, dynamic>?> getUser(String userID) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userID).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      throw Exception("Failed to fetch user: $e");
    }
  }
  Future<String> getUserType(String userID) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userID).get();
      if (doc.exists) {
        return doc['role'];
      }
      else {
        return "User not found";
      }
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

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (error) {
      throw error;
    }
  }

  Future<void> removeUser(String userID) async {
    try {
      await _firestore.collection('users').doc(userID).delete();
    } catch (error) {
      throw error;
    }
  }

  Future<void> sendNotification(String userID, String message) async {
    try {
      await _firestore
          .collection('users')
          .doc(userID)
          .collection('notifications')
          .add({
        'message': message,
        'timestamp': DateTime.now(),
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> addUser(String email, String password, String name, String role) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String userID = userCredential.user!.uid;
    Timestamp timestamp = Timestamp.now();

    await _firestore.collection('users').doc(userID).set({
      'email': email,
      'name': name,
      'role': role,
      'phone': '1234567890', // Default phone number
      'created_at': timestamp,
      'updated_at': timestamp,
      'status': 'active',
      'userID': userID,
      'username': name, // Default username
    });
  }

  Future<void> updateUser(String userID, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(userID).update(data);
  }
}
