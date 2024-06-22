import 'package:flutter/material.dart';
import 'package:smart_kitchen_green_app/apis/auth_apis/register_api.dart';
import 'package:smart_kitchen_green_app/data_layer/auth/auth_model.dart';
import 'package:smart_kitchen_green_app/widgets/custom_appbar.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_drawer.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool isVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: drawer(context),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Foreground content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Company Logo
                      SizedBox(
                        height: 80,
                      ),

                      Image.asset(
                        'assets/logo/circle.png',
                        height: 200.0,
                      ),

                      SizedBox(height: 20),
                      // Username TextFormField
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            label: Text("Email"),
                            prefixIcon: Icon(Icons.email)),
                      ),
                      SizedBox(height: 20),
                      // Password TextFormField
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            label: Text("Password"),
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(isVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility))),
                        obscureText: !isVisible,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () async {
                            Auth auth = Auth(
                                email: emailController!.text,
                                password: passwordController!.text);
                            await registerUser(auth, context);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.app_registration,
                                size: 25,
                              ),
                              Text(
                                'Register',
                              )
                            ],
                          )),
                      // Login Button

                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, AppRoutes.loginScreen);
                          },
                          child: RichText(
                              text: TextSpan(
                                  style: TextStyle(fontSize: 16),
                                  children: [
                                TextSpan(
                                    text: "If You have An Account",
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(text: "   "),
                                TextSpan(
                                    text: "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))
                              ])))
                    ],
                  ),
                ),
              ],
            ),
          )
          // Background Image
        ],
      ),
    );
  }
}






















// OPTIONAL 


//                       TextButton(
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                               Theme.of(context).primaryColor,
//                             ),
//                             foregroundColor: MaterialStateProperty.all<Color>(
//                               Colors.white,
//                             ),
//                             padding: MaterialStateProperty.all<EdgeInsets>(
//                               EdgeInsets.symmetric(vertical: 15.0),
//                             ),
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                             ),
//                           ),
//                           onPressed: () async {
//                             Auth auth = Auth(
//                                 email: emailController!.text,
//                                 password: passwordController!.text);
//                             await registerUser(auth, context);
//                           },
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.app_registration,
//                                 size: 25,
//                               ),
//                               Text(
//                                 'Register',
//                                 style: TextStyle(fontSize: 20),
//                               )
//                             ],
//                           )),