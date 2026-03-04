import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: '1026597889179-mej4m4c7lfdk23qj10gouahfqm8d9erc.apps.googleusercontent.com',
  );

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        throw AuthException(
          'Google sign-in failed: could not retrieve authentication tokens. '
          'Check your Firebase & OAuth configuration.',
        );
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user;
    } on AuthException {
      rethrow; // already formatted — don't wrap again
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseError(e.code));
    } catch (e) {
      throw AuthException('An unexpected error occurred. Please try again.');
    }
  }
  Future<void> signOut() async {
    final errors = <String>[];

    try {
      await _auth.signOut();
    } catch (_) {
      errors.add('Firebase sign-out failed.');
    }

    try {
      await _googleSignIn.signOut();
    } catch (_) {
      errors.add('Google sign-out failed.');
    }

    if (errors.isNotEmpty) {
      throw AuthException(errors.join(' '));
    }
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return 'An account already exists with this email using a different sign-in method.';
      case 'invalid-credential':
        return 'The credential is invalid or has expired.';
      case 'operation-not-allowed':
        return 'Google sign-in is not enabled. Contact support.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'network-request-failed':
        return 'Network error. Check your internet connection.';
      default:
        return 'Sign-in failed. Please try again.';
    }
  }
}

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}
