import 'package:flutter/material.dart';
import 'package:project_x/models/post.dart';
import 'package:project_x/models/user.dart';
import 'package:project_x/service/database/database_service.dart';

class DatabaseProvider extends ChangeNotifier {
  final _db = DatabaseService();

  Future<UserProfile?> userProfile(String uid) => _db.getUserFromFirebase(uid);

  Future<void> updateUserBio(String bio) => _db.updateUserBioInFirebase(bio);

  List<Post> allPosts = [];
  List<Post> get getAllPosts => allPosts;

  Future<void> postMessage(String message) async {
    await _db.postMessageInFirebase(message);
  }
}
