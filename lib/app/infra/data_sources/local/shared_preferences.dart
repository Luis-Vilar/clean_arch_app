import 'dart:convert';

import 'package:clean_arch_app/app/infra/models/user_model.dart';
import 'package:clean_arch_app/app/shared/failures.dart';
import 'package:clean_arch_app/app/shared/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String sessionData = 'sessionData';

Future<void> saveSessionData(UserLoggedModel user) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(sessionData, jsonEncode(user.toJson()));
}

Future<Result<UserLoggedModel>> getSessionData() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final session = prefs.getString(sessionData);

    //! inicio de Gambiarra
    // pequeno delay para dar tempo de renderizar a Image.asset do
    // SplashScreen cuando inicializa o app y verifica a sessão.
    await Future.delayed(Duration(milliseconds: 400));
    //! fim da gambiarra...

    if (session == null) {
      return Result.error(SharedPreferencesNoSessionFoundFailure());
    }

    final json = jsonDecode(session) as Map<String, dynamic>;
    return Result.ok(UserLoggedModel.fromJson(json));
  } catch (error) {
    return Result.error(ExceptionToFailure(message: error.toString()));
  }
}

Future<void> removeSessionData() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.remove(sessionData);
}
