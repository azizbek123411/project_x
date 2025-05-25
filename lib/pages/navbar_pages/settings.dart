import 'package:flutter/material.dart';
import 'package:project_x/helper/navigation.dart';
import 'package:project_x/widgets/settings_tile.dart';

import '../../service/auth/auth_service.dart';
import '../inner_pages/blokedusers_page.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {





  void _showLogOutBox() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Log Out'),
            content: Text('Are your sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: ()  {
                logout();
                pop(context);
                },
                child: Text('Logout'),
              ),
            ],
          );
        });
  }
    final _auth = AuthService();
  void logout() async {
    await _auth.logOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
         SettingsTile(text: 'Logout',onTap:_showLogOutBox, 
          ) ,
          SettingsTile(
            text:"Blocked Users",
            onTap: ()=>pushPage(context, BlokedusersPage(),),
          ),
        ],
      ),
    );
  }
}