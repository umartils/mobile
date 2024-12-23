import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:puu1/app/data/user_provider.dart';
import 'package:puu1/app/routes/app_pages.dart';
import 'package:sp_util/sp_util.dart';

class TodolistController extends GetxController {
  final RxBool customeIcon = false.obs;
  RxList listData = <dynamic>[].obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  DateTime? selectedDate;

  @override
  void onInit() {
    getTask();
    super.onInit();
  }

  Future<void> getTask() async {
    try {
      var response = await UserProvider().getTask();
      var responseBody = response.body;
      var data = responseBody['data'];

      listData.value = List<dynamic>.from(data.map((element) {
        return {
          'id': element['id'],
          'judul': element['judul'],
          'isi': element['isi'],
          'deadline': element['deadline'],
        };
      }));
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data task: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> addTask() async {
    String judul = titleController.text;
    String isi = contentController.text;
    String deadline = selectedDate.toString();

    if (judul.isEmpty || isi.isEmpty) {
      Get.snackbar("Error", "Judul atau Isi tidak boleh kosong",
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      EasyLoading.show();
      var data = {
        "judul": judul,
        "isi": isi,
        "deadline": deadline,
        "users_id": '${SpUtil.getInt('id')}',
      };
      UserProvider().addTask(data).then((value) {
        if (value.statusCode == 200) {
          Get.snackbar("Success", "Task Berhasil ditambahkan",
              backgroundColor: Colors.green, colorText: Colors.white);
          titleController.clear();
          contentController.clear();
          getTask();
          Get.offAllNamed(Routes.MAIN_MENU);
        } else {
          Get.snackbar("Error", "Task Gagal ditambahkan",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
        EasyLoading.dismiss();
      });
    }
  }

  Future<void> deleteTask(int id) async {
    EasyLoading.show();

    try {
      var response = await UserProvider().deleteTask(id);
      // var responseBody = response.body;

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Task Berhasil dihapus",
            backgroundColor: Colors.green, colorText: Colors.white);
        getTask();
      } else {
        Get.snackbar("Error", "Task Gagal dihapus",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        'Error',
        'Gagal menghapus task: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // void onDaySelect(DateTime day, DateTime focusedDay) {

  // }
}
