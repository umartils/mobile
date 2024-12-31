import 'package:puu1/app/modules/absen/views/absen_view.dart';
import 'package:puu1/app/modules/history/views/history_view.dart';
import 'package:puu1/app/modules/profile/views/profile_view.dart';
import 'package:puu1/app/modules/todolist/views/todolist_view.dart';
import 'package:puu1/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puu1/global.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Untuk menggunakan SVG
import 'package:puu1/app/modules/homepage/views/homepage_view.dart';
import '../controllers/main_menu_controller.dart';

class MainMenuView extends GetView<MainMenuController> {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.tabIndex.value == 2) {
            Future.microtask(() => Get.toNamed(Routes.ABSEN));
            return const SizedBox(); // Placeholder untuk body
          } else {
            return IndexedStack(
              index: controller.tabIndex.value,
              children: [
                const HomepageView(),
                const TodolistView(),
                AbsenView(),
                const HistoryView(),
                const ProfileView(),
              ],
            );
          }
        }),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: secondchoice,
          // selectedItemColor: Colors.white,
          onTap: (index) {
            // Pindah tab atau halaman Absen
            if (index == 2) {
              Get.toNamed(Routes.ABSEN);
              controller.getLokasi;
            } else {
              controller.changeTabIndex(index);
            }
          },
          currentIndex: controller.tabIndex.value,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: _buildIconWithBorder(
                activeIconPath: "asset/icon/home-active.svg",
                inactiveIconPath: "asset/icon/home.svg",
                isSelected: controller.tabIndex.value == 0,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _buildIconWithBorder(
                activeIconPath: "asset/icon/todolist-active.svg",
                inactiveIconPath: "asset/icon/todolist.svg",
                isSelected: controller.tabIndex.value == 1,
              ),
              label: 'To Do List',
            ),
            BottomNavigationBarItem(
              icon: _buildIconWithBorder(
                activeIconPath: "asset/icon/positive-active.svg",
                inactiveIconPath: "asset/icon/positive.svg",
                isSelected: controller.tabIndex.value == 2,
              ),
              label: 'Absen',
            ),
            BottomNavigationBarItem(
              icon: _buildIconWithBorder(
                activeIconPath: "asset/icon/monitoring-active.svg",
                inactiveIconPath: "asset/icon/monitoring.svg",
                isSelected: controller.tabIndex.value == 3,
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: _buildIconWithBorder(
                activeIconPath: "asset/icon/profile-active.svg",
                inactiveIconPath: "asset/icon/profil.svg",
                isSelected: controller.tabIndex.value == 4,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  /// Fungsi untuk membuat ikon dengan border (bisa menggunakan SVG atau CupertinoIcon)
  Widget _buildIconWithBorder({
    required String activeIconPath, // Path untuk ikon yang aktif
    required String inactiveIconPath, // Path untuk ikon yang tidak aktif
    required bool isSelected,
  }) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // if (isSelected)
        //   Container(
        //     width: 70,
        //     height: 45,
        //     decoration: BoxDecoration(
        //       color: primary,
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //   ),
        SvgPicture.asset(
          isSelected
              ? activeIconPath
              : inactiveIconPath, // Ganti ikon sesuai status
          // color: isSelected ? Colors.white : Colors.black,
          width: 30,
          height: 30,
        ),
      ],
    );
  }
}
