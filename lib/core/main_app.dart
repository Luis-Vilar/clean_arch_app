import 'package:clean_arch_app/core/dark_theme.dart';
import 'package:clean_arch_app/core/light_theme.dart';
import 'package:clean_arch_app/core/routes.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.login,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
