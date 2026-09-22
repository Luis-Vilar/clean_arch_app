import 'dart:developer';

import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/domain/interfaces/auth.dart';
import 'package:clean_arch_app/app/infra/drivers/http_client.dart';
import 'package:clean_arch_app/app/shared/failures.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:clean_arch_app/core/injection.dart';

class AuthSource implements AuthInterface {
  final _httpClient = injection.get<HttpClientInterface>();

  @override
  Future<Result<UserLoggedEntity>> login(UserLoginEntity user) async {
    try {
      final result = await _httpClient.post(
        '/auth/login',
        body: {'username': user.username, 'password': user.password},
      );

      if (result is ResultError) {
        return Result.error(result.error);
      }

      if (result is Ok) {
        final payload = result.value;
        if (payload is Map<String, dynamic>) {
          final userLogged = UserLoggedEntity(
            username: payload['username'] as String,
            id: payload['id'] as int,
            email: payload['email'] as String,
            firstName: payload['firstName'] as String,
            lastName: payload['lastName'] as String,
            gender: payload['gender'] as String,
            image: payload['image'] as String,
            accessToken: payload['accessToken'] as String,
            refreshToken: payload['refreshToken'] as String,
          );
          log(userLogged.toString());
          return Result.ok(userLogged);
        }
      }

      return Result.error(DioDefaultFailure());
    } catch (e) {
      log(e.toString());
      return Result.error(ExceptionToFailure(message: e.toString()));
    }
  }
}
