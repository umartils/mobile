import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puu1/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:puu1/app/routes/app_pages.dart';
import 'package:puu1/global.dart';

class SectionSatu extends StatefulWidget {
  const SectionSatu({super.key});

  @override
  _SectionSatuState createState() => _SectionSatuState();
}

class _SectionSatuState extends State<SectionSatu> {
  final HomepageController controller = Get.put(HomepageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 240,
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Column(
        children: [
          const SizedBox(
            height: 13,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Text(
                  "Daftar Tugas",
                  style: GoogleFonts.sora(
                      color: secondchoice,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 13.0),
                child: Icon(
                  Icons.arrow_forward_ios, // Ikon panah
                  color: secondchoice,
                  size: 14, // Sesuaikan ukuran ikon
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => controller.listData.isEmpty
                ? const Center(
                    child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                        "No tasks available or failed to connect to the server"),
                  )) // Tampilkan jika kosong
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        2, // Sesuaikan jumlah data
                    itemBuilder: (context, index) {
                      var list =
                          controller.listData[index]; // Akses langsung elemen
                      return GestureDetector(
                        onTap: () {
                          Get.offAllNamed(
                            Routes.TODOLIST,
                          ); // Navigasi
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 10, right: 10, left: 10),
                          width: 280,
                          height: 70,
                          padding: const EdgeInsets.only(right: 10, left: 5),
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 33,
                                        height: 33,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${list['id']}", // Tampilkan ID
                                            style: GoogleFonts.sora(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          list['judul'], // Tampilkan judul
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.sora(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
