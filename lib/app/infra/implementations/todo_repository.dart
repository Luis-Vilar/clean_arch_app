import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';
import 'package:clean_arch_app/app/domain/interfaces/todo_repository_interface.dart';
import 'package:clean_arch_app/app/infra/sources/local/todo_database.dart';
import 'package:clean_arch_app/app/shared/result.dart';

class TodoRepository implements TodoRepositoryInterface {
  final _db = TodoDatabase();

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
