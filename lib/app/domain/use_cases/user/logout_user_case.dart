import 'package:clean_arch_app/app/domain/interfaces/user_repository_interface.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/app/shared/use_case.dart';
import 'package:clean_arch_app/core/injection.dart';

class LogoutUserCase extends UseCase<bool, NoParams> {
  @override
  Future<Result<bool>> call(NoParams params) async {
    final repository = injection.get<UserRepositoryInterface>();

    return await repository.logout();
  }
}
