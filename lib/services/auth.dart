import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/utils.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // login using email and password
  login(String email, String password) async {
    bool res = false;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = true;
    } on FirebaseAuthException catch (e) {
      showMessage(e.message!);
    } catch (e) {
      showMessage(e.toString());
    }
    return res;
  }

  // register using email and password
  register(String username, String name, String email, String password) async {
    bool res = false;
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((val) async {
        User user = val.user!;
        await user.updateDisplayName(name);
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'username': username,
          'name': name,
          'email': email,
          'photoURL': null,
          'status': true,
          'lastOnline': DateTime.now().microsecondsSinceEpoch,
          'createdAt': DateTime.now().microsecondsSinceEpoch,
          'updatedAt': DateTime.now().microsecondsSinceEpoch
        });
        await user.reload();
        res = true;
      });
    } on FirebaseAuthException catch (e) {
      showMessage(e.message!);
    } catch (e) {
      showMessage(e.toString());
    }
    return res;
  }

  // update profile
  updateProfile(String username, String name) async {
    bool res = false;
    try {
      User user = _auth.currentUser!;
      await user.updateDisplayName(name);
      await _firestore.collection('users').doc(user.uid).update({
        'name': name,
        'username': username,
        'updatedAt': DateTime.now().microsecondsSinceEpoch
      });
      await user.reload();
      res = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        showMessage('Please login again before updating profile!');
        await logout();
      } else {
        showMessage(e.message!);
      }
    } catch (e) {
      showMessage(e.toString());
    }
    return res;
  }

  // change password
  changePassword(String oldPass, String newPass) async {
    bool res = false;
    try {
      User user = _auth.currentUser!;
      await _auth.signInWithEmailAndPassword(email: user.email!, password: oldPass).then((value) async {
        await user.updatePassword(newPass);
        await user.reload();
        showMessage('Password changed successfully!');
      });
      res = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        showMessage('Looks like you\'ve entered wrong password. Please enter correct password.');
      } else {
        showMessage(e.message!);
      }
    } catch (e) {
      showMessage(e.toString());
    }
    return res;
  }

  // logout
  logout() async {
    bool res = false;
    try {
      await _auth.signOut().then((val) {
        showMessage('Logged out successfully!');
        res = true;
      });
    } on FirebaseAuthException catch (e) {
      showMessage(e.message!);
    } catch (e) {
      showMessage(e.toString());
    }
    return res;
  }
}