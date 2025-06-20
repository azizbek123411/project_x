import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_x/helper/navigation.dart';
import 'package:project_x/models/post.dart';
import 'package:project_x/service/auth/auth_service.dart';
import 'package:project_x/service/database/database_provider.dart';
import 'package:project_x/widgets/my_input_alert_box.dart';
import 'package:provider/provider.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final void Function()? onUserTap;
  final void Function()? onPostTap;
  const PostTile({
    super.key,
    required this.post,
    required this.onUserTap,
    required this.onPostTap,
  });

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  final commentController = TextEditingController();
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);
  late final listeningProvider = Provider.of<DatabaseProvider>(
    context,
  );

  @override
  void initState() {
    super.initState();
    loadComments();
  }

  void _openNewCommentBox() {
    showDialog(
        context: context,
        builder: (context) {
          return MyInputAlertBox(
            controller: commentController,
            hintTitle: 'New Comment',
            onTap: () async {
              await _addComment();
              commentController.clear();
            },
            onPressedText: 'Comment',
          );
        });
  }

  Future<void> _addComment() async {
    if (commentController.text.isEmpty) return;
    try {
      await databaseProvider.addComment(
          widget.post.id, commentController.text.trim());
    } catch (e, st) {
      log("Error: $e, StackTrace:$st");
    }
  }

  Future<void> loadComments() async {
    await databaseProvider.loadComments(widget.post.id);
  }

  void _toggleLikePost() async {
    try {
      await databaseProvider.toggeleLike(widget.post.id);
    } catch (e, st) {
      log("Error: $e, StackTrace:$st");
    }
  }

  void _showOptions() {
    String currentUid = AuthService().getCurrentUid();
    final bool isOwnPost = widget.post.uid == currentUid;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              if (isOwnPost)
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                  onTap: () async {
                    log(widget.post.id);
                    await databaseProvider.deletePost(widget.post.id);
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
                    _reportConfirmationBox();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.block),
                  title: Text('Block'),
                  onTap: () {
                    pop(context);
                    _blockConfirmationBox();
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

  void _reportConfirmationBox() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Report Message'),
            content: Text('Are your sure you want to report this message?'),
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
                      content: Text('Message reported'),
                    ),
                  );
                    await databaseProvider.reportUser(
                    widget.post.id,
                    widget.post.uid,
                  );
                },
                child: Text('Report'),
              ),
            ],
          );
        });
  }

  void _blockConfirmationBox() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Block User'),
            content: Text('Are your sure you want to block this user?'),
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
                      content: Text('User blocked'),
                    ),
                  ); await databaseProvider.blockUser(
                    widget.post.uid,
                  );
                },
                child: Text('Block'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    bool likedByCurrentUser =
        listeningProvider.isPostLikedByCurrentUser(widget.post.id);
    int likeCount = listeningProvider.getLikeCount(widget.post.id) + 1;

    int commentCount = listeningProvider.getComments(widget.post.id).length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: widget.onUserTap,
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
              onTap: widget.onUserTap,
              child: Text(
                ' ${widget.post.name}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '  @${widget.post.username}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w200,
                color: Colors.grey,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () => _showOptions(),
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
          child: GestureDetector(
            onTap: widget.onPostTap,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Text(
                    widget.post.message,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: _toggleLikePost,
              icon: likedByCurrentUser
                  ? Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.favorite_outline_rounded,
                    ),
            ),
            Text(likeCount == 0 ? '' : likeCount.toString()),
            IconButton(
              onPressed: _openNewCommentBox,
              icon: Icon(
                Icons.comment_outlined,
              ),
            ),
            Text(commentCount == 0 ? '' : commentCount.toString()),
          ],
        ),
        Divider(
          color: Colors.grey.shade800,
        ),
      ],
    );
  }
}
