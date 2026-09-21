import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/domain/use_cases/user/check_session_case.dart';
import 'package:clean_arch_app/app/domain/use_cases/user/login_user_case.dart';
import 'package:clean_arch_app/app/domain/use_cases/user/logout_user_case.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/app/shared/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _loginUser = LoginUserCase();
  final _checkSession = CheckSessionCase();
  final _logoutUser = LogoutUserCase();

  LoginBloc() : super(LoginInitial()) {
    on<ClearSessionDataEvent>((event, emit) {
      _logoutUser(NoParams());
    });

    on<CheckSessionEvent>((event, emit) async {
      emit(LoginLoading());

      final result = await _checkSession(NoParams());

      if (result is Ok<UserLoggedEntity>) {
        emit(LoginSuccess(userLoggedEntity: result.value));
        return;
      }

      if (result is ResultError<UserLoggedEntity>) {
        emit(LoginError(message: result.error.message));
        return;
      }
    });

    on<LoginUserEvent>((event, emit) async {
      emit(LoginLoading());

      final result = await _loginUser(event.user);

      if (result is Ok<UserLoggedEntity>) {
        emit(LoginSuccess(userLoggedEntity: result.value));
        return;
      }

      if (result is ResultError<UserLoggedEntity>) {
        emit(LoginError(message: result.error.message));
        return;
      }

      emit(LoginError(message: 'No se pudo iniciar sesión.'));
    });
  }
}
