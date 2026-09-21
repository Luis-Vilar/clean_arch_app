import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';

final class TodoModel extends TodoEntity {
  TodoModel({
    required super.id,
    required super.todo,
    required super.completed,
    required super.userId,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) => TodoModel(
    id: map['id'],
    todo: map['todo'],
    completed: map['completed'] is int
        ? map['completed'] == 1
        : map['completed'] as bool,
    userId: map['userId'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'todo': todo,
    'completed': completed ? 1 : 0,
    'userId': userId,
  };

  factory TodoModel.fromEntity(TodoEntity entity) => TodoModel(
    id: entity.id,
    todo: entity.todo,
    completed: entity.completed,
    userId: entity.userId,
  );
}
