import 'package:clean_arch_app/app/presenter/components/login_form_component.dart';
import 'package:clean_arch_app/app/presenter/view_models/bloc/login_bloc.dart';
import 'package:clean_arch_app/app/presenter/views/splash/splash_view.dart';
import 'package:clean_arch_app/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc()..add(CheckSessionEvent()),
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.logged,
                arguments: state.userLoggedEntity,
              );
            } else if (state is LoginError) {
              String message = state.message;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            }
          },
          builder: (context, state) {
            return switch (state) {
              LoginError() => LoginFormComponent(
                formKey: formKey,
                userController: userController,
                passwordController: passwordController,
              ),
              _ => const SplashView(),
            };
          },
        ),
      ),
    );
  }
}
