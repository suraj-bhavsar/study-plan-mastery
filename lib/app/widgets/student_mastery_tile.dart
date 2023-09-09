import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_plan_student_dashboard/app/modules/home/controllers/home_controller.dart';
import 'package:study_plan_student_dashboard/app/widgets/mastery_graph.dart';

class StudentMasteryTile extends StatelessWidget {
  final StudentOverallMasteryData mastery;
  const StudentMasteryTile({super.key, required this.mastery});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            (mastery.studentName.capitalize ?? '') + ' (${mastery.grade})',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xffFFB000),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: mastery.subjects
              .map((e) => Expanded(child: MasteryGraph(e)))
              .toList(),
        ),
      ],
    );
  }
}
