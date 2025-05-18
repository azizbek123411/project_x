import 'package:flutter/material.dart';
import 'package:project_x/helper/navigation.dart';
import 'package:project_x/service/database/database_provider.dart';
import 'package:project_x/widgets/my_input_alert_box.dart';
import 'package:project_x/widgets/post_tile.dart';
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
              controller.clear();
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
    final posts = listeningProvider.getAllPosts;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: posts.isEmpty
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
                return PostTile(
                  post: post,
                  onUserTap: () => goUserProfile(
                    context,
                    post.uid,
                  ),
                  onPostTap: () => goToPostPage(
                    context,
                    post,
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: _openMessageBox,
        child: Icon(Icons.add),
      ),
    );
  }
}
