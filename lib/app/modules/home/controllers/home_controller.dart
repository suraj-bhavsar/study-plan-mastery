import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:study_plan_student_dashboard/app/constants.dart';
import 'package:study_plan_student_dashboard/app/data/models/response/lo_stats.dart';
import 'package:study_plan_student_dashboard/app/modules/search_page/controllers/search_page_controller.dart';
import 'package:study_plan_student_dashboard/app/routes/app_pages.dart';

class StudentOverallMasteryData {
  final String studentName;
  final String grade;
  final List<StudentSubjectMastery> subjects;

  StudentOverallMasteryData({
    required this.subjects,
    required this.studentName,
    required this.grade,
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

  final _masteryState = WidgetState.initial.obs;
  WidgetState get masteryState => this._masteryState.value;
  set masteryState(WidgetState value) => this._masteryState.value = value;

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
        connectTimeout: Duration(seconds: 60),
        receiveTimeout: Duration(seconds: 60),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {
          HttpHeaders.acceptHeader: Headers.jsonContentType,
        },
        baseUrl: 'https://api.questt.com/api/v4',
      ),
    );
  }

  void getData() async {
    try {
      masteryState = WidgetState.initial;
      final now = DateTime.now();
      final todaysDate = DateTime(now.year, now.month, now.day);
      final startDate = todaysDate.subtract(const Duration(days: 7));
      final query = {
        'navigator_user_id': navigatorUserIds.toSet().join(','),
        'start_date': Jiffy(startDate).format('yyyy-MM-dd'),
        'end_date': Jiffy(todaysDate).format('yyyy-MM-dd'),
      };
      final response = await dio.get(
        '/studyplan/coaches/daily-mastery',
        queryParameters: query,
      );
      Map<String, dynamic> data = response.data["data"];
      // Access values from the "data" map
      List<dynamic> overall = data["overall"];

      // Access nested values within "overall" list
      for (var item in overall) {
        String name = item["name"];
        String grade = item["grade"];
        List<dynamic> mastery = item["mastery"];
        List<StudentSubjectMastery> subjects = [];
        // Access nested values within the "mastery" list
        for (var subject in mastery) {
          String subjectName = subject["subject_name"];
          Map<String, dynamic> calendar = subject["calendar"];

          subjects.add(StudentSubjectMastery(
            expectedMasteryData: getExpectedMasteryDataPoints(calendar),
            achievedMasteryData: getAchievedMasteryDataPoints(calendar),
            dates: calendar.keys.toList(),
            subjectName: subjectName,
          ));
        }
        if (subjects.isNotEmpty) {
          studentsData.add(StudentOverallMasteryData(
            subjects: subjects,
            studentName: name,
            grade: grade,
          ));
        }
      }
      masteryState = WidgetState.success;
    } catch (e) {
      masteryState = WidgetState.error;
    }
  }

  Future<LoStatsResponse> getLoStats(String loId) async {
    try {
      return LoStatsResponse();
    } catch (e) {
      throw e;
    }
  }

  List<FlSpot> getExpectedMasteryDataPoints(Map<String, dynamic> data) {
    List<FlSpot> dataPoints = [];
    int dayCount = 0;

    data.forEach((date, values) {
      int expectedMastery = values['expected_mastery'] ?? 0;
      dataPoints.add(FlSpot(dayCount.toDouble(), expectedMastery.toDouble()));
      dayCount++;
    });

    return dataPoints;
  }

  List<FlSpot> getAchievedMasteryDataPoints(Map<String, dynamic> data) {
    List<FlSpot> dataPoints = [];
    int dayCount = 0;

    data.forEach((date, values) {
      int achievedMastery = values['achieved_mastery'] ?? 0;
      dataPoints.add(FlSpot(dayCount.toDouble(), achievedMastery.toDouble()));
      dayCount++;
    });

    return dataPoints;
  }

  void search() {
    Get.toNamed(
      Routes.SEARCH_PAGE,
      arguments: SearchPageArguments(mastery: studentsData),
    );
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

enum WidgetState { initial, loading, success, error }
