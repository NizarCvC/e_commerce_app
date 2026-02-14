part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

final class AuthLoggingOut extends AuthState {}

final class AuthLoggedOut extends AuthState {}

final class AuthLogoutError extends AuthState {
  final String message;

  AuthLogoutError(this.message);
}

final class GoogleAuthenticating extends AuthState {}

final class GoogleAuthSuccess extends AuthState {}

final class GoogleAuthError extends AuthState {
  final String message;

  GoogleAuthError(this.message);
}
