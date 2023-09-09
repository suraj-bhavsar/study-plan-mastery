import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_plan_student_dashboard/app/widgets/animated_pulse_container.dart';
import 'package:study_plan_student_dashboard/app/widgets/student_mastery_tile.dart';
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
                      Spacer(),
                      IconButton(
                        onPressed: controller.search,
                        icon: Icon(Icons.search),
                        color: Colors.white,
                        iconSize: 24,
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
                      return StudentMasteryTile(
                        mastery: controller.studentsData[index],
                      );
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
