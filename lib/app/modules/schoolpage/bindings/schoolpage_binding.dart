import 'package:get/get.dart';

import '../controllers/schoolpage_controller.dart';

class SchoolpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchoolpageController>(
      () => SchoolpageController(),
    );
  }
}
