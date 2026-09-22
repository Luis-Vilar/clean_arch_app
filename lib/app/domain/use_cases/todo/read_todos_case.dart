import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';
import 'package:clean_arch_app/app/infra/drivers/todo_repository_interface.dart';
import 'package:clean_arch_app/app/shared/use_case.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/core/injection.dart';

class ReadTodosCase extends UseCase<List<TodoEntity>, NoParams> {
  final repository = injection.get<TodoRepositoryInterface>();

  @override
  Future<Result<List<TodoEntity>>> call(NoParams params) async =>
      await repository.readAllTodos();
}
