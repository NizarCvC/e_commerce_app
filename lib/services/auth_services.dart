import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<bool> registerWithPhoneAndPassword(String email, String password);
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
    await _fireBaseAuth.signOut();
  }
}
