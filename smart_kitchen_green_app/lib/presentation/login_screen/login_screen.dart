import 'package:flutter/material.dart';
import 'package:smart_kitchen_green_app/widgets/custom_appbar.dart';
import 'package:smart_kitchen_green_app/widgets/custom_drawer.dart';

import '../../routes/routes.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      drawer: drawer(context),
      appBar: appBar("SignIn"),
      body:
          
      Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/b.jpg',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Column(children: [

              // Foreground content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Company Logo
                    SizedBox(height: 80,),

                    Image.asset(
                      'assets/logo/circle.png',
                      height: 200.0,
                    ),

                    SizedBox(height: 20),
                    // Username TextFormField
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text("user Name"),
                        hintText: 'Username',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Password TextFormField
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text("Password"),
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    // Login Button
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor,
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(vertical: 15.0),
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Implement your login logic here
                        },
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.login,size: 25,),

                            Text('Login',style: TextStyle(fontSize: 20),)],)



                    ),
                    SizedBox(height: 20,),
                    TextButton(

                        onPressed: (){

                          Navigator.pushNamed(context, AppRoutes.signUpScreen);
                        }, child:    RichText(

                        text: TextSpan(

                            style: TextStyle(fontSize: 16),

                            children: [
                              TextSpan(text: "If You have Not An Account"),
                              TextSpan(text: "   "),
                              TextSpan(text: "Register",style: TextStyle(fontWeight: FontWeight.bold))
                            ]))
                    )
                  ],
                ),
              ),
            ],),
          )
          // Background Image

        ],
      ),
    );
  }
}
