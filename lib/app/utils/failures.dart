sealed class Failure implements Exception {
  Failure({required this.message});
  String message;
}
