import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:study_plan_student_dashboard/app/widgets/animated_pulse_container.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF242b4d),
      body: Obx(() {
        switch (controller.masteryState) {
          case WidgetState.initial:
          case WidgetState.loading:
            return Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedPulseContainer(
                  child: Image.asset(
                    'assets/images/cosmos.png',
                    height: Get.height / 3,
                    width: Get.height / 3,
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  'Our journey to the cosmos has begun!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Students mastery is currently being fetched for our space quest.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ));
          case WidgetState.error:
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Something Went Wrong',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: controller.getData,
                    child: Text(
                      'TRY AGAIN',
                    ),
                  ),
                ],
              ),
            );
          case WidgetState.success:
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.black12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 64,
                        width: 64,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Daily Progress Towards Mastery',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(
                      bottom: 100,
                      top: 24,
                      left: 16,
                      right: 16,
                    ),
                    itemBuilder: (context, index) {
                      return DataTile(mastery: controller.studentsData[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.white,
                        thickness: 0.5,
                        height: 50,
                      );
                    },
                    itemCount: controller.studentsData.length,
                  ),
                ),
              ],
            );
        }
      }),
    );
  }
}

class DataTile extends StatelessWidget {
  final StudentOverallMasteryData mastery;
  const DataTile({super.key, required this.mastery});

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

class MasteryGraph extends GetView<HomeController> {
  final StudentSubjectMastery mastery;

  MasteryGraph(this.mastery);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 300,
          width: 300,
          padding: EdgeInsets.only(
            left: 20,
            top: 12,
            right: 12,
            bottom: 4,
          ),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                verticalInterval: 10,
                horizontalInterval: 10,
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 10.0,
                    reservedSize: 32,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        '$value%',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1.0,
                    reservedSize: 32,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index >= 0 &&
                          index < mastery.achievedMasteryData.length) {
                        final date =
                            DateTime.parse(mastery.dates.elementAt(index));
                        final day = date.day;
                        final month = date.month.monthName.substring(0, 4);
                        return Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            '$day\n$month',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: Colors.white54,
                  width: 1,
                ),
              ),
              minX: 0,
              maxX: mastery.achievedMasteryData.length.toDouble() - 1,
              minY: 0,
              maxY: 100,
              lineBarsData: [
                LineChartBarData(
                  spots: mastery.expectedMasteryData,
                  isCurved: false,
                  color: Color(0xFFFC7A42),
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                ),
                LineChartBarData(
                  spots: mastery.achievedMasteryData,
                  isCurved: false,
                  color: Color(0xFF3DBCA1),
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFC7A42),
                        shape: BoxShape.circle,
                      ),
                      height: 8,
                      width: 8,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Expected Mastery',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF3DBCA1),
                        shape: BoxShape.circle,
                      ),
                      height: 8,
                      width: 8,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Achieved Mastery',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              mastery.subjectName.toUpperCase(),
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFF3AB04),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
