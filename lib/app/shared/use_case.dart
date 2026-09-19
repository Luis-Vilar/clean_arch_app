import 'package:clean_arch_app/app/shared/result.dart';

abstract class UseCase<Output, Params> {
  Future<Result<Output>> call(Params params);
}

final class NoParams {}
