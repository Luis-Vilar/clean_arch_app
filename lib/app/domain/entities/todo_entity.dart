class TodoEntity {
  int id;
  int userId;
  String todo;
  bool completed;

  TodoEntity({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });
}
