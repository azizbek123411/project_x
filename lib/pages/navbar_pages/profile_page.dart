import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_x/service/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth=AuthService();
  void logout()async{
    await _auth.logOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Page'),
        ),
        body: IconButton(onPressed: logout, icon: Icon(Icons.logout)),
    );
  }
}