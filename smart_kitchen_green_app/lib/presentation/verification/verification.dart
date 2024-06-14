import 'package:flutter/material.dart';
import 'package:smart_kitchen_green_app/apis/auth_apis/email_verification_api.dart';
import 'package:smart_kitchen_green_app/data_layer/auth/verification_model.dart';
import 'package:smart_kitchen_green_app/storage/auth_storage.dart';
import 'package:smart_kitchen_green_app/widgets/custom_appbar.dart';
import 'package:smart_kitchen_green_app/widgets/custom_drawer.dart';
import '../../routes/routes.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  TextEditingController? emailController;
  TextEditingController? code;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    code = TextEditingController();
    userEmail();
  }

  void userEmail() async {
    emailController!.text = (await getUserEmail())!;
  }

  @override
  void dispose() {
    super.dispose();
    emailController!.dispose();
    code!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: appBar("Verification"),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/b.jpg',
            fit: BoxFit.cover,
          ),
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
                          enabled: false,
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
                        controller: code,
                        decoration: InputDecoration(
                          label: Text("Verification Code"),
                          hintText: '4 Digit Code',
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            EmailVerification verificationModel =
                                EmailVerification(
                                    email: emailController!.text,
                                    code: code!.text);
                            await verifEmail(verificationModel, context);
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
                                'Verify',
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
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
