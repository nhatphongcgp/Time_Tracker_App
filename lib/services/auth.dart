import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;
  Future<User> signInAnonymous();
  Future<void> signOut();
  Stream<User> authStateChange();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Stream<User> authStateChange() => _firebaseAuth.authStateChanges();
  @override
  User get currentUser => _firebaseAuth.currentUser;
  @override
  Future<User> signInAnonymous() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
