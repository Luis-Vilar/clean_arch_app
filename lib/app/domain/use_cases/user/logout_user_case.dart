import 'package:clean_arch_app/app/infra/drivers/preferences_interface.dart';
import 'package:clean_arch_app/app/shared/failures.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/app/shared/use_case.dart';
import 'package:clean_arch_app/core/injection.dart';

class LogoutUserCase extends UseCase<bool, NoParams> {
  @override
  Future<Result<bool>> call(NoParams params) async {
    final pref = injection.get<PreferencesInterface>();
    try {
      await pref.removeSessionData();
      return Result.ok(true);
    } catch (e) {
      return Result.error(ExceptionToFailure(message: e.toString()));
    }
  }
}
