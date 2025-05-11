import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_x/pages/main_page.dart';
import 'package:project_x/pages/navbar_pages/home_page.dart';
import 'package:project_x/service/auth/login_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snapshot){
        if(snapshot.hasData){
          return MainPage();
        }else{
          return LoginRegister();
        }
      }),
    );
  }
}