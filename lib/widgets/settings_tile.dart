import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const SettingsTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(text,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
