import 'package:flutter/material.dart';
import 'package:project_x/service/database/database_provider.dart';
import 'package:project_x/widgets/my_input_alert_box.dart';
import 'package:provider/provider.dart';

import '../../models/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  late final listeningProvider = Provider.of<DatabaseProvider>(context);

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
  void initState() {
    super.initState();

    loadAllPosts();
  }

  Future<void> loadAllPosts() async {
    await databaseProvider.loadAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: buildPostList(listeningProvider.getAllPosts),
      floatingActionButton: FloatingActionButton(
        onPressed: _openMessageBox,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildPostList(List<Post> posts) {
    return posts.isEmpty
        ? Center(
            child: Text(
              'No posts available',
              style: TextStyle(fontSize: 18),
            ),
          )
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8,bottom: 4),
                    child: Text(post.message,style: TextStyle(fontSize: 18),),
                  ),
                  Divider(),
                ],
              );
            });
  }
}
