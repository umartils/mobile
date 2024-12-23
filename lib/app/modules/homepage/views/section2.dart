import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puu1/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:puu1/app/modules/homepage/views/waktu.dart';
import 'package:puu1/global.dart';

class SectionDua extends StatefulWidget {
  const SectionDua({super.key});

  @override
  _SectionDua createState() => _SectionDua();
}

class _SectionDua extends State<SectionDua> {
  final HomepageController controller = Get.put(HomepageController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            showWaktuDialog(context, controller);
          },
          child: Container(
            width: 157,
            height: 180,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 5),
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ],
            ),
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Masuk",
                      style: GoogleFonts.sora(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text("${controller.waktuMasuk.value}",
                        style: GoogleFonts.sora(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Keluar",
                      style: GoogleFonts.sora(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text("${controller.waktuKeluar.value}",
                        style: GoogleFonts.sora(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 157,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul "Riwayat"
                  Text(
                    "Riwayat",
                    style: GoogleFonts.sora(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Item "Hadir"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle,
                              color: Colors.green, size: 18),
                          SizedBox(width: 5),
                          Text(
                            "Hadir",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "${controller.kehadiran.value}", // Jumlah hadir
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Item "Tidak Hadir"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.cancel, color: Colors.red, size: 18),
                          SizedBox(width: 5),
                          Text(
                            "Tidak Hadir",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "${controller.tidakHadir.value}", // Jumlah tidak hadir
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
