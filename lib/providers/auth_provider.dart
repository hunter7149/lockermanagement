import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Fetch user data from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userCredential.user!.uid).get();

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
}
