import 'package:clean_arch_app/app/infra/models/todo_model.dart';
import 'package:clean_arch_app/app/shared/result.dart';

abstract class TodoSourceInterface {
  Future<Result<List<TodoModel>>> getTodos(int userId);
}
