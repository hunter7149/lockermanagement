import 'package:flutter/material.dart';
import 'package:lms/screens/student_dashboard.dart';
import 'package:lms/screens/visitor_dashboard.dart';
import '../screens/login_screen.dart';
import '../screens/admin_dashboard.dart';

class AppRoutes {
  static const login = '/';
  static const admin = '/admin';
  static const student = '/student';
  static const visitor = '/visitor';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => LoginScreen(),
    admin: (context) => AdminDashboard(),
    student: (context) => StudentDashboard(),
    visitor: (context) => VisitorDashboard(),
  };
}
