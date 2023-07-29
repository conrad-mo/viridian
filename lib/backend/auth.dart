import 'package:firebase_auth/firebase_auth.dart';
import 'package:viridian/backend/database.dart';
import 'package:viridian/userclass.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future userRegistar(String username, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        await DatabaseService(uid: user.uid).saveUserData(username, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    try {
      await UserClass.saveUserTokenStatus(false);
      await UserClass.saveUserEmailStatus('');
      await UserClass.saveUserNameStatus('');
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future userLogin(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
