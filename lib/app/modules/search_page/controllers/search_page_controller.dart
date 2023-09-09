import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_plan_student_dashboard/app/modules/home/controllers/home_controller.dart';

class SearchPageArguments {
  final List<StudentOverallMasteryData> mastery;

  SearchPageArguments({required this.mastery});
}

class SearchPageController extends GetxController {
  final SearchPageArguments? arguments;
  SearchPageController({this.arguments});

  List<StudentOverallMasteryData>? get mastery => arguments?.mastery;

  bool _isValid = true;

  final filteredMastery = List<StudentOverallMasteryData>.empty().obs;

  final searchController = TextEditingController();

  final _query = ''.obs;
  String get query => this._query.value;
  set query(String value) => this._query.value = value;

  @override
  void onInit() {
    configure();
    super.onInit();
  }

  void configure() {
    _isValid = arguments != null && arguments is SearchPageArguments;
    if (!_isValid) {
      return;
    }
    filteredMastery.assignAll(mastery ?? []);
    debounce(
      _query,
      (callback) {
        _fetchSearchResults();
      },
      time: const Duration(milliseconds: 500),
    );
  }

  @override
  void onReady() {
    if (!_isValid) {
      Get.back();
      return;
    }
    super.onReady();
  }

  void _fetchSearchResults() {
    final filteredStudents = mastery
            ?.where((studentData) =>
                (studentData.studentName
                    .toLowerCase()
                    .contains(query.toLowerCase())) ||
                (studentData.grade.toLowerCase().contains(query.toLowerCase())))
            .toList() ??
        [];
    filteredMastery.assignAll(filteredStudents);
  }

  void onChangeQuery(String value) {
    query = value;
  }
}
