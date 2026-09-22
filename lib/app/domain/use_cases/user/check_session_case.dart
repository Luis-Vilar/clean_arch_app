import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/domain/interfaces/user_repository_interface.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/app/shared/use_case.dart';
import 'package:clean_arch_app/core/injection.dart';

class CheckSessionCase extends UseCase<UserLoggedEntity, NoParams> {
  @override
  Future<Result<UserLoggedEntity>> call(NoParams params) async {
    final repository = injection.get<UserRepositoryInterface>();

    return await repository.checkSession();
  }
}
