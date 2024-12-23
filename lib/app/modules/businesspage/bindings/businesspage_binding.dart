import 'package:get/get.dart';

import '../controllers/businesspage_controller.dart';

class BusinesspageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusinesspageController>(
      () => BusinesspageController(),
    );
  }
}
