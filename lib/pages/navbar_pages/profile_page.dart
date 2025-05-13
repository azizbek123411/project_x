

import 'package:flutter/material.dart';
import 'package:project_x/service/auth/auth_service.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key,required this.uid});

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
          title: const Text('Profile',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        ),
        body:Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person,size: 100,),
              Text(widget.uid,)
            ],
          )
        )
    );
  }
}