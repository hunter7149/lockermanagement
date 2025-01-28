import 'package:flutter/material.dart';
import 'package:lms/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../providers/reservation_provider.dart';

class ReservationScreen extends StatefulWidget {
  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  String? _selectedLockerID;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReservationProvider>(context, listen: false)
          .fetchAvailableLockers();
    });
  }

  @override
  Widget build(BuildContext context) {
    var reservationProvider = Provider.of<ReservationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Reserve a Locker')),
      body: reservationProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedLockerID,
                    hint: Text('Select Locker ID'),
                    items: reservationProvider.availableLockers.map((lockerID) {
                      return DropdownMenuItem<String>(
                        value: lockerID,
                        child: Text(lockerID),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedLockerID = value;
                      });
                    },
                  ),
                  TextField(
                    controller: TextEditingController(
                      text: reservationProvider.startDate
                              ?.toIso8601String()
                              .split('T')
                              .first ??
                          '',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () =>
                            reservationProvider.selectDate(context, true),
                      ),
                    ),
                    readOnly: true,
                  ),
                  TextField(
                    controller: TextEditingController(
                      text: reservationProvider.endDate
                              ?.toIso8601String()
                              .split('T')
                              .first ??
                          '',
                    ),
                    decoration: InputDecoration(
                      labelText: 'End Date',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () =>
                            reservationProvider.selectDate(context, false),
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_selectedLockerID == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please select a locker ID')),
                        );
                        return;
                      }

                      if (reservationProvider.startDate == null ||
                          reservationProvider.endDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Please select start and end dates')),
                        );
                        return;
                      }
                      var auth =
                          Provider.of<AuthProvider>(context, listen: false);

                      await reservationProvider.reserveLocker(
                        userID: auth.getUserId()!,
                        lockerID: _selectedLockerID!,
                        startDate: reservationProvider.startDate!,
                        endDate: reservationProvider.endDate!,
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
