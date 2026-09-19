sealed class Failure implements Exception {
  Failure({required this.message});
  String message;
}

final class SqfliteFailure extends Failure {
  SqfliteFailure({required super.message});
}
