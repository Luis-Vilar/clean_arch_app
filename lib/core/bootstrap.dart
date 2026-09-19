import 'dart:async';
import 'dart:developer';

import 'package:clean_arch_app/core/main_app.dart';
import 'package:flutter/material.dart';

void bootstrap() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();

      runApp(MainApp());
    },
    (error, stack) {
      log('Error : $error Stack : $stack');
    },
  );
}
