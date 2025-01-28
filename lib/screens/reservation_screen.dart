import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation_provider.dart';

class ReservationScreen extends StatelessWidget {
  final TextEditingController _lockerIDController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var reservationProvider = Provider.of<ReservationProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Reserve a Locker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _lockerIDController,
              decoration: InputDecoration(labelText: 'Locker ID'),
            ),
            TextField(
              controller: _startDateController,
              decoration: InputDecoration(labelText: 'Start Date (YYYY-MM-DD)'),
            ),
            TextField(
              controller: _endDateController,
              decoration: InputDecoration(labelText: 'End Date (YYYY-MM-DD)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String lockerID = _lockerIDController.text.trim();
                String startDate = _startDateController.text.trim();
                String endDate = _endDateController.text.trim();

                await reservationProvider.reserveLocker(
                  lockerID: lockerID,
                  startDate: DateTime.parse(startDate),
                  endDate: DateTime.parse(endDate),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Reservation successful')),
                );
                Navigator.pop(context);
              },
              child: Text('Reserve'),
            ),
          ],
        ),
      ),
    );
  }
}
