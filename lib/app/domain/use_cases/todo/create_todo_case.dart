import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';
import 'package:clean_arch_app/app/domain/interfaces/todo_repository_interface.dart';
import 'package:clean_arch_app/app/domain/use_cases/use_case.dart';
import 'package:clean_arch_app/app/utils/result.dart';
import 'package:clean_arch_app/core/injection.dart';

class CreateTodoCase extends UseCase<TodoEntity, TodoEntity> {
  final repository = injection.get<TodoRepositoryInterface>();

  @override
  Future<Result<TodoEntity>> call(TodoEntity params) async =>
      await repository.createTodo(params);
}
