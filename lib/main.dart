import 'package:flutter/material.dart';
import 'package:project_x/pages/navbar_pages/home_page.dart';

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
      home: HomePage(),
    );
  }
}

