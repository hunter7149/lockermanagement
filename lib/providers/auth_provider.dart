import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoggedIn = false;
  String _userRole = '';

  bool get isLoggedIn => _isLoggedIn;
  String get userRole => _userRole;

  Future<void> login(String email, String password) async {
    final user = await _authService.login(email, password);
    if (user != null) {
      _userRole = await _authService.getUserRole(user.uid);
      _isLoggedIn = true;
      notifyListeners();
    } else {
      throw Exception("Login failed");
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _isLoggedIn = false;
    _userRole = '';
    notifyListeners();
  }
}
