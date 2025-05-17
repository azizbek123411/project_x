import 'package:flutter/material.dart';
import 'package:project_x/models/post.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final void Function()? onUserTap;
  const PostTile({super.key, required this.post,required this.onUserTap});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
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
                  color: Colors.grey),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 6),
          child: Text(
            widget.post.message,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Divider(),
      ],
    );
  }
}
