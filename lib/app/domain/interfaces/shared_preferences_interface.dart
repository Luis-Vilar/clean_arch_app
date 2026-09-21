import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/shared/result.dart';

abstract class SharedPrefInterface {
  Future<void> saveSessionData(UserLoggedEntity user);
  Future<Result<UserLoggedEntity>> getSessionData();
  Future<void> removeSessionData();
}
