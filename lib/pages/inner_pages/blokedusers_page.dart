import 'package:flutter/material.dart';
import 'package:project_x/service/database/database_provider.dart';
import 'package:provider/provider.dart';

import '../../helper/navigation.dart';

class BlokedusersPage extends StatefulWidget {
  const BlokedusersPage({super.key});

  @override
  State<BlokedusersPage> createState() => _BlokedusersPageState();
}

class _BlokedusersPageState extends State<BlokedusersPage> {
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    loadBlockedUsers();
  }

  void _showUnblockBox(String userId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Unblock User'),
            content: Text('Are your sure you want to unblock this user?'),
            actions: [
              TextButton(
                onPressed: () => pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('User unblocked'),
                    ),
                  );
                  await databaseProvider.unblockUser(userId);
                },
                child: Text('Unblock'),
              ),
            ],
          );
        });
  }

  Future<void> loadBlockedUsers() async {
    await databaseProvider.loadBlockedUsers();
  }

  @override
  Widget build(BuildContext context) {
    final blockedUsers = listeningProvider.blockedUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blocked Users',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: blockedUsers.isEmpty
          ? Center(
              child: Text('No blocked users'),
            )
          : ListView.builder(
              itemCount: blockedUsers.length,
              itemBuilder: (context, index) {
                final user = blockedUsers[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text('@${user.username}'),
                  trailing: IconButton(
                      onPressed: () => _showUnblockBox(user.uid),
                      icon: Icon(Icons.block_outlined)),
                );
              }),
    );
  }
}
