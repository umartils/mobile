import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/businesspage_controller.dart';

class BusinesspageView extends GetView<BusinesspageController> {
  const BusinesspageView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'BusinesspageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
