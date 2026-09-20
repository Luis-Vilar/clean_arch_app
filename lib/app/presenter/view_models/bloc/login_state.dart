part of 'login_bloc.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  LoginSuccess({required this.userLoggedEntity});

  UserLoggedEntity userLoggedEntity;
}

final class LoginError extends LoginState {
  LoginError({required this.message});

  String message;
}
