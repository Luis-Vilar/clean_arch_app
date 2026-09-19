import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';

final class TodoModel extends TodoEntity {
  TodoModel({
    required super.id,
    required super.title,
    required super.todo,
    required super.createdAt,
    required super.completed,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) => TodoModel(
    id: map['id'],
    title: map['title'],
    todo: map['todo'],
    createdAt: map['createdAt'] is String
        ? DateTime.parse(map['createdAt'] as String)
        : map['createdAt'] as DateTime,
    completed: map['completed'] is int
        ? map['completed'] == 1
        : map['completed'] as bool,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'todo': todo,
    'createdAt': createdAt.toIso8601String(),
    'completed': completed ? 1 : 0,
  };

  factory TodoModel.fromEntity(TodoEntity entity) => TodoModel(
    id: entity.id,
    title: entity.title,
    todo: entity.todo,
    createdAt: entity.createdAt,
    completed: entity.completed,
  );
}
