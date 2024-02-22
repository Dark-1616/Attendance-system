
import 'package:attendance_system/message.dart';
import 'package:firebase_auth/firebase_auth.dart';



class FirebaseAuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        messagePopup(message: 'The email address is already in use.');
      } else {
        messagePopup(message: 'An error occurred: ${e.code}');
      }
    }
    return null;

  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-matricule') {
        messagePopup(message: 'Invalid email or password.');
      } else {
        messagePopup(message: 'An error occurred: ${e.code}');
      }

    }
    return null;

  }




}


