// firebase auth service class
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user obj based on firebase user
  User? _userFromFirebaseUser(User? user) {
    return user! != null ? user : null;
  }
  // auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges()
      .map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential  result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  // register with email and password
  Future registerWithEmailAndPassword(String? email, String? password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }
  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}