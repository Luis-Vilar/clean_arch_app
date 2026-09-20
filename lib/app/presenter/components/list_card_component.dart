import 'package:clean_arch_app/app/domain/entities/todo_entity.dart';
import 'package:clean_arch_app/app/infra/models/todo_model.dart';
import 'package:clean_arch_app/app/presenter/components/confirm_dialog.dart';
import 'package:clean_arch_app/app/presenter/view_models/bloc/todos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListCardComponent extends StatelessWidget {
  const ListCardComponent({
    super.key,
    required this.todo,
    required this.listViewContext,
  });

  final TodoEntity todo;
  final BuildContext listViewContext;

  void _showDeleteDialog() => confirmDialog(
    context: listViewContext,
    action: () =>
        listViewContext.read<TodosBloc>().add(TodosDeleteEvent(todo: todo)),
    titleText: 'Deletar tarefa?',
    contentText: 'Tem certeza que deseja deletar a tarefa?',
    notConfirmButtonText: 'Cancelar',
    confirmButtonText: 'Deletar',
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        value: todo.completed,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          todo.todo,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            decoration: todo.completed
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text('ID da Tarefa: ${todo.id}'),
        secondary: todo.completed
            ? IconButton(
                onPressed: _showDeleteDialog,
                icon: const Icon(Icons.delete, color: Colors.redAccent),
              )
            : null,
        onChanged: (completed) {
          if (completed == null) return;
          listViewContext.read<TodosBloc>().add(
            TodosUpdateEvent(
              todo: TodoModel(
                id: todo.id,
                todo: todo.todo,
                completed: completed,
                userId: todo.userId,
              ),
            ),
          );
        },
      ),
    );
  }
}
