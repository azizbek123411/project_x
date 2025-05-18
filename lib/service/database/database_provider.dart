import 'package:flutter/material.dart';
import 'package:project_x/models/post.dart';
import 'package:project_x/models/user.dart';
import 'package:project_x/service/auth/auth_service.dart';
import 'package:project_x/service/database/database_service.dart';

class DatabaseProvider extends ChangeNotifier {
  final _db = DatabaseService();
  final _auth=AuthService();

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
    initializeLikeMap();
    notifyListeners();
  }


  List<Post> filterUserPosts(String uid){
    return _allPosts.where((post)=>post.uid==uid).toList();

  }


  Future<void> deletePost(String postId)async{
    await _db.deletePostFromFirebase(postId);
    await loadAllPosts();
  }




  Map<String,int>_likeCounts={};


   List<String> _likedPosts=[];

bool isPostLikedByCurrentUser(String postId)=>_likedPosts.contains(postId);

int getLikeCount(String postId)=>_likeCounts[postId]!;



   void initializeLikeMap(){
    final currenUid=_auth.getCurrentUid();

    for(var post in _allPosts){
      _likeCounts[post.id]==post.likeCount;

      if(post.likedBy.contains(currenUid)){
        _likedPosts.add(post.id);
      }
    }
   }


   Future<void>toggeleLike(String postId)async{
    final likedPostsOriginal=_likedPosts;
    final likeCountOriginal=_likeCounts;
    if(_likedPosts.contains(postId)){
      _likedPosts.remove(postId);
     _likeCounts[postId]=(_likeCounts[postId]??0)-1;
    }else{
      _likedPosts.add(postId);
      _likeCounts[postId]=(_likeCounts[postId]??0)+1;
    }
    notifyListeners();
   }
}
