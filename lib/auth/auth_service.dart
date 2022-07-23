import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum CallStatus { succeded, failed }

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> tryLoginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return {'status': CallStatus.succeded, 'message': 'Logged in successfully', 'id': userCredential.user?.uid};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return {'status': CallStatus.failed, 'message': 'The password is too weak'};
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return {'status': CallStatus.failed, 'message': 'The password or email is incorrect'};
      }
      return {'status': CallStatus.failed, 'message': e.message};
    } catch (err) {
      print(err);
      return {'status': CallStatus.failed, 'message': 'An error occured, Please try again later.'};
    }
  }

  Future createUserWithEmailAndPassword(String email, String password, String name) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user?.uid != null) {
        firebaseFirestore
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({'email': email, 'id': userCredential.user?.uid, 'name': name});
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return {'status': CallStatus.failed, 'message': 'The password is too weak'};
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return {'status': CallStatus.failed, 'message': 'This email has already been registered, Try logging in'};
      }
    } catch (err) {
      print(err);
      return {'status': CallStatus.failed, 'message': 'An error occured, Please try again later.'};
    }
  }
}
