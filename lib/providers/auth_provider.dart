import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _users = [];

  List<Map<String, dynamic>> get users => _users;

  Future<void> fetchAllUsers() async {
    try {
      _users = await AuthService().getAllUsers();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> removeUser(String userID) async {
    try {
      await AuthService().removeUser(userID);
      fetchAllUsers();
    } catch (error) {
      throw error;
    }
  }

  Future<void> sendNotification(String userID, String message) async {
    try {
      await AuthService().sendNotification(userID, message);
    } catch (error) {
      throw error;
    }
  }

  Future<String> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        String role = userDoc['role'];
        return role; // Return the role to use in your UI
      } else {
        throw Exception("User data not found!");
      }
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  String? getUserId() {
    return _auth.currentUser?.uid;
  }
}
