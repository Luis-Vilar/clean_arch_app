import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';
import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/domain/interfaces/todo_repository_interface.dart';
import 'package:clean_arch_app/app/domain/interfaces/todo_source_interface.dart';
import 'package:clean_arch_app/app/infra/models/todo_model.dart';
import 'package:clean_arch_app/app/shared/failures.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/app/shared/use_case.dart';
import 'package:clean_arch_app/core/injection.dart';

class SyncTodoCase extends UseCase<List<TodoEntity>, UserLoggedEntity> {
  final repository = injection.get<TodoRepositoryInterface>();
  final datasource = injection.get<TodoSourceInterface>();

  @override
  Future<Result<List<TodoEntity>>> call(UserLoggedEntity params) async {
    final remoteResult = await datasource.getTodos(params.id);

    if (remoteResult is ResultError<List<TodoModel>>) {
      return Result.error(remoteResult.error);
    }

    if (remoteResult is! Ok<List<TodoModel>>) {
      return Result.error(
        ExceptionToFailure(message: 'No se pudo sincronizar los todos.'),
      );
    }

    final remoteTodos = List<TodoEntity>.from(remoteResult.value);

    for (final todo in remoteTodos) {
      final savedResult = await repository.createTodo(todo);
      if (savedResult is ResultError<TodoEntity>) {
        return Result.error(savedResult.error);
      }
    }

    final localResult = await repository.readAllTodos();
    if (localResult is ResultError<List<TodoEntity>>) {
      return Result.error(localResult.error);
    }

    if (localResult is Ok<List<TodoEntity>>) {
      return Result.ok(localResult.value);
    }

    return Result.error(
      ExceptionToFailure(message: 'No se pudo sincronizar los todos.'),
    );
  }
}
