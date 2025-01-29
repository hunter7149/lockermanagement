import 'package:flutter/material.dart';
import 'package:lms/controller/report_controller.dart';
import 'package:lms/screens/report_screen.dart';
import 'package:lms/screens/user_management_screen.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        child: Column(
          children: [
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const AddReportScreen()),
            //     );
            //   },
            //   child: const Text('Add Report'),
            // ),
            // const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () async {
            //     String reportID = 'exampleReportID'; // Replace with dynamic ID
            //     // ReportController().navigateToReportScreen(context, reportID);
            //   },
            //   child: const Text('View Report'),
            // ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LockerManagementScreen()),
                );
              },
              child:Container(
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(color: Colors.teal.shade700,borderRadius: BorderRadius.circular(10)),
                  child: const Center(child: Text('Manage Lockers',style: TextStyle(color: Colors.white),))),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ReservationManagementScreen()),
                );
              },
              child: Container(
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(color: Colors.blue.shade700,borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text('Manage reservation',style: TextStyle(color: Colors.white),))),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  UserManagementScreen()),
                );
              },
              child:Container(
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(color: Colors.indigo.shade700,borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text('Manage user',style: TextStyle(color: Colors.white),))),
            ),
            // const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //       builder: (context) => const ReportGenerationScreen()),
            //     // );
            //   },
            //   child: const Text('Generate Reports'),
            // ),
          ],
        ),
      ),
    );
  }
}
