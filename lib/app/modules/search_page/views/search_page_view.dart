import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:study_plan_student_dashboard/app/constants.dart';
import 'package:study_plan_student_dashboard/app/widgets/student_mastery_tile.dart';

import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  const SearchPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF242b4d),
      body: Column(
        children: [
          _SearchField(),
          Obx(
            () => Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(
                  bottom: 100,
                  top: 24,
                  left: 16,
                  right: 16,
                ),
                itemBuilder: (context, index) {
                  return StudentMasteryTile(
                    mastery: controller.filteredMastery[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.white,
                    thickness: 0.5,
                    height: 50,
                  );
                },
                itemCount: controller.filteredMastery.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends GetView<SearchPageController> {
  const _SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: Get.back,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: CupertinoSearchTextField(
              itemSize: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white.withOpacity(0.2),
              ),
              prefixInsets: EdgeInsets.only(left: 20),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.white.withOpacity(0.6),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              controller: controller.searchController,
              placeholder: 'Search student by name/grade',
              autofocus: true,
              itemColor: AppColors.white.withOpacity(0.8),
              onChanged: controller.onChangeQuery,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
              placeholderStyle: TextStyle(
                fontSize: 16,
                color: AppColors.white.withOpacity(0.6),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
