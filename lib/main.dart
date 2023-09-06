import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final botToastBuilder = BotToastInit();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return child;
      },
    ),
  );
}

final json = {
  "progress": [
    {
      "subject_id": "#subjectid",
      "subject_name": "Maths",
      "total_mastery_possible": 80,
      "expected_mastery_till_today": 45,
      "achieved_mastery": 20,
      "stats": {
        "1 Sept": {
          "expected_mastery": 10,
          "achieved_mastery": 3,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        },
        "2 Sept": {
          "expected_mastery": 20,
          "achieved_mastery": 6,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        },
        "3 Sept": {
          "expected_mastery": 30,
          "achieved_mastery": 8,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        },
        "4 Sept": {
          "expected_mastery": 40,
          "achieved_mastery": 16,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        },
        "5 Sept": {
          "expected_mastery": 50,
          "achieved_mastery": 34,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        }
      }
    },
    {
      "subject_id": "#subjectid",
      "subject_name": "Science",
      "total_mastery_possible": 80,
      "expected_mastery_till_today": 45,
      "achieved_mastery": 20,
      "stats": {
        "1 Sept": {
          "expected_mastery": 10,
          "achieved_mastery": 3,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        },
        "2 Sept": {
          "expected_mastery": 20,
          "achieved_mastery": 6,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        },
        "3 Sept": {
          "expected_mastery": 30,
          "achieved_mastery": 8,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        },
        "4 Sept": {
          "expected_mastery": 40,
          "achieved_mastery": 16,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        },
        "5 Sept": {
          "expected_mastery": 50,
          "achieved_mastery": 34,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        }
      }
    },
    {
      "subject_id": "#subjectid",
      "subject_name": "SST",
      "total_mastery_possible": 80,
      "expected_mastery_till_today": 45,
      "achieved_mastery": 20,
      "stats": {
        "1 Sept": {
          "expected_mastery": 10,
          "achieved_mastery": 3,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        },
        "2 Sept": {
          "expected_mastery": 20,
          "achieved_mastery": 6,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        },
        "3 Sept": {
          "expected_mastery": 30,
          "achieved_mastery": 8,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        },
        "4 Sept": {
          "expected_mastery": 40,
          "achieved_mastery": 16,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        },
        "5 Sept": {
          "expected_mastery": 50,
          "achieved_mastery": 34,
          "los_attempted_this_day": 4,
          "los_mastered_this_day": 1
        }
      }
    },
  ]
};
