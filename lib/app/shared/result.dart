import 'package:clean_arch_app/app/shared/failures.dart';

sealed class Result<T> {
  const Result();

  /// Creates an instance of Result containing a value
  factory Result.ok(T value) => Ok(value);

  /// Create an instance of Result containing an error
  factory Result.error(Failure error) => ResultError(error);
}

/// Subclass of Result for values
final class Ok<T> extends Result<T> {
  const Ok(this.value);

  /// Returned value in result
  final T value;
}

/// Subclass of Result for errors
final class ResultError<T> extends Result<T> {
  const ResultError(this.error);

  /// Returned error in result
  final Failure error;
}
