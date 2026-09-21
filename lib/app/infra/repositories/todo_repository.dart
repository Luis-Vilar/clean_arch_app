import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';
import 'package:clean_arch_app/app/domain/interfaces/todo_repository_interface.dart';
import 'package:clean_arch_app/app/infra/data_sources/local/todo_database.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/core/injection.dart';

class TodoRepository implements TodoRepositoryInterface {
  final _db = injection.get<TodoDatabaseInterface>();

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
}
