import 'package:e_commerce_app/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final authService = AuthServicesImpl();

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());

    try {
      final isAuthenticated = await authService.loginWithEmailAndPassword(
        email,
        password,
      );
      isAuthenticated ? emit(AuthSuccess()) : emit(AuthError("Login Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> registerWithPhoneAndPassword(
    String email,
    String password,
  ) async {
    emit(AuthLoading());

    try {
      final isRegistered = await authService.registerWithPhoneAndPassword(
        email,
        password,
      );
      isRegistered ? emit(AuthSuccess()) : emit(AuthError("Register Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void checkAuth() {
    final user = authService.currentUser();
    if (user != null) {
      emit(AuthSuccess());
    }
  }

  Future<void> logout() async {
    emit(AuthLoggingOut());

    try {
      await authService.logout();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthLogoutError(e.toString()));
    }
  }

  Future<void> authenticatingWithGoogle() async {
    emit(GoogleAuthenticating());

    try {
      final isAuthenticated = await authService.authenticateWithGoogle();
      if (isAuthenticated){
        emit(GoogleAuthSuccess());
      }
      else { 
        emit(GoogleAuthError("Google authentication failed"));
      }
    } catch (e) {
      emit(GoogleAuthError(e.toString()));
    }
  }
}
