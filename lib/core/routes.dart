import 'package:clean_arch_app/app/presenter/views/logged/logged_view.dart';
import 'package:clean_arch_app/app/presenter/views/login/login_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = '/login';
  static const String logged = '/logged';

  static final routes = <String, Widget Function(BuildContext)>{
    login: (_) => LoginView(),
    logged: (_) => LoggedView(),
  };
}
