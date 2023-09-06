import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
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
  final studentsMasteryData = List<StudentOverallMasteryData>.empty().obs;

  @override
  void onInit() {
    studentsMasteryData.assignAll(List.generate(50, (index) {
      return StudentOverallMasteryData(
        subjects: (json["progress"] as List)
            .map((e) => StudentSubjectMastery(
                  expectedMasteryData: getExpectedMasteryDataPoints(e["stats"]),
                  achievedMasteryData: getAchievedMasteryDataPoints(e["stats"]),
                  dates: (e["stats"] as Map<String, dynamic>).keys.toList(),
                  subjectName: e["subject_name"],
                ))
            .toList(),
        studentName: 'Student ${index + 1}',
      );
    }));
    super.onInit();
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
    try {
      Loader.show();
      // API CALL
      Loader.hide();
    } catch (e) {
      Loader.hide();
      ToastHelper.showError(message: 'Something went wrong');
    }
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
