import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puu1/global.dart';

import '../controllers/todolist_controller.dart';

class TambahView extends StatefulWidget {
  const TambahView({super.key});

  @override
  _TambahViewState createState() => _TambahViewState();
}

class _TambahViewState extends State<TambahView> {
  final TodolistController controller = Get.put(TodolistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Daftar Tugas',
          style: GoogleFonts.sora(
            color: primary,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 450,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.only(
                    left: 22, right: 22, top: 17, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Judul',
                      style: GoogleFonts.sora(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: controller.titleController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tenggat',
                      style: GoogleFonts.sora(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.calendar_month),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          hintText: controller.selectedDate == null
                              ? 'Pilih Tanggal'
                              : '${controller.selectedDate!.day}/${controller.selectedDate!.month}/${controller.selectedDate!.year}',
                          hintStyle: GoogleFonts.sora()),
                      readOnly: true,
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2025),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            controller.selectedDate = pickedDate;
                            controller.updateSelectedDate(pickedDate);
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Isi',
                      style: GoogleFonts.sora(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: controller.contentController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.addTask();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    'Tambah',
                    style: GoogleFonts.sora(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
