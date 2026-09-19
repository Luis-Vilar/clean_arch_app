sealed class Failure {
  final String message;

  Failure({required this.message});
}

final class SqfliteFailure implements Failure {
  @override
  String get message => 'No foi possível manipular a base de dados.';
}
