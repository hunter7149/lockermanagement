// import 'package:flutter/material.dart';
// import 'package:lms/services/report_service.dart';


// class ReportController {
//   final ReportService _reportService = ReportService();

//   Future<void> navigateToReportScreen(BuildContext context, String reportID) async {
//     try {
//       Map<String, dynamic> reportData = await _reportService.fetchReport(reportID);

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => addReportScreen(
//             totalReservations: reportData['totalReservations'],
//             lockerUsageRate: reportData['lockerUsageRate'],
//             adminID: reportData['adminID'],
//           ),
//         ),
//       );
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching report: $error')),
//       );
//     }
//   }
// }
