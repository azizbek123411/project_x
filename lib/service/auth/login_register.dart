import 'package:flutter/material.dart';
import 'package:project_x/pages/auth_pages/login_page.dart';
import 'package:project_x/pages/auth_pages/register_page.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  bool isLogin=true;
  void toggle(){
    setState(() {
      isLogin=!isLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(isLogin){
      return LoginPage(onTap: toggle,);
    }else{
      return RegisterPage(onTap: toggle,);
    }
  }
}