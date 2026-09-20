import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/presenter/view_models/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButtonComponent extends StatefulWidget {
  const LoginButtonComponent({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  State<LoginButtonComponent> createState() => _LoginButtonComponentState();
}

class _LoginButtonComponentState extends State<LoginButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              if (!(widget.formKey.currentState?.validate() ?? false)) return;

              context.read<LoginBloc>().add(
                LoginUserEvent(
                  user: UserLoginEntity(
                    username: widget.usernameController.text,
                    password: widget.passwordController.text,
                  ),
                ),
              );
              widget.usernameController.clear();
              widget.passwordController.clear();
            },
            child: const Text('Fazer Login'),
          ),
        );
      },
    );
  }
}
