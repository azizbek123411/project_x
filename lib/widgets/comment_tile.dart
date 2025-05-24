import 'package:flutter/material.dart';
import 'package:project_x/models/comment.dart';

class CommentTile extends StatelessWidget {
  Comment comment;
  final void Function()? onUserTap;
   CommentTile({
    super.key,
    required this.comment,
    required this.onUserTap
  });

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
              onPressed: () {},
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
