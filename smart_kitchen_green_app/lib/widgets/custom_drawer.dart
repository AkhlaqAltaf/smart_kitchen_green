import 'package:flutter/material.dart';
import 'package:smart_kitchen_green_app/routes/routes.dart';

Drawer drawer(BuildContext context) {

  bool isLogin = false;
  return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Expanded(
            child: DrawerHeader(
              curve: Curves.easeIn,
              decoration: BoxDecoration(
                  // color: Color.fromARGB(255, 0, 0, 0),
                  ),
              child: Image(
                image: AssetImage('assets/logo/logo1.png'),
                height: 200,
                width: 200,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.home, size: 24),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.homeScreen);
                    // downloadInvitationCard(context, 4);
                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.list,
                    size: 24,
                  ),
                  title: const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    // Navigator.pop(context);
                    // Navigator.pushNamed(context, SettingsScreen.routeName);
                  },
                ),



                isLogin?
                ListTile(
                  leading: const RotationTransition(
                    turns: AlwaysStoppedAnimation(180 / 360),
                    child: Icon(
                      Icons.logout,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text('Would you like to logout?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Logout'),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.loginScreen);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ):ListTile(leading: const Icon(
                  Icons.login,
                  size: 24,
                ),
                  title: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.loginScreen);
                  },),
              ],
            ),
          )
        ],
      ));
}
