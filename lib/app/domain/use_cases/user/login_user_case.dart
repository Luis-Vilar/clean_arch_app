import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/infra/drivers/user_repository_interface.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/app/shared/use_case.dart';
import 'package:clean_arch_app/core/injection.dart';

class LoginUserCase extends UseCase<UserLoggedEntity, UserLoginEntity> {
  final repository = injection.get<UserRepositoryInterface>();
  @override
  Future<Result<UserLoggedEntity>> call(UserLoginEntity params) async {
    return await repository.login(params);
  }
}
