import 'package:flutter/material.dart';

class AuthFields extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const AuthFields({super.key,required this.hintText,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextField(
        controller:controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}