import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:puu1/app/data/task_provider.dart';
import 'package:puu1/app/routes/app_pages.dart';
import 'package:sp_util/sp_util.dart';
import 'package:table_calendar/table_calendar.dart';

class TodolistController extends GetxController {
  final RxBool customeIcon = false.obs;
  RxList listData = <dynamic>[].obs;
  RxList listData1 = <dynamic>[].obs;
  DateTime today = DateTime.now();
  RxList kalenderList = <dynamic>[].obs;
  RxBool past = false.obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  DateTime? selectedDate;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await getTask();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void updateSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    compareDate();
  }


  @override
  void onInit() async {
    await getTask();
    kalenderList.value = listData;
    await compareDate();
    super.onInit();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    refreshController.dispose();
    super.dispose();
  }

  Future<void> compareDate() async {
    if (selectedDate == null) {
      print("Tidak ada tanggal yang dipilih");
      past.value = false;
    } else {
      if (selectedDate!.isBefore(today)) {
        past.value = true;
        print("tanggal yang dipilih telah lewat");
      } else if (selectedDate!.isAfter(today)) {
        past.value = false;
      } else {
        past.value = true;
        print("tanggal yang dipilih hari ini");
      }
    }
  }

  Future<void> getTask() async {
    try {
      var response = await TaskProvider().getTask();
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
      // Get.snackbar(
      //   'Peringatan',
      //   'Gagal memuat data task: $e',
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
    }
  }

  Future<void> addTask() async {
    String judul = titleController.text;
    String isi = contentController.text;
    String deadline = selectedDate.toString();

    if (judul.isEmpty || isi.isEmpty) {
      Get.snackbar("Peringatan", "Judul atau Isi tidak boleh kosong",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (past.value == true) {
      EasyLoading.dismiss();
      Get.snackbar("Peringatan", "Pilih tenggat setelah hari ini",
          backgroundColor: Colors.red, colorText: Colors.white);
    } else if (past.value == false) {
      EasyLoading.show();
      var data = {
        "judul": judul,
        "isi": isi,
        "deadline": deadline,
        "users_id": '${SpUtil.getInt('id')}',
      };
      TaskProvider().addTask(data).then((value) {
        if (value.statusCode == 200) {
          Get.snackbar("Success", "Task Berhasil ditambahkan",
              backgroundColor: Colors.green, colorText: Colors.white);
          titleController.clear();
          contentController.clear();
          getTask();
          Get.offAllNamed(Routes.MAIN_MENU);
        } else {
          Get.snackbar("Peringatan", "Task Gagal ditambahkan",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
        EasyLoading.dismiss();
      });
    }
  }

  Future<void> deleteTask(int id) async {
    EasyLoading.show();

    try {
      var response = await TaskProvider().deleteTask(id);
      // var responseBody = response.body;

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Task Berhasil dihapus",
            backgroundColor: Colors.green, colorText: Colors.white);
        getTask();
      } else {
        Get.snackbar("Peringatan", "Task Gagal dihapus",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        'Peringatan',
        'Gagal menghapus task: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void onDaySelected(DateTime day, DateTime focusedDay) {
    if (isSameDay(today, day)) {
      today = DateTime.now();
      kalenderList.value = listData;
    } else {
      today = day;
      String hari = today.toString().split(" ")[0]; // Format tanggal
      RxList results = <dynamic>[].obs;

      results.value = listData.where((element) {
        return element['deadline']
            .toString()
            .startsWith(hari); // Cocokkan tanggal
      }).toList();

      kalenderList.value = results; // Perbarui daftar yang ditampilkan
    }
  }
}
