import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';
import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/infra/drivers/todo_database_interface.dart';
import 'package:clean_arch_app/app/domain/interfaces/todo_repository_interface.dart';
import 'package:clean_arch_app/app/infra/drivers/todo_source_interface.dart';
import 'package:clean_arch_app/app/infra/models/todo_model.dart';
import 'package:clean_arch_app/app/shared/failures.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/core/injection.dart';

class TodoRepository implements TodoRepositoryInterface {
  final _db = injection.get<TodoDatabaseInterface>();
  final _datasource = injection.get<TodoSourceInterface>();

  @override
  Future<Result<TodoEntity>> createTodo(TodoEntity todo) {
    return _db.insertTodo(todo);
  }

  @override
  Future<Result<TodoEntity>> deleteTodo(TodoEntity todo) {
    return _db.deleteTodo(todo);
  }

  @override
  Future<Result<List<TodoEntity>>> readAllTodos() {
    return _db.getAllTodos();
  }

  @override
  Future<Result<TodoEntity>> updateTodo(TodoEntity todo) {
    return _db.updateTodo(todo);
  }

  @override
  Future<Result<List<TodoEntity>>> syncTodos(UserLoggedEntity user) async {
    final remoteResult = await _datasource.getTodos(user.id);

    if (remoteResult is ResultError<List<TodoModel>>) {
      return Result.error(remoteResult.error);
    }

    if (remoteResult is! Ok<List<TodoModel>>) {
      return Result.error(
        ExceptionToFailure(message: 'No se pudo sincronizar los todos.'),
      );
    }

    final remoteTodos = remoteResult.value;

    for (final todo in remoteTodos) {
      final savedResult = await createTodo(todo);
      if (savedResult is ResultError<TodoEntity>) {
        return Result.error(savedResult.error);
      }
    }

    final localResult = await readAllTodos();
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
