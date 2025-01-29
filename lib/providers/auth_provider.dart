import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _users = [];
  String? _userType;

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

  Future<void> addUser({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    try {
      await AuthService().addUser(email, password, name, role);
      fetchAllUsers();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateUser({
    required String userID,
    required Map<String, dynamic> data,
  }) async {
    try {
      await AuthService().updateUser(userID, data);
      fetchAllUsers();
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

  Future<String?> getUserType() async {
    try {
      String userId = getUserId()!;
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        _userType = userDoc['role'];
        return _userType;
      } else {
        throw Exception("User data not found!");
      }
    } catch (e) {
      throw Exception("Failed to get user type: $e");
    }
  }

  // Method to set user type (e.g., during login)
  void setUserType(String userType) {
    _userType = userType;
    notifyListeners();
  }
}
