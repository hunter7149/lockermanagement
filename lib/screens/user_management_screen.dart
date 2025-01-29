import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'user_form_screen.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:   Colors.blue.withOpacity(0.4),
        title:  Text('User Management',),
        scrolledUnderElevation: 0,
        
      ),
      body: Container(
              decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.withOpacity(0.4),
              Colors.purple.withOpacity(0.5),
            ],
          ),
        ),
        child: FutureBuilder(
          future: Provider.of<AuthProvider>(context, listen: false).fetchAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading users'));
            } else {
              return Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: authProvider.users.length,
                          itemBuilder: (context, index) {
                            var user = authProvider.users[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  ListTile(
                                    
                                    tileColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                    title: Text(user['username']),
                                    subtitle: Text('Role: ${user['role']}'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserFormScreen(user: user)),
                                            );
                                          },
                                          child: Container(
                                            height: double.maxFinite,
                                            width: 60,
                                            color: Colors.grey.shade900,
                                            child: Icon(Icons.edit,color: Colors.white,),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            authProvider.removeUser(user['id']);
                                          },
                                          child: Container(
                                            height: double.maxFinite,
                                            width: 60,
                                            color: Colors.red.shade900.withOpacity(0.8),
                                            child: Icon(Icons.delete,color: Colors.white,),
                                          ),
                                        ),
                                        SizedBox(width: 20,)
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserFormScreen()),
                          );
                        },
                        child: Container(
                          height: 60,
                          width: double.maxFinite,
                          decoration: BoxDecoration(color: Colors.purple.shade700),
                          child: Center(child: Text('Add User', style: TextStyle(color: Colors.white))),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
