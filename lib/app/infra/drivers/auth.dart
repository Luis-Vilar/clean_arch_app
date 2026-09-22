import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/shared/result.dart';

abstract class AuthInterface {
  Future<Result<UserLoggedEntity>> login(UserLoginEntity user);
}
