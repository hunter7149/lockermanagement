import 'package:flutter/material.dart';
import 'package:lms/services/report_service.dart';


class AddReportScreen extends StatefulWidget {
  const AddReportScreen({Key? key}) : super(key: key);

  @override
  _AddReportScreenState createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  final TextEditingController _totalReservationsController =
      TextEditingController();
  final TextEditingController _lockerUsageRateController =
      TextEditingController();

  final ReportService _reportService = ReportService();

  @override
  void dispose() {
    _totalReservationsController.dispose();
    _lockerUsageRateController.dispose();
    super.dispose();
  }

  void _createReport() async {
    try {
      int totalReservations = int.parse(_totalReservationsController.text.trim());
      double lockerUsageRate =
          double.parse(_lockerUsageRateController.text.trim()) / 100;
      String adminID = 'exampleAdminID'; // Replace with actual admin ID

      await _reportService.createReport(
        totalReservations: totalReservations,
        lockerUsageRate: lockerUsageRate,
        adminID: adminID,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report created successfully!')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create report: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _totalReservationsController,
              decoration: const InputDecoration(
                labelText: 'Total Reservations',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lockerUsageRateController,
              decoration: const InputDecoration(
                labelText: 'Locker Usage Rate (%)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createReport,
              child: const Text('Create Report'),
            ),
          ],
        ),
      ),
    );
  }
}
