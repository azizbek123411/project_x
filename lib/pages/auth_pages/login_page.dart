import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_x/service/auth_service.dart';
import 'package:project_x/widgets/auth_fields.dart';
import 'package:project_x/widgets/buttons.dart';
import 'package:project_x/widgets/loading_circle.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = AuthService();

  void login() async {
ShowLoadingCircle(context);

    try {
      await _auth.loginEmailPassword(
          emailController.text, passwordController.text);


          if(mounted) hideLoadingCircle(context);
    } catch (e, st) {
      log("Error:$e, StackTrace:$st");
      if(mounted) hideLoadingCircle(context);
       ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.toString(),
              ),
            ),
          );
    }
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.lock, size: 100),
              Text(
                'Welcome back!!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              AuthFields(
                hintText: 'Email',
                controller: emailController,
              ),
              AuthFields(
                hintText: 'Password',
                controller: passwordController,
              ),
              SizedBox(
                height: 20,
              ),
              Buttons(
                  text: 'Login',
                  onTap: () {
                    login();
                    log('message');
                  }),
              SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                      text: "Don't have an acount?",
                      style: TextStyle(fontSize: 15),
                      children: [
                    TextSpan(
                        text: '  Sign Up',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onTap),
                  ],),),
            ],
          ),
        ),
      ),
    );
  }
}
