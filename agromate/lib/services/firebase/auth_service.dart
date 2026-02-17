import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  // Stream user auth state
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
