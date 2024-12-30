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
        Expanded(
          child: InkWell(
            onTap: () {
              showWaktuDialog(context, controller);
            },
            child: Container(
              height: 180,
              margin:
                  const EdgeInsets.only(right: 8.0), // Spasi antar container
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
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.info_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Summary",
                            style: GoogleFonts.sora(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Masuk",
                                style: GoogleFonts.sora(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${controller.waktuMasuk.value}',
                                style: GoogleFonts.sora(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Lokasi",
                                style: GoogleFonts.sora(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${controller.userLokasi.value}',
                                style: GoogleFonts.sora(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 180,
            margin: const EdgeInsets.only(left: 8.0), // Spasi antar container
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.history,
                          color: primary,
                          size: 22,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Riwayat",
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Item "Hadir"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.check_circle,
                                color: Colors.green, size: 18),
                            const SizedBox(width: 5),
                            const Text(
                              "Hadir",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
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
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Item "Tidak Hadir"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.cancel, color: Colors.red, size: 18),
                            SizedBox(width: 5),
                            Text(
                              "Tidak Hadir",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
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
                            style: const TextStyle(
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
          ),
        ),
      ],
    );
  }
}
