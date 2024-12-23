import 'package:get/get.dart';

import '../controllers/tababsen_controller.dart';

class TababsenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TababsenController>(
      () => TababsenController(),
    );
  }
}
