import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/role_based_routing.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(0.4),
              Colors.purple.withOpacity(0.5),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Container(
                child:Icon(Icons.dashboard,size: 200,color: Colors.white,),
              ),
              SizedBox(height: 40,),
             CustomTextField(
                            hintText     : 'Email',
                            controller   : _emailController,
                            keyboardType  : TextInputType.emailAddress,
                            onChanged     : (value) {},
                            obscureText   : false), 
              SizedBox(height: 20,),
         CustomTextField(hintText: "Password", controller: _passwordController, onChanged:(value){},obscureText: true,)
         ,
         
            SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  String email = _emailController.text.trim();
                  String password = _passwordController.text.trim();
        
                  var authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  try {
                    String role = await authProvider.login(email, password);
        
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => routeBasedOnRole(role),
                      ),
                    );
                  } catch (e) {
                    // Handle login error (e.g., show a snackbar or alert dialog)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(color: Colors.purple,borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 16),))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
