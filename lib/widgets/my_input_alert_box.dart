import 'package:flutter/material.dart';

class MyInputAlertBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintTitle;
  final void Function()? onTap;
  final String onPressedText;
  const MyInputAlertBox({
    super.key,
    required this.controller,
    required this.hintTitle,
    required this.onTap,
    required this.onPressedText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            controller.clear();
          },
          child: Text(
            'Cancel',
          ),
        ),
         TextButton(
          onPressed: () {
           
            Navigator.pop(context);
            onTap!();
          },
          child: Text(
            onPressedText,
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: TextField(
        controller: controller,
        maxLength: 120,
        maxLines: 3,
        decoration:
            InputDecoration(hintText: hintTitle, border: OutlineInputBorder()),
      ),
    );
  }
}
