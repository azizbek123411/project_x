
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_x/service/database/database_service.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  User? getCurrentUser() => _auth.currentUser;
  String getCurrentUid() => _auth.currentUser!.uid;

  Future<UserCredential> loginEmailPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> registerEmailPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }


  Future<void> logOut()async{
    await _auth.signOut();
  }


  Future<void> deleteAccount()async{
    User? user=getCurrentUser();
    if(user != null){

      await DatabaseService().deleteUserFromFirebase(user.uid);
      await user.delete();
    }
  }
}
