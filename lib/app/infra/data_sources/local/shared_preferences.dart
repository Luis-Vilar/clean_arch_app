import 'dart:convert';

import 'package:clean_arch_app/app/domain/entities/user_entity.dart';
import 'package:clean_arch_app/app/domain/interfaces/shared_preferences_interface.dart';
import 'package:clean_arch_app/app/infra/models/user_model.dart';
import 'package:clean_arch_app/app/shared/failures.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefImplementation implements SharedPrefInterface {
  static String sessionDataKey = 'sessionData';

  @override
  Future<void> saveSessionData(UserLoggedEntity user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      sessionDataKey,
      jsonEncode(UserLoggedModel.fromEntity(user).toMap()),
    );
  }

  @override
  Future<Result<UserLoggedEntity>> getSessionData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final session = prefs.getString(sessionDataKey);

      //! inicio de Gambiarra
      // pequeno delay para dar tempo de renderizar a Image.asset do
      // SplashScreen cuando inicializa o app y verifica a sessão.
      await Future.delayed(Duration(milliseconds: 400));
      //! fim da gambiarra...

      if (session == null) {
        return Result.error(SharedPreferencesNoSessionFoundFailure());
      }

      final json = jsonDecode(session) as Map<String, dynamic>;
      final user = UserLoggedModel.fromMap(json).toEntity();
      return Result.ok(user);
    } catch (error) {
      return Result.error(ExceptionToFailure(message: error.toString()));
    }
  }

  @override
  Future<void> removeSessionData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(sessionDataKey);
  }
}
