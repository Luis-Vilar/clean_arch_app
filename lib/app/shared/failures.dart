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

final class DioBadCertificateFailure implements Failure {
  @override
  String get message => 'O certificado do servidor é inválido.';
}

final class DioBadResponseFailure implements Failure {
  @override
  String get message =>
      'A resposta da API não foi recebida corretamente, verifique suas credenciais.';
}

final class DioConnectionErrorFailure implements Failure {
  @override
  String get message => 'Sem internet? Verifique a conexão e tente novamente.';
}

final class DioConnectionTimeoutFailure implements Failure {
  @override
  String get message =>
      'Demorando para receber a resposta da API, verifique o sinal de internet.';
}

final class DioCancelFailure implements Failure {
  @override
  String get message => 'A requisição foi cancelada.';
}

final class DioReceiveTimeoutFailure implements Failure {
  @override
  String get message => 'Tempo limite ao receber a resposta da API.';
}

final class DioSendTimeoutFailure implements Failure {
  @override
  String get message => 'Tempo limite ao enviar a requisição.';
}

final class DioTransformTimeoutFailure implements Failure {
  @override
  String get message => 'Tempo limite durante a transformação dos dados.';
}

final class DioUnknownFailure implements Failure {
  @override
  String get message => 'Erro desconhecido ao comunicar com a API.';
}

final class TodoSourceDefaultFailure implements Failure {
  @override
  String get message => 'Resposta inválida da API de todos.';
}

final class TodoSourceInvalidFormatFailure implements Failure {
  @override
  String get message => 'Formato inválido da API de todos.';
}

final class SharedPreferencesNotSessionFoundFailure implements Failure {
  @override
  String get message => 'Não existe uma sessão salva.';
}
