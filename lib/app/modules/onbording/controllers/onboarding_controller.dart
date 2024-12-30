import 'package:get/get.dart';
import 'package:puu1/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  void onTapLogin() {
    Get.toNamed(Routes.LOGIN);
  }

  void onTapRegister() {
    Get.toNamed(Routes.REGISTER);
  }
}
