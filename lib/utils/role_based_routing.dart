import 'package:flutter/material.dart';
import 'package:lms/screens/login_screen.dart';
import '../screens/admin_dashboard.dart';
import '../screens/student_dashboard.dart';
import '../screens/visitor_dashboard.dart';

Widget routeBasedOnRole(String role) {
  switch (role) {
    case 'admin':
      return AdminDashboard();
    case 'student':
      return StudentDashboard();
    case 'visitor':
      return VisitorDashboard();
    default:
      return LoginScreen();
  }
}
