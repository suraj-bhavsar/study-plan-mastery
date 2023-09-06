// @dart=2.15

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:study_plan_student_dashboard/app/constants.dart';

class Loader {
  static var _isLoaderShowing = false;

  static void show() {
    if (!_isLoaderShowing) {
      Get.dialog(
        WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Center(
            child: SpinKitDoubleBounce(
              color: AppColors.primary,
              size: 36,
            ),
          ),
        ),
        barrierDismissible: false,
      );
      _isLoaderShowing = true;
    } else {
      hide();
      show();
    }
  }

  static void hide() {
    if (_isLoaderShowing) {
      Get.back();
      _isLoaderShowing = false;
    }
  }
}

class LoaderWidget extends StatelessWidget {
  final double size;
  const LoaderWidget({Key? key, this.size = 36}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitDoubleBounce(
          color: AppColors.primary,
          size: size,
        ),
      ),
    );
  }
}
