import 'package:flutter/material.dart';
import 'package:project_x/service/database/database_provider.dart';
import 'package:project_x/widgets/my_input_alert_box.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  void _openMessageBox() {
    showDialog(
        context: context,
        builder: (context) {
          return MyInputAlertBox(
            controller: controller,
            hintTitle: 'New Post',
            onTap: () async {
              await postMessage(controller.text);
            },
            onPressedText: 'Post',
          );
        });
  }

  Future<void> postMessage(String message) async {
    await databaseProvider.postMessage(message);
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
