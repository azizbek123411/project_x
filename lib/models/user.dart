import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String name;
  final String uid;
  final String email;
  final String username;
  final String bio;
  UserProfile({
    required this.name,
    required this.uid,
    required this.email,
    required this.username,
    required this.bio,
  });

  factory UserProfile.fromDocument(DocumentSnapshot doc) {
    return UserProfile(
      name: doc['name'],
      uid: doc['uid'],
      email: doc['email'],
      username: doc['username'],
      bio: doc['bio'],
    );
  }

  Map<String,dynamic> toDoc(){
    return {
      'name':name,
      'uid':uid,
      'email':email,
      'username':username,
      'bio':bio,
    };
  }
}
