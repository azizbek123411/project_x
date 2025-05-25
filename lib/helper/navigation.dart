import 'package:flutter/material.dart';
import 'package:project_x/models/post.dart';
import 'package:project_x/pages/inner_pages/post_page.dart';
import 'package:project_x/pages/navbar_pages/profile_page.dart';

void goUserProfile(BuildContext context, String uid) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProfilePage(uid: uid),
    ),
  );
}

void goToPostPage(BuildContext context, Post post) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PostPage(
        post: post,
      ),
    ),
  );
}

void pushPage(BuildContext context,Widget page){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>page));
}


void pop(BuildContext context){
  Navigator.pop(context);
}
