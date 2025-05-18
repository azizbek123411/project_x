import 'package:flutter/material.dart';
import 'package:project_x/helper/navigation.dart';
import 'package:project_x/models/post.dart';

import '../../widgets/post_tile.dart';

class PostPage extends StatefulWidget {
  final Post post;
  const PostPage({
    super.key,
    required this.post,
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 8),
        child: ListView(children: [
          PostTile(
            post: widget.post,
            onUserTap: () => goUserProfile(
              context,
              widget.post.uid,
            ),
            onPostTap: () {},
          )
        ]),
      ),
    );
  }
}
