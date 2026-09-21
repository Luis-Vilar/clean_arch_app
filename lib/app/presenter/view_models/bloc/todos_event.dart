part of 'todos_bloc.dart';

sealed class TodosEvent {}

final class TodosSyncEvent extends TodosEvent {
  TodosSyncEvent({required this.user});

  final UserLoggedEntity user;
}

final class TodosCreateEvent extends TodosEvent {
  TodosCreateEvent({required this.todo});

  final TodoEntity todo;
}

final class TodosReadEvent extends TodosEvent {
  TodosReadEvent({this.userId});

  final int? userId;
}

final class TodosUpdateEvent extends TodosEvent {
  TodosUpdateEvent({required this.todo});

  final TodoEntity todo;
}

final class TodosDeleteEvent extends TodosEvent {
  TodosDeleteEvent({required this.todo});

  final TodoEntity todo;
}
