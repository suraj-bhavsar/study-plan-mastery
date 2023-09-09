import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:study_plan_student_dashboard/app/modules/home/controllers/home_controller.dart';

class MasteryGraph extends StatelessWidget {
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
              showingTooltipIndicators: [
                ShowingTooltipIndicators(
                  [
                    LineBarSpot(
                      LineChartBarData(spots: mastery.expectedMasteryData),
                      1,
                      mastery.expectedMasteryData[2],
                    ),
                  ],
                )
              ],
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
