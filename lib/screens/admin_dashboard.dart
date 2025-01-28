import 'package:flutter/material.dart';
import 'package:lms/controller/report_controller.dart';
import 'package:lms/screens/report_screen.dart';
import 'locker_management_screen.dart';
import 'reservation_management_screen.dart';
// import 'user_management_screen.dart';
// import 'report_generation_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddReportScreen()),
                );
              },
              child: const Text('Add Report'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String reportID = 'exampleReportID'; // Replace with dynamic ID
                // ReportController().navigateToReportScreen(context, reportID);
              },
              child: const Text('View Report'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LockerManagementScreen()),
                );
              },
              child: const Text('Manage Lockers'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ReservationManagementScreen()),
                );
              },
              child: const Text('Manage Reservations'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const UserManagementScreen()),
                // );
              },
              child: const Text('Manage Users'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const ReportGenerationScreen()),
                // );
              },
              child: const Text('Generate Reports'),
            ),
          ],
        ),
      ),
    );
  }
}
