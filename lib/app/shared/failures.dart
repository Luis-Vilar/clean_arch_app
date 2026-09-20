sealed class Failure {
  final String message;

  Failure({required this.message});
}

final class ExceptionToFailure implements Failure {
  @override
  String message;
  ExceptionToFailure({required this.message});
}

final class SqfliteFailure implements Failure {
  @override
  String get message => 'No foi possível manipular a base de dados.';
}

final class DioDefaultFailure implements Failure {
  @override
  String get message =>
      'Problemas com o cliente HTTP, tente novamente mais tarde.';
}

final class DioConnectionErrorFailure implements Failure {
  @override
  String get message => 'Sem internet?. Verifica a conexão e tenta novamente';
}

final class DioConnectionTimeoutFailure implements Failure {
  @override
  String get message =>
      'Demorando para receber a resposta da API, verifique o sinal de internet';
}

final class TodoSourceDefaultFailure implements Failure {
  @override
  String get message => 'Resposta inválida da API de todos.';
}

final class TodoSourceInvalidFormatFailure implements Failure {
  @override
  String get message => 'Formato inválido da API de todos.';
}

final class SharedPreferencesNoSessionFoundFailure implements Failure {
  @override
  String get message => 'Não existe uma sessão salva.';
}
