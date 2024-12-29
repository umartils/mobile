import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puu1/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:puu1/app/modules/profile/controllers/profile_controller.dart';
import 'package:puu1/global.dart';

Future<void> showWaktuDialog(
    BuildContext context, HomepageController controller) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info_rounded),
            SizedBox(width: 8), // Jarak antara ikon dan teks
            Text("Ajukan Perubahan", style: GoogleFonts.sora(fontSize: 20)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Oke", style: TextStyle(color: primary)),
          ),
        ],
      );
    },
  );
}
