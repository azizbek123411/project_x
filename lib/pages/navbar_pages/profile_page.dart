import 'package:flutter/material.dart';
import 'package:project_x/models/user.dart';
import 'package:project_x/service/auth/auth_service.dart';
import 'package:project_x/service/database/database_provider.dart';
import 'package:project_x/widgets/my_bio_box.dart';
import 'package:project_x/widgets/my_input_alert_box.dart';
import 'package:project_x/widgets/post_tile.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = TextEditingController();

  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);
  UserProfile? user;
  String currentUserid = AuthService().getCurrentUid();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  void showEditBioBox() {
    showDialog(
        context: context,
        builder: (context) {
          return MyInputAlertBox(
            controller: controller,
            hintTitle: 'Edit',
            onTap: updateBio,
            onPressedText: 'Save',
          );
        });
  }

  Future<void> updateBio() async {
    setState(() {
      isLoading = true;
    });
    await databaseProvider.updateUserBio(controller.text);
    await loadUsers();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> loadUsers() async {
    user = await databaseProvider.userProfile(currentUserid);
    setState(() {
      isLoading = false;
    });
  }

  final _auth = AuthService();
  void logout() async {
    await _auth.logOut();
  }

  @override
  Widget build(BuildContext context) {
    final filterPosts = listeningProvider.filterUserPosts(widget.uid);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
        title: Text(
          isLoading ? '...' : user!.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Center(
              child: Text(isLoading ? '...' : "@${user!.username}"),
            ),
            SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade900,
                radius: 70,
                child: Icon(Icons.person, size: 100),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Edit Bio'),
                IconButton(
                  onPressed: showEditBioBox,
                  icon: Icon(
                    Icons.edit,
                    size: 20,
                  ),
                ),
              ],
            ),
            MyBioBox(
              text: isLoading ? '...' : user!.bio,
            ),
            const SizedBox(height: 20),
            Row(children: [
              Text('${user!.name}\'s Posts'),
            ]),
            const SizedBox(width: 20),
            filterPosts.isEmpty
                ? Center(
                    child: Text('No posts available',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                : Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                      itemCount: filterPosts.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final post=filterPosts[index];
                        return PostTile(post: post, onUserTap: () {  },);
                      }),
                )
          ],
        ),
      ),
    );
  }
}
