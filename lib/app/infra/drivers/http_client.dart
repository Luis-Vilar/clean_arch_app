import 'package:clean_arch_app/app/shared/result.dart';

abstract class HttpClientInterface {
  Future<Result> get(String endpoint, {Map<String, String>? headers});

  Future<Result> post(
    String endpoint, {
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  });
}
