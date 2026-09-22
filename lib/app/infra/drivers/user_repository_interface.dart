import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/shared/result.dart';

abstract class UserRepositoryInterface {
  Future<Result<UserLoggedEntity>> login();
  Future<Result<bool>> logout();
  Future<Result<UserLoggedEntity>> checkSession();
}
