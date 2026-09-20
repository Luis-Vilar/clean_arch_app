import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/domain/interfaces/auth.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/app/shared/use_case.dart';
import 'package:clean_arch_app/core/injection.dart';

class LoginUserCase extends UseCase<UserLoggedEntity, UserLoginEntity> {
  @override
  Future<Result<UserLoggedEntity>> call(UserLoginEntity params) async {
    final auth = injection.get<AuthInterface>();

    return await auth.login(params);
  }
}
