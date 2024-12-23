import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:puu1/app/modules/profile/controllers/profile_controller.dart';
import 'package:puu1/global.dart';
import 'package:sp_util/sp_util.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 7, left: 20, right: 20, bottom: 50),
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
                    borderRadius: BorderRadiusDirectional.circular(50),
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
                    7,
                    const Color(0xff8FF3AD),
                  ),
                  controller.statistik(
                    "Telat",
                    10,
                    const Color(0xffFECA3E),
                  ),
                  controller.statistik(
                    "Izin",
                    10,
                    const Color(0xff83C7FF),
                  ),
                  controller.statistik(
                    "Sakit",
                    11,
                    Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              controller.itemProfile(
                "Nama",
                "${SpUtil.getString('name')}",
                Icon(CupertinoIcons.person),
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
              )
            ]));
  }
}
