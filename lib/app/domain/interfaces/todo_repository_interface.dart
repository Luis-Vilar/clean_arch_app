import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';
import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/shared/result.dart';

abstract interface class TodoRepositoryInterface {
  Future<Result<TodoEntity>> createTodo(TodoEntity todo);
  Future<Result<List<TodoEntity>>> readAllTodos();
  Future<Result<TodoEntity>> updateTodo(TodoEntity todo);
  Future<Result<TodoEntity>> deleteTodo(TodoEntity todo);
  Future<Result<List<TodoEntity>>> syncTodos(UserLoggedEntity user);
}
