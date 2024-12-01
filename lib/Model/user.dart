import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign up with email and password
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
        print('Error during sign-up: ${e.message}');
      return null;
    }
  }

  /// Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Error during sign-in: ${e.message}');
      return null;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error during sign-out: $e');
    }
  }

  /// Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent');
    } on FirebaseAuthException catch (e) {
      print('Error during password reset: ${e.message}');
    }
  }

  /// Listen for auth state changes
  Stream<User?> get authStateChanges {
    return _auth.authStateChanges();
  }
}
