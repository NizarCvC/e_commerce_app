import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<bool> registerWithPhoneAndPassword(String email, String password);
  Future<bool> authenticateWithGoogle();
  User? currentUser();
  Future<void> logout();
}

class AuthServicesImpl implements AuthServices {
  final _fireBaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    final userCredential = await _fireBaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;

    return (user != null);
  }

  @override
  Future<bool> registerWithPhoneAndPassword(
    String email,
    String password,
  ) async {
    final userCredential = await _fireBaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;

    return (user != null);
  }

  @override
  User? currentUser() {
    return _fireBaseAuth.currentUser;
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _fireBaseAuth.signOut();
  }

  @override
  Future<bool> authenticateWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredential = await _fireBaseAuth.signInWithCredential(credential);

    return (userCredential.user != null);
  }
}
