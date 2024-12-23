import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puu1/app/modules/todolist/views/kalender.dart';
import 'package:puu1/app/modules/todolist/views/tambah.dart';
import 'package:puu1/global.dart';

import '../controllers/todolist_controller.dart';

class TodolistView extends StatefulWidget {
  const TodolistView({super.key});

  @override
  _TodolistViewState createState() => _TodolistViewState();
}

class _TodolistViewState extends State<TodolistView> {
  final TodolistController controller = Get.put(TodolistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Daftar Tugas',
            style: GoogleFonts.sora(
              color: primary,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 11, right: 11, top: 1),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Kalender(),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.listData.length,
                    itemBuilder: (context, index) {
                      var list = controller.listData[index];
                      return Card(
                        color: primary,
                        elevation: 4,
                        child: ExpansionTile(
                          iconColor: Colors.white,
                          collapsedIconColor: Colors.white,
                          childrenPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          expandedAlignment: Alignment.topLeft,
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          title: Text(
                            list['judul'],
                            style: GoogleFonts.sora(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          children: [
                            Text(list['isi'],
                                style: GoogleFonts.sora(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200)),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    var id = controller.listData[index]['id'];
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Konfirmasi"),
                                          content: Text(
                                              "Apakah Anda yakin ingin menghapus tugas ini?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Tutup dialog
                                              },
                                              child: Text("Batal"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                controller.deleteTask(
                                                    id); // Jalankan fungsi deleteTask
                                                Navigator.pop(
                                                    context); // Tutup dialog setelah eksekusi
                                              },
                                              child: Text(
                                                "Oke",
                                                style: TextStyle(
                                                    color: Colors
                                                        .red), // Warna teks Oke
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TambahView()), // Halaman tujuan
                );
              },
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                color: secondchoice,
              ), // Icon plus
            ),
          ),
        ));
  }
}
