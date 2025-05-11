import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_x/service/auth_service.dart';
import 'package:project_x/widgets/loading_circle.dart';

import '../../widgets/auth_fields.dart';
import '../../widgets/buttons.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = AuthService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void register() async {
    if (passwordController.text == confirmPasswordController.text) {
      ShowLoadingCircle(context);
      try {
        await _auth.registerEmailPassword(
            emailController.text, passwordController.text);
        if (mounted) hideLoadingCircle(context);
      } catch (e, st) {
        log("Error:$e,StackTrace:$st");
        if (mounted) hideLoadingCircle(context);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.toString(),
              ),
            ),
          );
        }
      }
    }else{
       ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
               "Password do not match"
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SizedBox(
          width: double.infinity,
          height:double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
             
                children: [
                  Icon(Icons.login, size: 100),
                  Text(
                    'Let\' create an account for you!!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  AuthFields(
                    hintText: 'Name',
                    controller: nameController,
                  ),
                  AuthFields(
                    hintText: 'Email',
                    controller: emailController,
                  ),
                  AuthFields(
                    hintText: 'Password',
                    controller: passwordController,
                  ),
                  AuthFields(
                    hintText: 'Confirm password',
                    controller: confirmPasswordController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Buttons(
                      text: 'Sign Up',
                      onTap: () {
                        register();
                        log('message');
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Already have account?",
                          style: TextStyle(fontSize: 15),
                          children: [
                        TextSpan(
                          text: '  Login',
                          style:
                              TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()..onTap = widget.onTap,
                        )
                      ]),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
