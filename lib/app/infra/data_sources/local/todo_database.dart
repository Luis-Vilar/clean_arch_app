// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';
import 'package:clean_arch_app/app/infra/drivers/todo_database_interface.dart';
import 'package:clean_arch_app/app/infra/models/todo_model.dart';
import 'package:clean_arch_app/app/shared/db_helper.dart';
import 'package:clean_arch_app/app/shared/failures.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:sqflite/sql.dart';

class TodoDatabaseSqfliteImplementation implements TodoDatabaseInterface {
  static const String _tableName = 'todos';

  @override
  Future<Result<TodoEntity>> insertTodo(TodoEntity todo) async {
    final database = await DbHelper.db;
    try {
      await database.insert(_tableName, {
        'id': todo.id,
        'todo': todo.todo,
        'completed': todo.completed ? 1 : 0,
        'userId': todo.userId,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
      return Result.ok(todo);
    } catch (error) {
      log(error.toString());
      return Result.error(SqfliteFailure());
    }
  }

  @override
  Future<Result<TodoEntity>> deleteTodo(TodoEntity todo) async {
    final database = await DbHelper.db;

    try {
      await database.delete(_tableName, where: 'id = ?', whereArgs: [todo.id]);
      return Result.ok(todo);
    } catch (error) {
      log(error.toString());

      return Result.error(SqfliteFailure());
    }
  }

  @override
  Future<Result<List<TodoEntity>>> getAllTodos() async {
    final database = await DbHelper.db;

    try {
      final rows = await database.query(_tableName);

      List<TodoEntity> todos = rows
          .map((todo) => TodoModel.fromMap(todo))
          .toList();
      return Result.ok(todos);
    } catch (error) {
      log(error.toString());

      return Result.error(SqfliteFailure());
    }
  }

  @override
  Future<Result<TodoEntity>> updateTodo(TodoEntity todo) async {
    final database = await DbHelper.db;

    try {
      await database.update(
        _tableName,
        {'todo': todo.todo, 'completed': todo.completed ? 1 : 0},
        where: 'id = ?',
        whereArgs: [todo.id],
      );
      return Result.ok(todo);
    } catch (error) {
      log(error.toString());

      return Result.error(SqfliteFailure());
    }
  }
}
