import 'package:flutter/material.dart';
import 'package:project_x/pages/auth_pages/login_page.dart';
import 'package:project_x/pages/auth_pages/register_page.dart';
import 'package:project_x/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
     darkTheme: ThemeData.dark(),
      home: RegisterPage(),
    );
  }
}

