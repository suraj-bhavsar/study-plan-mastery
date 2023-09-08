import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:study_plan_student_dashboard/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final botToastBuilder = BotToastInit();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Study Plan Mastery",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return child;
      },
    ),
  );
}
