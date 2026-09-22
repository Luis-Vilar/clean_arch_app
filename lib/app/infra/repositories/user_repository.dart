import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/infra/drivers/user_repository_interface.dart';
import 'package:clean_arch_app/app/shared/result.dart';

class UserRepository implements UserRepositoryInterface {
  @override
  Future<Result<UserLoggedEntity>> checkSession() {
    // TODO: implement checkSession
    throw UnimplementedError();
  }

  @override
  Future<Result<UserLoggedEntity>> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Result<bool>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
