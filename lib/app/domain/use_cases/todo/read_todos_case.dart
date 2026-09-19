import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';
import 'package:clean_arch_app/app/domain/interfaces/todo_repository_interface.dart';
import 'package:clean_arch_app/app/utils/result.dart';
import 'package:clean_arch_app/core/injection.dart';

class ReadTodosCase {
  final repository = injection.get<TodoRepositoryInterface>();

  Future<Result<List<TodoEntity>>> readTodos() async =>
      await repository.readAllTodos();
}
