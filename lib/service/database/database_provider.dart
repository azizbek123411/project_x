import 'package:flutter/material.dart';
import 'package:project_x/models/user.dart';
import 'package:project_x/service/auth/auth_service.dart';
import 'package:project_x/service/database/database_service.dart';

class DatabaseProvider extends ChangeNotifier{

    final _auth=AuthService();
    final _db=DatabaseService();


    Future<UserProfile?> userProfile(String uid)=> _db.getUserFromFirebase(uid);
}