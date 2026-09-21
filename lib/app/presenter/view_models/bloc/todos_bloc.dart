import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';
import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/domain/use_cases/todo/create_todo_case.dart';
import 'package:clean_arch_app/app/domain/use_cases/todo/delete_todo_case.dart';
import 'package:clean_arch_app/app/domain/use_cases/todo/read_todos_case.dart';
import 'package:clean_arch_app/app/domain/use_cases/todo/sync_todo_case.dart';
import 'package:clean_arch_app/app/domain/use_cases/todo/update_todo_case.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/app/shared/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final _create = CreateTodoCase();
  final _read = ReadTodosCase();
  final _update = UpdateTodoCase();
  final _delete = DeleteTodoCase();
  final _sync = SyncTodoCase();

  TodosBloc() : super(TodosInitial()) {
    on<TodosCreateEvent>((event, emit) async {
      emit(TodosLoading());

      final createResult = await _create(event.todo);
      if (createResult is ResultError<TodoEntity>) {
        emit(TodosError(message: createResult.error.message));
        return;
      }

      await _loadTodos(emit);
    });

    on<TodosReadEvent>((event, emit) async {
      await _loadTodos(emit);
    });

    on<TodosUpdateEvent>((event, emit) async {
      emit(TodosLoading());

      final updateResult = await _update(event.todo);
      if (updateResult is ResultError<TodoEntity>) {
        emit(TodosError(message: updateResult.error.message));
        return;
      }

      await _loadTodos(emit);
    });

    on<TodosDeleteEvent>((event, emit) async {
      emit(TodosLoading());

      final deleteResult = await _delete(event.todo);
      if (deleteResult is ResultError<TodoEntity>) {
        emit(TodosError(message: deleteResult.error.message));
        return;
      }

      await _loadTodos(emit);
    });

    on<TodosSyncEvent>((event, emit) async {
      emit(TodosLoading());

      final syncResult = await _sync(event.user);
      if (syncResult is ResultError<List<TodoEntity>>) {
        emit(TodosError(message: syncResult.error.message));
        return;
      }

      if (syncResult is Ok<List<TodoEntity>>) {
        emit(TodosSuccess(todos: syncResult.value));
        return;
      }

      emit(TodosError(message: 'No se pudo sincronizar los todos.'));
    });
  }

  Future<void> _loadTodos(Emitter<TodosState> emit) async {
    final result = await _read(NoParams());

    if (result is Ok<List<TodoEntity>>) {
      emit(TodosSuccess(todos: result.value));
      return;
    }

    if (result is ResultError<List<TodoEntity>>) {
      emit(TodosError(message: result.error.message));
    }
  }
}
