import 'package:flutter/material.dart';
import 'package:project_x/models/post.dart';
import 'package:project_x/models/user.dart';
import 'package:project_x/service/database/database_service.dart';

class DatabaseProvider extends ChangeNotifier {
  final _db = DatabaseService();

  Future<UserProfile?> userProfile(String uid) => _db.getUserFromFirebase(uid);

  Future<void> updateUserBio(String bio) => _db.updateUserBioInFirebase(bio);

  List<Post> _allPosts = [];
  List<Post> get getAllPosts => _allPosts;

  Future<void> postMessage(String message) async {
    await _db.postMessageInFirebase(message);
    await loadAllPosts();
  }

  Future<void> loadAllPosts() async {
    final allPosts = await _db.getAllPostsFromFirebase();
    _allPosts = allPosts;
    notifyListeners();
  }


  List<Post> filterUserPosts(String uid){
    return _allPosts.where((post)=>post.uid==uid).toList();

  }


  Future<void> deletePost(String postId)async{
    await _db.deletePostFromFirebase(postId);
    await loadAllPosts();
  }
}
