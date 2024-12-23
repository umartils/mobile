import 'package:get/get.dart';

import '../controllers/tambah_task_controller.dart';

class TambahTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahTaskController>(
      () => TambahTaskController(),
    );
  }
}
