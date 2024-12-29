import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:puu1/app/modules/profile/views/button.dart';
import 'package:puu1/app/modules/profile/views/gambar.dart';
import 'package:puu1/app/modules/profile/views/update.dart';
import 'package:puu1/app/routes/app_pages.dart';
import 'package:puu1/global.dart';
import 'package:sp_util/sp_util.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(
        //   CupertinoIcons.person_alt_circle_fill,
        //   color: primary, weight: 10,
        // ),
        title: Text(
          'Profile',
          style: GoogleFonts.sora(
              color: primary, fontWeight: FontWeight.w600, fontSize: 24),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => Center(
            child: SmartRefresher(
              controller: controller.refreshController,
              onRefresh: controller.onRefresh,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment
                          .center, // Pastikan posisi center untuk avatar
                      children: [
                        // Border mengikuti bentuk lingkaran
                        Container(
                          width:
                              160, // Diameter lingkaran (radius * 2 + borderWidth)
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primary,
                              width: 5,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context0) {
                                return Obx(() {
                                  return AlertDialog(
                                    title: Text(
                                      "Profile Picture",
                                      style: GoogleFonts.sora(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: secondchoice),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        controller.imageUrl.value.isNotEmpty
                                            ? Image.network(
                                                controller.imageUrl.value,
                                                height: 224,
                                                width: 224,
                                                fit: BoxFit.cover,
                                              )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        const SizedBox(height: 10),
                                        const ButtonBar(),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context0),
                                        child: Text(
                                          "OK",
                                          style:
                                              GoogleFonts.sora(color: primary),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                              },
                            );
                          },
                          child: CircleAvatar(
                            radius: 75,
                            backgroundImage:
                                NetworkImage('${controller.imageUrl.value}'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () => showUpdateGambar(context, controller),
                      child: Container(
                        width: 110,
                        height: 30,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "Edit Foto",
                              style: GoogleFonts.sora(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${controller.nama.value}",
                      style: GoogleFonts.sora(
                          color: primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 7, left: 20, right: 20, bottom: 40),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: primary,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 5),
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Memulai dari atas kiri
                        children: [
                          Center(
                            child: Container(
                              width: 120,
                              height: 7,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadiusDirectional.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 5),
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              controller.statistik(
                                "Hadir",
                                controller.hadir.value,
                                const Color(0xff8FF3AD),
                              ),
                              controller.statistik(
                                "Telat",
                                controller.terlambat.value,
                                const Color(0xffFECA3E),
                              ),
                              controller.statistik(
                                "Izin",
                                controller.izin.value,
                                const Color(0xff83C7FF),
                              ),
                              controller.statistik(
                                "Sakit",
                                controller.sakit.value,
                                Colors.red,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          controller.itemProfile(
                            "Email",
                            "${controller.email.value}",
                            const Icon(CupertinoIcons.mail),
                          ),
                          const SizedBox(height: 20),
                          controller.itemProfile(
                            "Kelas",
                            "${controller.kelas.value}",
                            SvgPicture.asset(
                              "asset/icon/kelas.svg",
                              height: 27,
                              width: 27,
                            ),
                          ),
                          const SizedBox(height: 20),
                          controller.itemProfile(
                            "NIS",
                            "${controller.nis.value}",
                            SvgPicture.asset(
                              "asset/icon/nis.svg",
                              height: 27,
                              width: 27,
                            ),
                          ),
                          const SizedBox(height: 20),
                          controller.itemProfile(
                              "Jenis Kelamin",
                              "${controller.jenisKelamin.value}",
                              const Icon(
                                  CupertinoIcons.rectangle_stack_person_crop)),
                          const SizedBox(
                            height: 22,
                          ),
                          Button(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
