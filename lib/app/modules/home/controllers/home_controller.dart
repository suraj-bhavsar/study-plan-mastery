import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:study_plan_student_dashboard/app/constants.dart';
import 'package:study_plan_student_dashboard/app/data/models/response/lo_stats.dart';
import 'package:study_plan_student_dashboard/app/data/models/response/study_plan_mastery_response.dart';
import 'package:study_plan_student_dashboard/app/widgets/loader.dart';
import 'package:study_plan_student_dashboard/app/widgets/toast_helper.dart';
import 'package:study_plan_student_dashboard/main.dart';

class StudentOverallMasteryData {
  final String studentName;
  final List<StudentSubjectMastery> subjects;

  StudentOverallMasteryData({
    required this.subjects,
    required this.studentName,
  });
}

class StudentSubjectMastery {
  final List<FlSpot> expectedMasteryData;
  final List<FlSpot> achievedMasteryData;
  final List<String> dates;
  final String subjectName;

  StudentSubjectMastery({
    required this.expectedMasteryData,
    required this.achievedMasteryData,
    required this.dates,
    required this.subjectName,
  });
}

class HomeController extends GetxController {
  final studentsData = List<StudentOverallMasteryData>.empty().obs;
  late Dio dio;

  @override
  void onInit() {
    _initialiseDio();
    getData();

    super.onInit();
  }

  void _initialiseDio() {
    dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 15),
        receiveTimeout: Duration(seconds: 15),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {
          HttpHeaders.acceptHeader: Headers.jsonContentType,
        },
        baseUrl: 'https://api.questt.com/api/v4',
      ),
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getData() async {
    List.generate(10, (index) {
      List<StudentSubjectMastery> subjects = [];
      json.forEach((key, value) {
        subjects.add(
          StudentSubjectMastery(
            expectedMasteryData:
                getExpectedMasteryDataPoints(value["calendar"]),
            achievedMasteryData:
                getAchievedMasteryDataPoints(value["calendar"]),
            dates: (value["calendar"] as Map<String, dynamic>).keys.toList(),
            subjectName: value["subject_name"],
          ),
        );
      });
      studentsData.add(
        StudentOverallMasteryData(
          subjects: subjects,
          studentName: 'Baccha',
        ),
      );
      return studentsData;
    });
  }

  Future<LoStatsResponse> getLoStats(String loId) async {
    try {
      return LoStatsResponse();
    } catch (e) {
      throw e;
    }
  }

  Future<void> getSingleData(String navigatorId) async {
    final response = StudyPlanMasteryResponse();
  }

  List<FlSpot> getExpectedMasteryDataPoints(Map<String, dynamic> data) {
    List<FlSpot> dataPoints = [];
    int dayCount = 0;

    data.forEach((date, values) {
      int expectedMastery = values['expected_mastery'];
      dataPoints.add(FlSpot(dayCount.toDouble(), expectedMastery.toDouble()));
      dayCount++;
    });

    return dataPoints;
  }

  List<FlSpot> getAchievedMasteryDataPoints(Map<String, dynamic> data) {
    List<FlSpot> dataPoints = [];
    int dayCount = 0;

    data.forEach((date, values) {
      int achievedMastery = values['achieved_mastery'];
      dataPoints.add(FlSpot(dayCount.toDouble(), achievedMastery.toDouble()));
      dayCount++;
    });

    return dataPoints;
  }
}

class Helper {
  // num getMastery(LoStats loStats, DateTime date) {
  //   if (loStats.progressHistory?.isEmpty ?? true) return 0;
  //   final history = loStats.progressHistory!;
  //   for (int i = history.length - 1; i >= 0; i--) {
  //     final d = history[i].createdAt!;
  //     if (d.isSameDateAs(date) || d.isBefore(date)) {
  //       return history[i].progress ?? 0;
  //     }
  //   }
  //   return 0;
  // }
}

extension DateExtension on DateTime {
  bool isSameDateAs(DateTime date) {
    return this.year == date.year &&
        this.month == date.month &&
        this.day == date.day;
  }
}

extension IntegerExtension on int {
  String get monthName {
    switch (this) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
    }
    return '';
  }
}
