// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';
import 'package:clean_arch_app/app/infra/models/todo_model.dart';
import 'package:clean_arch_app/app/infra/utils/db_helper.dart';
import 'package:clean_arch_app/app/utils/failures.dart';
import 'package:clean_arch_app/app/utils/result.dart';

class TodoDatabase {
  Future<Result<TodoEntity>> insertTodo(TodoEntity todo) async {
    final database = await DbHelper.db;
    try {
      await database.insert('todo', {
        'id': todo.id,
        'title': todo.title,
        'todo': todo.todo,
        'createdAt': todo.createdAt.toIso8601String(),
        'completed': todo.completed ? 1 : 0,
      });
      return Result.ok(todo);
    } catch (error) {
      return Result.error(SqfliteFailure(message: error.toString()));
    }
  }

  Future<Result<TodoEntity>> deleteTodo(TodoEntity todo) async {
    final database = await DbHelper.db;

    try {
      await database.delete('todos', where: 'id = ?', whereArgs: [todo.id]);
      return Result.ok(todo);
    } catch (error) {
      return Result.error(SqfliteFailure(message: error.toString()));
    }
  }

  Future<Result<List<TodoEntity>>> getAllTodos() async {
    final database = await DbHelper.db;

    try {
      final rows = await database.query('todos');

      List<TodoEntity> todos = rows
          .map((todo) => TodoModel.fromMap(todo).toEntity())
          .toList();
      return Result.ok(todos);
    } catch (error) {
      return Result.error(SqfliteFailure(message: error.toString()));
    }
  }

  Future<Result<TodoEntity>> updateTodo(TodoEntity todo) async {
    final database = await DbHelper.db;

    try {
      await database.update(
        'todos',
        {'todo': todo.todo, 'completed': todo.completed ? 1 : 0},
        where: 'id = ?',
        whereArgs: [todo.id],
      );
      return Result.ok(todo);
    } catch (error) {
      return Result.error(SqfliteFailure(message: error.toString()));
    }
  }
}
