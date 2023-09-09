import 'package:get/get.dart';

import '../controllers/search_page_controller.dart';

class SearchPageBinding extends Bindings {
  @override
  void dependencies() {
    _setupArgs();
  }

  void _setupArgs() {
    final args = Get.arguments;
    SearchPageArguments? arguments;
    try {
      if (args is SearchPageArguments) {
        arguments = args;
      } else {
        // To be handled inside Controller
      }
    } catch (e) {
      // To be handled inside Controller
    }
    Get.lazyPut<SearchPageController>(
      () => SearchPageController(arguments: arguments),
    );
  }
}
