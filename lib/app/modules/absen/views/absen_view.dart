import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puu1/app/modules/tababsen/controllers/tababsen_controller.dart';
import 'package:puu1/app/modules/tababsen/views/tababsen_view.dart';
import 'package:puu1/app/modules/tabsurat/controllers/tabsurat_controller.dart';
import 'package:puu1/global.dart';

import '../controllers/absen_controller.dart';
import 'package:puu1/app/modules/tabsurat/views/tabsurat_view.dart'; // Pastikan file ini ada dan sesuai

class AbsenView extends GetView<AbsenController> {
const AbsenView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Absensi',
            style: GoogleFonts.sora(
                color: primary, fontWeight: FontWeight.w600, fontSize: 24),
          ),
          centerTitle: true,
          bottom: TabBar(
          
            labelColor: primary,
            unselectedLabelColor: Colors.black54,
            labelStyle:
                GoogleFonts.sora(fontSize: 14.0, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                GoogleFonts.sora(fontSize: 12.0, fontWeight: FontWeight.bold),
            indicatorColor: primary,
            indicatorWeight: 3.0,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(icon: Icon(CupertinoIcons.photo_camera_solid), text: 'Absen'),
              Tab(icon: Icon(CupertinoIcons.photo_fill), text: 'Surat'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TababsenView(),
            TabsuratView(), 
          ],
        ),
      ),
    );
  }
}
