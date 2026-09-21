import 'package:clean_arch_app/app/domain/interfaces/http_client.dart';
import 'package:clean_arch_app/app/shared/failures.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:dio/dio.dart';

final class HttpClientDio implements HttpClientInterface {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com/',
      connectTimeout: Duration(milliseconds: 5000),
    ),
  );

  @override
  Future<Result> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(
        endpoint,
        options: Options(headers: headers),
      );

      return Result.ok(response.data);
    } on DioException catch (error) {
      return Result.error(_toFailure(error));
    } on Exception catch (error) {
      return Result.error(ExceptionToFailure(message: error.toString()));
    }
  }

  @override
  Future<Result> post(
    String endpoint, {
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: body,
        options: Options(headers: headers),
      );
      return Result.ok(response.data);
    } on DioException catch (error) {
      return Result.error(_toFailure(error));
    } on Exception catch (error) {
      return Result.error(ExceptionToFailure(message: error.toString()));
    }
  }

  Failure _toFailure(DioException error) {
    final failure = switch (error.type) {
      DioExceptionType.badCertificate => DioBadCertificateFailure(),
      DioExceptionType.badResponse => DioBadResponseFailure(),
      DioExceptionType.connectionError => DioConnectionErrorFailure(),
      DioExceptionType.connectionTimeout => DioConnectionTimeoutFailure(),
      DioExceptionType.cancel => DioCancelFailure(),
      DioExceptionType.receiveTimeout => DioReceiveTimeoutFailure(),
      DioExceptionType.sendTimeout => DioSendTimeoutFailure(),
      DioExceptionType.transformTimeout => DioTransformTimeoutFailure(),
      DioExceptionType.unknown => DioUnknownFailure(),
    };

    return failure;
  }
}
