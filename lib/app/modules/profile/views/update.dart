import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puu1/app/modules/profile/controllers/profile_controller.dart';
import 'package:puu1/global.dart';

Future<void> showUpdateBottomSheet(
    BuildContext context, ProfileController controller) async {
  // Controller untuk field input
  final TextEditingController nameController =
      TextEditingController(text: controller.nama.value);
  final TextEditingController nisController =
      TextEditingController(text: controller.nis.value);
  final RxString selectedGender = controller.jenisKelamin;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16), // Sudut atas BottomSheet
      ),
    ),
    builder: (BuildContext context) {
      return Obx(
        () => Padding(
          padding: MediaQuery.of(context)
              .viewInsets, // Agar tidak terhalang keyboard
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Update Data",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 23),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Nama",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nisController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "NIS",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: selectedGender.value,
                    decoration: const InputDecoration(
                      labelText: "Jenis Kelamin",
                      border: OutlineInputBorder(),
                    ),
                    items: ["Pria", "Wanita"]
                        .map((String gender) => DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        selectedGender.value = value;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              nisController.text.isNotEmpty &&
                              selectedGender.value.isNotEmpty) {
                            controller.nama.value = nameController.text;
                            controller.nis.value = nisController.text;
                            controller.jenisKelamin.value =
                                selectedGender.value;
                            controller.updateProfile(nameController.text,
                                nisController.text, selectedGender.value);
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
  );
}
