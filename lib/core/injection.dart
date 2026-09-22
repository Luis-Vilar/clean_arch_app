import 'package:clean_arch_app/app/domain/interfaces/auth.dart';
import 'package:clean_arch_app/app/domain/interfaces/http_client.dart';
import 'package:clean_arch_app/app/infra/drivers/preferences_interface.dart';
import 'package:clean_arch_app/app/infra/drivers/todo_database_interface.dart';
import 'package:clean_arch_app/app/infra/drivers/todo_repository_interface.dart';
import 'package:clean_arch_app/app/infra/drivers/todo_source_interface.dart';
import 'package:clean_arch_app/app/infra/data_sources/local/preferences.dart';
import 'package:clean_arch_app/app/infra/data_sources/local/todo_database.dart';
import 'package:clean_arch_app/app/infra/data_sources/remote/auth_source.dart';
import 'package:clean_arch_app/app/infra/data_sources/remote/http_client_dio.dart';
import 'package:clean_arch_app/app/infra/data_sources/remote/todo_source.dart';
import 'package:clean_arch_app/app/infra/repositories/todo_repository.dart';
import 'package:get_it/get_it.dart';

final injection = GetIt.instance;

void initDependencyInjection() {
  injection.registerLazySingleton<HttpClientInterface>(() => HttpClientDio());
  injection.registerLazySingleton<TodoRepositoryInterface>(
    () => TodoRepository(),
  );
  injection.registerLazySingleton<TodoDatabaseInterface>(
    () => TodoDatabaseSqfliteImplementation(),
  );
  injection.registerFactory<AuthInterface>(() => AuthSource());
  injection.registerFactory<TodoSourceInterface>(() => TodoSource());
  injection.registerFactory<PreferencesInterface>(() => SharedPref());
}
