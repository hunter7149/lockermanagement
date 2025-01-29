import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class UserFormScreen extends StatefulWidget {
  final Map<String, dynamic>? user;

  UserFormScreen({this.user});

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _role;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _emailController.text = widget.user!['email'];
      _nameController.text = widget.user!['username'];
      _role = widget.user!['role'];
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Add User' : 'Edit User'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 60,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: InputBorder.none, labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              if (widget.user == null)
                Container(
                  height: 60,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: InputBorder.none, labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                ),
              SizedBox(height: 20),
              Container(
                height: 60,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 60,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonFormField<String>(
                  value: _role,
                  decoration: InputDecoration(
                      border: InputBorder.none, labelText: 'Role'),
                  items: ['student', 'visitor']
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _role = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a role';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.user == null) {
                      // Add new user
                      await authProvider.addUser(
                        email: _emailController.text,
                        password: _passwordController.text,
                        name: _nameController.text,
                        role: _role!,
                      );
                    } else {
                      // Update existing user
                      await authProvider.updateUser(
                        userID: widget.user!['id'],
                        data: {
                          'email': _emailController.text,
                          'name': _nameController.text,
                          'role': _role!,
                          'updated_at': Timestamp.now(),
                        },
                      );
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.user == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
