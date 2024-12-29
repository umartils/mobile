import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:puu1/global.dart';
import '../controllers/tabsurat_controller.dart';

class TabsuratView extends StatefulWidget {
  const TabsuratView({super.key});

  @override
  _TabsuratViewState createState() => _TabsuratViewState();
}

class _TabsuratViewState extends State<TabsuratView> {
  final TabsuratController controller = Get.put(TabsuratController());
  String selectedStatus = ''; // Menyimpan status yang dipilih

  @override
  void dispose() {
    // Mengatur ulang imagePath saat halaman ditutup
    controller.imagePath = ''.obs;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 30,
        ),
        child: Column(
          children: [
            Text(
              "Alasan Tidak Masuk",
              style: GoogleFonts.sora(
                color: primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Sakit",
                  child: Text("Sakit"),
                ),
                DropdownMenuItem(
                  value: "Izin",
                  child: Text("Izin"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedStatus = value!;
                });
              },
              hint: const Text("Pilih alasan"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Alasan tidak boleh kosong";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: controller.imgPick,
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
              ),
              child: Text(
                "Upload Foto Surat",
                style: GoogleFonts.sora(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Obx(() {
              if (controller.imagePath.value != '') {
                return Column(
                  children: [
                    Image.file(
                      File(controller.imagePath.value),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedStatus.isEmpty) {
                          Get.snackbar(
                            "Peringatan",
                            "Pilih alasan terlebih dahulu",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        } else {
                          controller.submitHadir(selectedStatus);
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: primary),
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                );
              } else {
                return const Text('');
              }
            }),
          ],
        ),
      ),
    );
  }
}
