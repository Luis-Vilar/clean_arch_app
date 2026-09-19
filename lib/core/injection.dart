import 'package:clean_arch_app/app/domain/interfaces/todo_repository_interface.dart';
import 'package:clean_arch_app/app/infra/implementations/todo_repository.dart';
import 'package:get_it/get_it.dart';

final injection = GetIt.instance;

void initDependencyInjection() {
  injection.registerLazySingleton<TodoRepositoryInterface>(
    () => TodoRepository(),
  );
}
