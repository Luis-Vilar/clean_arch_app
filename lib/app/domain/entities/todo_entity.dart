class TodoEntity {
  int id;
  String title;
  String todo;
  DateTime createdAt;
  bool completed;
  TodoEntity({
    required this.id,
    required this.title,
    required this.todo,
    required this.createdAt,
    required this.completed,
  });
}
