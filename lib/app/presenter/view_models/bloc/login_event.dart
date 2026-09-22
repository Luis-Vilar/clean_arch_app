part of 'login_bloc.dart';

sealed class LoginEvent {}

class LoginCheckSessionEvent extends LoginEvent {}

class LoginUserEvent extends LoginEvent {
  UserLoginEntity user;
  LoginUserEvent({required this.user});
}

class LogoutUserEvent extends LoginEvent {}
