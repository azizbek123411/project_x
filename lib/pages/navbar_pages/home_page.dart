import 'package:flutter/material.dart';
import 'package:project_x/widgets/my_input_alert_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final controller=TextEditingController();


  void _openMessageBox() {
    showDialog(
        context: context,
        builder: (context) {
          return 
             MyInputAlertBox(
              controller: controller,
              hintTitle: 'New Post',
              onTap: (){},
              onPressedText: 'Post',
            );
        
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openMessageBox,
        child: Icon(Icons.add),
      ),
    );
  }
}
