import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_x/models/comment.dart';
import 'package:project_x/service/database/database_provider.dart';
import 'package:provider/provider.dart';

import '../helper/navigation.dart';
import '../service/auth/auth_service.dart';

class CommentTile extends StatelessWidget {
  Comment comment;
  final void Function()? onUserTap;
  CommentTile({super.key, required this.comment, required this.onUserTap});

  void _showOptions(BuildContext context) {
    String currentUid = AuthService().getCurrentUid();
    final bool isOwnComment = comment.uid == currentUid;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              if (isOwnComment)
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                  onTap: () async {
                    log(comment.id);
                    await Provider.of<DatabaseProvider>(context, listen: false,)
                        .deleteComment(
                      comment.id,
                      comment.postId,
                    );
                    pop(context);
                  },
                )
              else ...[
                ListTile(
                  leading: Icon(
                    Icons.report,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Report',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () async {
                    pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.block),
                  title: Text('Block'),
                  onTap: () {
                    pop(context);
                  },
                ),
              ],
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Cancel'),
                onTap: () {
                  pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onUserTap,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: CircleAvatar(
                  radius: 16,
                  child: Icon(
                    Icons.person,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onUserTap,
              child: Text(
                ' ${comment.name}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '  @${comment.username}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w200,
                color: Colors.grey,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: ()=>_showOptions(context),
              icon: Icon(
                Icons.more_horiz,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            bottom: 4,
            top: 6,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  comment.message,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.grey.shade800,
        ),
      ],
    );
  }
}
