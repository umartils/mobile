import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puu1/app/modules/profile/controllers/profile_controller.dart';
import 'package:puu1/global.dart';

Future<void> showPasswordBottomSheet(
    BuildContext context, ProfileController controller) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16), // Sudut atas BottomSheet
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding:
            MediaQuery.of(context).viewInsets, // Agar tidak terhalang keyboard
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  const Text(
                    "Ubah Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    obscureText: controller.hidePass.value,
                    controller: controller.oldPassword,
                    decoration: InputDecoration(
                      labelText: "Password Lama",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: controller.showPass,
                        icon: controller.hidePass.value
                            ? const Icon(
                                Icons.visibility,
                                color: secondchoice,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: secondchoice,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.newPassword,
                    obscureText: controller.hidePass1.value,
                    decoration: InputDecoration(
                      labelText: "Password Baru",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: controller.showPass1,
                        icon: controller.hidePass1.value
                            ? const Icon(
                                Icons.visibility,
                                color: secondchoice,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: secondchoice,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.confirmPassword,
                    obscureText: controller.hidePass2.value,
                    decoration: InputDecoration(
                      labelText: "Konfirmasi Password",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: controller.showPass2,
                        icon: controller.hidePass2.value
                            ? const Icon(
                                Icons.visibility,
                                color: secondchoice,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: secondchoice,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (controller.oldPassword.text.isNotEmpty &&
                              controller.newPassword.text.isNotEmpty &&
                              controller.confirmPassword.text.isNotEmpty) {
                            controller.changePassword();
                            Navigator.pop(context);
                          } else {
                            Get.snackbar(
                              "Error",
                              "Semua field harus diisi",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                        style:
                            ElevatedButton.styleFrom(backgroundColor: primary),
                        child: Text(
                          "Submit",
                          style: GoogleFonts.sora(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  ).whenComplete(() {
    // Bersihkan semua field ketika bottom sheet ditutup
    controller.oldPassword.clear();
    controller.newPassword.clear();
    controller.confirmPassword.clear();
    controller.hidePass.value = true;
    controller.hidePass1.value = true;
    controller.hidePass2.value = true;
  });
}
