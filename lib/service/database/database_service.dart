import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_x/models/post.dart';
import 'package:project_x/models/user.dart';
import 'package:project_x/service/auth/auth_service.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> saveUserInfoInFirebase(
      {required String name, required String email}) async {
    String uid = _auth.currentUser!.uid;
    String username = email.split('@')[0];

    UserProfile user = UserProfile(
      name: name,
      uid: uid,
      email: email,
      username: username,
      bio: '',
    );

    final userMap = user.toDoc();

    await _db.collection('Users').doc(uid).set(userMap);
  }

  Future<UserProfile?> getUserFromFirebase(String uid) async {
    try {
      DocumentSnapshot userDoc = await _db.collection('Users').doc(uid).get();
      return UserProfile.fromDocument(userDoc);
    } catch (e, st) {
      log("Error:$e, StackTrace:$st");
      return null;
    }
  }

  Future<void> updateUserBioInFirebase(String bio) async {
    String uid = AuthService().getCurrentUid();
    try {
      await _db.collection('Users').doc(uid).update({'bio': bio});
    } catch (e, st) {
      log("Error:$e, StackTrace:$st");
    }
  }

  Future<void> postMessageInFirebase(String message) async {
    try {
      final uid = _auth.currentUser!.uid;
      UserProfile? user = await getUserFromFirebase(uid);

      Post newPost = Post(
        id: '',
        uid: uid,
        name: user!.name,
        username: user.username,
        message: message,
        timestamp: Timestamp.now(),
        likeCount: 0,
        likedBy: [],
      );

      Map<String, dynamic> newPostMap = newPost.toDoc();

      await _db.collection('Posts').add(newPostMap);
    } catch (e, st) {
      log("Error:$e, StackTrace:$st");
    }
  }

  Future<List<Post>> getAllPostsFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('Posts')
          .orderBy('timestamp', descending: true)
          .get();
      return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    } catch (e, st) {
      log("Error:$e, StackTrace:$st");
      return [];
    }
  }
}
