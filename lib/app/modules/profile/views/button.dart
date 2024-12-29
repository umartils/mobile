import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puu1/app/modules/profile/controllers/profile_controller.dart';
import 'package:puu1/app/modules/profile/views/password.dart';
import 'package:puu1/app/modules/profile/views/update.dart';
import 'package:puu1/app/routes/app_pages.dart';
import 'package:puu1/global.dart';
import 'package:sp_util/sp_util.dart';

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  final ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            showUpdateBottomSheet(context, controller);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
                vertical: 7, horizontal: 14), // Atur padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Sudut lebih tegas
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.edit,
                color: primary,
                size: 17,
              ),
              const SizedBox(width: 5),
              Text(
                "Edit",
                style: GoogleFonts.sora(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: primary,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            showPasswordBottomSheet(context, controller);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
                vertical: 7, horizontal: 8), // Atur padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Sudut lebih tegas
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                color: primary,
                size: 17,
              ),
              const SizedBox(width: 5),
              Text(
                "Password",
                style: GoogleFonts.sora(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: primary,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            SpUtil.clear();
            Get.offAllNamed(Routes.LOGIN);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
                vertical: 7, horizontal: 8), // Atur padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Sudut lebih tegas
            ),
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Teks dan ikon di tengah
            children: [
              const Icon(Icons.logout,
                  color: primary, size: 17), // Ukuran ikon lebih kecil
              const SizedBox(width: 5), // Jarak antara ikon dan teks
              Text(
                "Logout",
                style: GoogleFonts.sora(
                  fontWeight: FontWeight.w600,
                  fontSize: 14, // Ukuran teks yang lebih proporsional
                  color: primary,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
