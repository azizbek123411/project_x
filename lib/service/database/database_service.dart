import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_x/models/comment.dart';
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

  Future<void> deletePostFromFirebase(String postId) async {
    try {
      await _db.collection('Posts').doc(postId).delete();
    } catch (e, st) {
      log("Error:$e, StackTrace:$st");
    }
  }

  Future<void> updatePostInFirebase(String postId, String message) async {
    try {
      await _db.collection('Posts').doc(postId).update({'message': message});
    } catch (e, st) {
      log("Error:$e, StackTrace:$st");
    }
  }

  Future<void> toggleLikeInFirebase(String postId) async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentReference postDoc = _db.collection("Posts").doc(postId);
      await _db.runTransaction((transaction) async {
        DocumentSnapshot postSnapshot = await transaction.get(postDoc);
        List<String> likedBy = List<String>.from(postSnapshot['likedBy'] ?? []);

        int currentLikeCount = postSnapshot['likeCount'];

        if (!likedBy.contains(uid)) {
          likedBy.add(uid);
          currentLikeCount++;
        } else {
          likedBy.remove(uid);
          currentLikeCount--;
        }

        transaction.update(postDoc, {
          'likes': currentLikeCount,
          'likedBy': likedBy,
        });
      });
    } catch (e, st) {
      log("Error:$e, StackTrace:$st");
    }
  }

  Future<void> addCommentInFirebase(String postId, String message) async {
    try {
      String uid = _auth.currentUser!.uid;
      UserProfile? user = await getUserFromFirebase(uid);

      Comment newComment = Comment(
          id: '',
          postId: postId,
          name: user!.name,
          uid: uid,
          username: user.username,
          message: message,
          timestamp: Timestamp.now());

      Map<String, dynamic> newCommentMap = newComment.toMap();
      await _db.collection('Comments').add(newCommentMap);
    } catch (e, st) {
      log('Error:$e,StackTrace:$st');
    }
  }

  Future<void> deleteCommentInFirebase(String commentId) async {
    try {
      await _db.collection('Comments').doc(commentId).delete();
    } catch (e, st) {
      log("Error:$e,StackTrace:$st");
    }
  }

  Future<List<Comment>> getCommentsFromFirebase(String postId) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('Comments')
          .where('postId', isEqualTo: postId)
          .get();
      return snapshot.docs.map((doc) => Comment.fromDocument(doc)).toList();
    } catch (e, st) {
      log("Error:$e,StackTrace:$st");
      return [];
    }
  }

  Future<void> reportUerInFirebase(String postId, String uid) async {
    final String currentUid = _auth.currentUser!.uid;
    final report = {
      'reportedBy': currentUid,
      'messageId': postId,
      'messageOwnerId': uid,
      'timestamp': FieldValue.serverTimestamp(),
    };
    await _db.collection('Reports').add(report);
  }

  Future<void> blockUserInFirebase(String userId) async {
    final currentUserId = _auth.currentUser!.uid;
    await _db
        .collection('Users')
        .doc(currentUserId)
        .collection('BlockedUsers')
        .doc(userId)
        .set({});
  }

  Future<void> unblockUserInFirebase(String blockedUserId) async {
    final currentUserId = _auth.currentUser!.uid;
    await _db
        .collection('Users')
        .doc(currentUserId)
        .collection('BlockedUsers')
        .doc(blockedUserId)
        .delete();
  }

  Future<List<String>> getBlockedUsersFromFirebase() async {
    final currentUserId = _auth.currentUser!.uid;
    final snapshot = await _db
        .collection('Users')
        .doc(currentUserId)
        .collection('BlockedUsers')
        .get();
    return snapshot.docs.map((doc) => doc.id).toList();
  }

  Future<void> deleteUserFromFirebase(String uid) async {
    WriteBatch batch = _db.batch();

    DocumentReference userDoc = _db.collection('Users').doc(uid);
    batch.delete(userDoc);

    QuerySnapshot userPosts =
        await _db.collection('Posts').where('uid', isEqualTo: uid).get();
    for (var post in userPosts.docs) {
      batch.delete(post.reference);
    }

    QuerySnapshot userComments =
        await _db.collection('Comments').where('uid', isEqualTo: uid).get();
    for (var comment in userComments.docs) {
      batch.delete(comment.reference);
    }


    QuerySnapshot allPosts=await _db.collection('Posts').get();
    for(QueryDocumentSnapshot post in allPosts.docs){
      Map<String,dynamic>postData=post.data() as Map<String,dynamic>;
      var likedBy=postData['likedBy'] as List<dynamic>??[];
      if(likedBy.contains(uid)){
        batch.update(post.reference, {
          'likedBy':FieldValue.arrayRemove([uid]),
          'likeCount':FieldValue.increment(-1)
        });
      }
    }

    await batch.commit();
  }
}
