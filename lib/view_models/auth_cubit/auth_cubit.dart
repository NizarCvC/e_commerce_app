import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/services/auth_services.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/utils/api_paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final _authServices = AuthServicesImpl();
  final _fireStoreServices = FirestoreServices.instance;

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());

    try {
      final isAuthenticated = await _authServices.loginWithEmailAndPassword(
        email,
        password,
      );
      isAuthenticated ? emit(AuthSuccess()) : emit(AuthError("Login Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> registerWithPhoneAndPassword(
    String username,
    String email,
    String password,
  ) async {
    emit(AuthLoading());

    try {
      final isRegistered = await _authServices.registerWithPhoneAndPassword(
        email,
        password,
      );
      if (isRegistered) {
        await _saveUserData(username, email);
        emit(AuthSuccess());
      } else {
        emit(AuthError("Register Failed"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _saveUserData(String username, String email) async {
    final currentUser = _authServices.currentUser();
    final userModel = UserModel(
      id: currentUser!.uid,
      username: username,
      email: email,
      createdAt: DateTime.now().toIso8601String(),
    );
    await _fireStoreServices.setData(
      path: ApiPaths.users(userModel.id),
      data: userModel.toMap()
    );
  }

  void checkAuth() {
    final user = _authServices.currentUser();
    if (user != null) {
      emit(AuthSuccess());
    }
  }

  Future<void> logout() async {
    emit(AuthLoggingOut());

    try {
      await _authServices.logout();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthLogoutError(e.toString()));
    }
  }

  Future<void> authenticatingWithGoogle() async {
    emit(GoogleAuthenticating());

    try {
      final isAuthenticated = await _authServices.authenticateWithGoogle();
      if (isAuthenticated) {
        emit(GoogleAuthSuccess());
      } else {
        emit(GoogleAuthError("Google authentication failed"));
      }
    } catch (e) {
      emit(GoogleAuthError(e.toString()));
    }
  }
}
