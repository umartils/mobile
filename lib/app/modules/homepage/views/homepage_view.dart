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

import '../controllers/homepage_controller.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  _HomepageViewState createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  final HomepageController controller = Get.put(HomepageController());

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(
            left: 3,
            top: 10,
          ),
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
            padding: const EdgeInsets.only(top: 7, right: 20),
            child: Obx(() {
              if (controller.imageUrl.value.isNotEmpty) {
                return GestureDetector(
                  onTap: () {
                    // Aksi logout
                    SpUtil.clear(); // Membersihkan data user
                    Get.offAllNamed(Routes.LOGIN); // Navigasi ke halaman login
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
                      radius: 22, // Sesuaikan ukuran avatar
                      backgroundImage:
                          NetworkImage("${controller.imageUrl.value}"),
                      onBackgroundImageError: (_, __) {
                        // Jika URL gambar gagal dimuat, tampilkan placeholder
                        print("Failed to load user image.");
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
                  Container(
                    width: 320,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: const DecorationImage(
                          image: AssetImage("asset/images/image.png"),
                          fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.TAMBAH_TASK),
                    child: Container(
                      width: 160,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: primary, width: 2.0), // Tambahkan border
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
                          "Buat Daftar Tugasmu",
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
              )
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0), // Jarak ke kiri
                child: Text(
                  "Untuk Anda",
                  style: GoogleFonts.sora(
                    color: secondchoice,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0, left: 13.0, bottom: 20),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
