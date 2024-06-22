import 'package:flutter/material.dart';
import 'package:smart_kitchen_green_app/apis/auth_apis/signin_api.dart';
import 'package:smart_kitchen_green_app/data_layer/auth/auth_model.dart';
import 'package:smart_kitchen_green_app/presentation/verification/verification.dart';
import 'package:smart_kitchen_green_app/widgets/custom_appbar.dart';
import 'package:smart_kitchen_green_app/widgets/custom_drawer.dart';
import '../../routes/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool isVisibale = false;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image.asset(
          //   'assets/images/b.jpg',
          //   fit: BoxFit.cover,
          // ),
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
                                    isVisibale = !isVisibale;
                                  });
                                },
                                icon: Icon(isVisibale
                                    ? Icons.visibility_off
                                    : Icons.visibility))),
                        obscureText: !isVisibale,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () async {
                            Auth model = Auth(
                                email: emailController!.text,
                                password: passwordController!.text);

                            await signInUser(model, context);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.login,
                                size: 25,
                              ),
                              Text(
                                'Login',
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Verification(),
                                ));

                            // Navigator.pushNamed(
                            //     context, AppRoutes.signUpScreen);
                          },
                          child: RichText(
                              text: TextSpan(
                                  style: TextStyle(fontSize: 16),
                                  children: [
                                TextSpan(
                                    text: "If You have Not An Account",
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(text: "   "),
                                TextSpan(
                                    text: "Register",
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

























// OPTIONAL TEXTBUTTON 







      //  TextButton(
      //                     style: ButtonStyle(
      //                       backgroundColor: MaterialStateProperty.all<Color>(
      //                         Theme.of(context).primaryColor,
      //                       ),
      //                       foregroundColor: MaterialStateProperty.all<Color>(
      //                         Colors.white,
      //                       ),
      //                       padding: MaterialStateProperty.all<EdgeInsets>(
      //                         EdgeInsets.symmetric(vertical: 15.0),
      //                       ),
      //                       shape: MaterialStateProperty.all<
      //                           RoundedRectangleBorder>(
      //                         RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(10.0),
      //                         ),
      //                       ),
      //                     ),
      //                     onPressed: () async {
      //                       Auth model = Auth(
      //                           email: emailController!.text,
      //                           password: passwordController!.text);

      //                       await signInUser(model, context);
      //                     },
      //                     child: Row(
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         Icon(
      //                           Icons.login,
      //                           size: 25,
      //                         ),
      //                         Text(
      //                           'Login',
      //                           style: TextStyle(fontSize: 20),
      //                         )
      //                       ],
      //                     )),