import 'package:get/get.dart';

import '../modules/MainMenu/bindings/main_menu_binding.dart';
import '../modules/MainMenu/views/main_menu_view.dart';
import '../modules/absen/bindings/absen_binding.dart';
import '../modules/absen/views/absen_view.dart';
import '../modules/businesspage/bindings/businesspage_binding.dart';
import '../modules/businesspage/views/businesspage_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/homepage/bindings/homepage_binding.dart';
import '../modules/homepage/views/homepage_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/schoolpage/bindings/schoolpage_binding.dart';
import '../modules/schoolpage/views/schoolpage_view.dart';
import '../modules/tababsen/bindings/tababsen_binding.dart';
import '../modules/tababsen/views/tababsen_view.dart';
import '../modules/tabsurat/bindings/tabsurat_binding.dart';
import '../modules/tabsurat/views/tabsurat_view.dart';
import '../modules/tambahTask/bindings/tambah_task_binding.dart';
import '../modules/tambahTask/views/tambah_task_view.dart';
import '../modules/todolist/bindings/todolist_binding.dart';
import '../modules/todolist/views/todolist_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_MENU,
      page: () => const MainMenuView(),
      binding: MainMenuBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => const HomepageView(),
      binding: HomepageBinding(),
    ),
    GetPage(
      name: _Paths.BUSINESSPAGE,
      page: () => const BusinesspageView(),
      binding: BusinesspageBinding(),
    ),
    GetPage(
      name: _Paths.SCHOOLPAGE,
      page: () => const SchoolpageView(),
      binding: SchoolpageBinding(),
    ),
    GetPage(
      name: _Paths.ABSEN,
      page: () => AbsenView(),
      binding: AbsenBinding(),
    ),
    GetPage(
      name: _Paths.TABSURAT,
      page: () => const TabsuratView(),
      binding: TabsuratBinding(),
    ),
    GetPage(
      name: _Paths.TABABSEN,
      page: () => const TababsenView(),
      binding: TababsenBinding(),
    ),
    GetPage(
      name: _Paths.TODOLIST,
      page: () => const TodolistView(),
      binding: TodolistBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_TASK,
      page: () => const TambahTaskView(),
      binding: TambahTaskBinding(),
      
    ),
  ];
}
