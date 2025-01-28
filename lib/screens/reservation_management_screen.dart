import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation_provider.dart';

class ReservationManagementScreen extends StatelessWidget {
  const ReservationManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation Management'),
      ),
      body: Consumer<ReservationProvider>(
        builder: (context, reservationProvider, child) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: reservationProvider.fetchActiveReservations(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No active reservations'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> reservation = snapshot.data![index];
                    return ListTile(
                      title: Text('Reservation ${reservation['lockerID']}'),
                      subtitle: Text('User: ${reservation['userID']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: () {
                              reservationProvider
                                  .approveReservation(reservation['id']);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              reservationProvider
                                  .declineReservation(reservation['id']);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              reservationProvider
                                  .cancelReservation(reservation['id']);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
