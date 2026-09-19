import 'package:clean_arch_app/app/presenter/views/about/about_page.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AboutPage());
  }
}
