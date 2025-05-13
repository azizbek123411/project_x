import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_x/models/user.dart';

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

final userMap=user.toDoc();

await _db.collection('Users').doc(uid).set(userMap);

  }




Future<UserProfile?> getUserFromFirebase(String uid)async{

try{
  DocumentSnapshot userDoc=await _db.collection('Users').doc(uid).get();
  return UserProfile.fromDocument(userDoc);
}catch(e,st){   
  log("Error:$e, StackTrace:$st");
  return null;
}

}

}
