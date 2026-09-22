import 'package:clean_arch_app/app/domain/interfaces/http_client.dart';
import 'package:clean_arch_app/app/infra/drivers/todo_source_interface.dart';
import 'package:clean_arch_app/app/infra/models/todo_model.dart';
import 'package:clean_arch_app/app/shared/failures.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/core/injection.dart';

class TodoSource implements TodoSourceInterface {
  final _httpClient = injection.get<HttpClientInterface>();

  @override
  Future<Result<List<TodoModel>>> getTodos(int userId) async {
    try {
      final result = await _httpClient.get('/todos/user/$userId');

      if (result is ResultError) {
        return Result.error(result.error);
      }

      if (result is! Ok) {
        return Result.error(TodoSourceDefaultFailure());
      }

      final data = result.value;
      if (data is! Map<String, dynamic> || data['todos'] is! List) {
        return Result.error(TodoSourceInvalidFormatFailure());
      }

      final todos = (data['todos'] as List)
          .map(
            (item) => TodoModel.fromMap(Map<String, dynamic>.from(item as Map)),
          )
          .toList();

      return Result.ok(todos);
    } catch (e) {
      return Result.error(ExceptionToFailure(message: e.toString()));
    }
  }
}
