import 'package:flutter/material.dart';
import 'package:project_x/helper/navigation.dart';
import 'package:project_x/models/post.dart';
import 'package:project_x/service/database/database_provider.dart';
import 'package:project_x/widgets/comment_tile.dart';
import 'package:provider/provider.dart';

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

late final listeningProvider=Provider.of<DatabaseProvider>(context);
late final databaseProvider=Provider.of<DatabaseProvider>(context,listen: false);


  @override
  Widget build(BuildContext context) {

    final allComments=listeningProvider.getComments(widget.post.id);
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
          ),

            allComments.isEmpty?Center(child: Text('No comments...'),):ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: allComments.length,
              itemBuilder: (context,index){
                final comment=allComments[index];
              return CommentTile(comment: comment, onUserTap: ()=>goUserProfile(context, comment.uid),);
            })
        ]),
      ),
    );
  }
}
