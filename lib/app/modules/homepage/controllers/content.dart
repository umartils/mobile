import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:puu1/app/routes/app_pages.dart';

class TaskContent {
  final String imagePath; // Path untuk gambar
  final String title; // Teks untuk daftar tugas
  final VoidCallback onTap; // Aksi ketika tombol ditekan

  TaskContent({
    required this.imagePath,
    required this.title,
    required this.onTap,
  });
}

// List konten untuk daftar tugas
final List<TaskContent> taskContents = [
  TaskContent(
    imagePath: "asset/images/image.png",
    title: "Buat Daftar Tugasmu",
    onTap: () {
      Get.toNamed(Routes.TAMBAH_TASK);
    },
  ),
  TaskContent(
    imagePath: "asset/images/Monitoring.gif",
    title: "Monitoring",
    onTap: () {
      Get.toNamed(Routes.HISTORY);
    },
  ),
  TaskContent(
    imagePath: "asset/images/image.png",
    title: "absensi",
    onTap: () {
      print("Tugas 3 di-tap");
    },
  ),
];
