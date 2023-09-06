import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return DataTile(mastery: controller.studentsMasteryData[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.black,
            thickness: 0.5,
            height: 32,
          );
        },
        itemCount: controller.studentsMasteryData.length,
      ),
    );
  }
}

class DataTile extends StatelessWidget {
  final StudentOverallMasteryData mastery;
  const DataTile({super.key, required this.mastery});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            mastery.studentName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.blueAccent,
            ),
          ),
        ),
        SizedBox(width: 8),
        ...mastery.subjects
            .map((e) => Expanded(child: MasteryGraph(e)))
            .toList(),
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
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
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
                        final date = mastery.dates.elementAt(index);
                        final day = date.substring(0, 2);
                        final month = date.substring(2);
                        return Text(
                          '${day.trim()}\n${month.trim()}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
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
                  color: const Color(0xff37434d),
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
                  color: Colors.blue,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
                LineChartBarData(
                  spots: mastery.achievedMasteryData,
                  isCurved: false,
                  color: Colors.green,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
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
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      height: 10,
                      width: 10,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Expected Mastery',
                      style: TextStyle(
                        color: Colors.black,
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
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      height: 10,
                      width: 10,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Achieved Mastery',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              mastery.subjectName,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
