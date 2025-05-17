import 'package:flutter/material.dart';
import 'package:project_x/pages/navbar_pages/profile_page.dart';

void goUserProfile(BuildContext context, String uid) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProfilePage(uid: uid),
    ),
  );
}
