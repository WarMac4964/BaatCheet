import 'package:baatchet/auth/model/user_Data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum CallStatus { succeded, failed }

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserData? userFromFirebaseUser(User? user) {
    return user != null ? UserData(userId: user.uid) : null;
  }

  FirebaseAuth get firebaseAuth {
    return _firebaseAuth;
  }

  FirebaseFirestore get firebaseFirestore {
    return _firebaseFirestore;
  }

  Future<Map<String, dynamic>> tryLoginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return {
        'status': CallStatus.succeded,
        'message': 'Logged in successfully',
        'id': userCredential.user?.uid,
        'user': userFromFirebaseUser(userCredential.user)
      };
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
          await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user?.uid != null) {
        _firebaseFirestore
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({'email': email, 'id': userCredential.user?.uid, 'name': name});
        return {
          'status': CallStatus.succeded,
          'message': 'Account created successfully',
          'id': userCredential.user?.uid,
          'user': userFromFirebaseUser(userCredential.user)
        };
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return {'status': CallStatus.failed, 'message': 'The password is too weak'};
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return {'status': CallStatus.failed, 'message': 'This email has already been registered, Try logging in'};
      }
      return {'status': CallStatus.failed, 'message': e.message};
    } catch (err) {
      print(err);
      return {'status': CallStatus.failed, 'message': 'An error occured, Please try again later.'};
    }
  }

  Future resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return {'status': CallStatus.failed, 'message': 'An error occured, Please try again later.'};
    } on FirebaseAuthException catch (e) {
      return {'status': CallStatus.failed, 'message': e.message};
    } catch (err) {
      print(err.toString());
      return {'status': CallStatus.failed, 'message': 'An error occured, Please try again later.'};
    }
  }

  void signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (err) {
      print(err.toString());
    }
  }
}
