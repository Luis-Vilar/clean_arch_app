import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';
import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/domain/interfaces/todo_repository_interface.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/app/shared/use_case.dart';
import 'package:clean_arch_app/core/injection.dart';

class SyncTodoCase extends UseCase<List<TodoEntity>, UserLoggedEntity> {
  final repository = injection.get<TodoRepositoryInterface>();

  @override
  Future<Result<List<TodoEntity>>> call(UserLoggedEntity params) async {
    return await repository.syncTodos(params);
  }
}
