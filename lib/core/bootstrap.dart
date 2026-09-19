import 'dart:async';
import 'dart:developer';

import 'package:clean_arch_app/app/shared/db_helper.dart';
import 'package:clean_arch_app/core/injection.dart';
import 'package:clean_arch_app/core/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void bootstrap() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      await DbHelper.db;
      initDependencyInjection();

      runApp(MainApp());
    },
    (error, stack) {
      log('Error : $error Stack : $stack');
    },
  );
}
