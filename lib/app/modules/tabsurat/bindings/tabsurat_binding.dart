import 'package:get/get.dart';
import '../controllers/tabsurat_controller.dart';

class TabsuratBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsuratController>(() => TabsuratController());
  }
}
