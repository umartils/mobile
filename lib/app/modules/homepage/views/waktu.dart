import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puu1/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:puu1/app/modules/profile/controllers/profile_controller.dart';
import 'package:puu1/global.dart';

Future<void> showWaktuDialog(
    BuildContext context, HomepageController controller) async {
  // Controller untuk field input

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Detail Waktu", style: TextStyle(fontSize: 20)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
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
