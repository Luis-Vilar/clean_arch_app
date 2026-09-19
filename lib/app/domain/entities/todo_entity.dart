abstract class TodoEntity {
  String title;
  String todo;
  DateTime createdAt;
  bool completed;
  TodoEntity({
    required this.title,
    required this.todo,
    required this.createdAt,
    required this.completed,
  });
}
