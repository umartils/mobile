import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/schoolpage_controller.dart';

class SchoolpageView extends GetView<SchoolpageController> {
  const SchoolpageView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'SchoolpageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
