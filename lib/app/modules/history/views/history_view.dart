import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:puu1/global.dart';

import '../controllers/history_controller.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final HistoryController controller = Get.put(HistoryController());
  final TextEditingController _searchController = TextEditingController();

  // final Color primaryBlue = const Color(0xFF144795);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Monitoring',
          style: GoogleFonts.sora(
              color: primary, fontWeight: FontWeight.w600, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              onChanged: (value) => controller.runFilter(value),
              // controller: _searchController,
              decoration: InputDecoration(
                  hintText: 'Cari berdasarkan tanggal...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  filled: true,
                  fillColor: Colors.black12),
            ),
            const SizedBox(height: 20),

            // List Absensi
            Expanded(
              child: Obx(
                () => SmartRefresher(
                  controller: controller.refreshController,
                  onRefresh: controller.onRefresh,
                  child: ListView.builder(
                    itemCount: controller.searchData.length,
                    itemBuilder: (context, index) {
                      var list = controller.searchData[index];
                      return Container(
                        height: 80,
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          // color: controller.listData[index]['warna'],
                          color: index % 2 == 0 ? primary : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              // Tanggal
                              Expanded(
                                flex: 2,
                                child: Text(
                                  list['tanggal'],
                                  style: GoogleFonts.sora(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        index % 2 == 0 ? Colors.white : primary,
                                  ),
                                ),
                              ),
                              // Waktu
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    list['waktu'],
                                    style: GoogleFonts.sora(
                                      color: index % 2 == 0
                                          ? Colors.white
                                          : primary,
                                    ),
                                  ),
                                ),
                              ),
                              // Status
                              InkWell(
                                onTap: () async {
                                  var id = list[
                                      'id']; // Pastikan key 'id' ada di data Anda
                                  await controller.getImg(
                                      id); // Tunggu pengambilan gambar selesai

                                  showDialog(
                                    context: context,
                                    builder: (context0) {
                                      return Obx(() {
                                        return AlertDialog(
                                          title: Text(
                                            "Foto Absensi",
                                            style: GoogleFonts.sora(),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              controller.imagePath.value
                                                      .isNotEmpty
                                                  ? Image.network(
                                                      controller
                                                          .imagePath.value,
                                                      height: 200,
                                                      width: 200,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context0),
                                              child: Text(
                                                "OK",
                                                style: GoogleFonts.sora(
                                                    color: primary),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                    },
                                  );
                                },
                                child: Container(
                                  width: 80,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: controller.getStatusColor(
                                        list['status'] ?? 'Hadir'),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    list['status'] ?? 'Hadir',
                                    style: GoogleFonts.sora(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
