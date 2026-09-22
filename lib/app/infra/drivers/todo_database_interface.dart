import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';
import 'package:clean_arch_app/app/shared/result.dart';

abstract interface class TodoDatabaseInterface {
  Future<Result<TodoEntity>> insertTodo(TodoEntity todo);
  Future<Result<TodoEntity>> deleteTodo(TodoEntity todo);
  Future<Result<List<TodoEntity>>> getAllTodos();
  Future<Result<TodoEntity>> updateTodo(TodoEntity todo);
}
