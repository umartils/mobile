import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:puu1/app/modules/homepage/views/section1.dart';
import 'package:puu1/app/modules/homepage/views/section2.dart';
import 'package:puu1/app/routes/app_pages.dart';
import 'package:puu1/global.dart';
import 'package:sp_util/sp_util.dart';
import '../controllers/content.dart';

import '../controllers/homepage_controller.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  _HomepageViewState createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  final HomepageController controller = Get.put(HomepageController());

  int currentIndex = 0; // Index untuk mengontrol konten
  late Timer _timer; // Timer untuk auto-slide

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      setState(() {
        currentIndex =
            (currentIndex + 1) % taskContents.length; // Ganti konten (loop)
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void changeContent() {
    setState(() {
      currentIndex = (currentIndex + 1) %
          taskContents.length; // Ganti konten manual (loop)
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(now);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(left: 3, top: 10),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedDate,
                  style: GoogleFonts.sora(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'Hi ${controller.nama.value}',
                  style: GoogleFonts.sora(
                    color: secondchoice,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 9, right: 20),
            child: Obx(() {
              if (controller.imageUrl.value.isNotEmpty) {
                return GestureDetector(
                  onTap: () {
                    showMenu(
                      context: context,
                      position: const RelativeRect.fromLTRB(200, 80, 10, 0),
                      items: [
                        const PopupMenuItem(
                          child: Text("Profile"),
                          value: "profile",
                        ),
                        PopupMenuItem(
                          child: Text("Logout"),
                          value: "logout",
                        ),
                      ],
                    ).then((value) {
                      if (value == "profile") {
                        // Navigasi ke halaman profil
                        Get.toNamed(Routes.PROFILE);
                      } else if (value == "logout") {
                        // Menampilkan dialog konfirmasi logout
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Logout"),
                              content: Text("Apakah Anda yakin ingin logout?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Tidak"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    SpUtil.clear();
                                    Get.offAllNamed(Routes.LOGIN);
                                  },
                                  child: Text("Ya"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });
                  },
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                      width: 49,
                      height: 49,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primary,
                          width: 5,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundImage:
                          NetworkImage("${controller.imageUrl.value}"),
                      onBackgroundImageError: (_, __) {
                        print("Failed to load user image."); // Debug
                      },
                    ),
                  ]),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: controller.refreshingController,
        onRefresh: controller.onRefresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 34,
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(seconds: 5),
                        child: Container(
                          key: ValueKey<int>(
                              currentIndex), // Berubah setiap index berubah
                          padding: const EdgeInsets.all(20),
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              image: AssetImage(
                                  taskContents[currentIndex].imagePath),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 2),
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: taskContents[currentIndex]
                            .onTap, // Gunakan aksi dari konten
                        child: Container(
                          width: 160,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: primary, width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 4),
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              taskContents[currentIndex].title,
                              style: GoogleFonts.sora(
                                color: primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Untuk Anda",
                  style: GoogleFonts.sora(
                    color: secondchoice,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SectionSatu(),
                      SizedBox(
                        height: 25,
                      ),
                      SectionDua()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
