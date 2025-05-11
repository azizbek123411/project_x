import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/auth_fields.dart';
import '../../widgets/buttons.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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
              Icon(Icons.login, size: 100),
              Text(
                'Let\' create an account for you!!',
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap = widget.onTap,)
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}