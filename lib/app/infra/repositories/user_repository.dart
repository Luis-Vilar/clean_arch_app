import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/infra/drivers/auth.dart';
import 'package:clean_arch_app/app/infra/drivers/preferences_interface.dart';
import 'package:clean_arch_app/app/domain/interfaces/user_repository_interface.dart';
import 'package:clean_arch_app/app/shared/failures.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/core/injection.dart';

class UserRepository implements UserRepositoryInterface {
  @override
  Future<Result<UserLoggedEntity>> checkSession() async {
    final pref = injection.get<PreferencesInterface>();

    return await pref.getSessionData();
  }

  @override
  Future<Result<UserLoggedEntity>> login(UserLoginEntity params) async {
    final auth = injection.get<AuthInterface>();
    final pref = injection.get<PreferencesInterface>();

    final loginResult = await auth.login(params);

    if (loginResult is Ok<UserLoggedEntity>) {
      final userLogged = loginResult.value;
      await pref.saveSessionData(userLogged);
    }

    return loginResult;
  }

  @override
  Future<Result<bool>> logout() async {
    final pref = injection.get<PreferencesInterface>();
    try {
      await pref.removeSessionData();
      return Result.ok(true);
    } catch (e) {
      return Result.error(ExceptionToFailure(message: e.toString()));
    }
  }
}
