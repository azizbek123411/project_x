import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_x/firebase_options.dart';
import 'package:project_x/service/auth/auth_gate.dart';
import 'package:project_x/service/database/database_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => DatabaseProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/':(context)=>const AuthGate(),
      },
    );
  }
}
