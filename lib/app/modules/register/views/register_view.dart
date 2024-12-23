import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            left: 50,
            right: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Center(
                child: Text(
                  "Ngabsen-Kuy",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sora',
                      fontSize: 24,
                      color: Color(0XFF144795)),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              const Text("Nama",
                  style: TextStyle(
                      color: Color(0XFF235CB2),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sora',
                      fontSize: 15)),
              const SizedBox(height: 10),
              TextField(
                controller: controller.txtName,
                decoration: InputDecoration(
                  fillColor: const Color(0xFF83C7FF),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Radius border
                    borderSide: const BorderSide(
                        color: Color(0XFF83C7FF)), // Warna border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15), // Radius border saat fokus
                    borderSide: const BorderSide(
                        color: Color(0XFF83C7FF),
                        width: 2), // Border lebih tebal
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Username",
                  style: TextStyle(
                      color: Color(0XFF235CB2),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sora',
                      fontSize: 15)),
              const SizedBox(height: 10),
              TextField(
                controller: controller.txtEmail,
                decoration: InputDecoration(
                  fillColor: const Color(0xFF83C7FF),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Radius border
                    borderSide: const BorderSide(
                        color: Color(0XFF83C7FF)), // Warna border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15), // Radius border saat fokus
                    borderSide: const BorderSide(
                        color: Color(0XFF83C7FF),
                        width: 2), // Border lebih tebal
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Password",
                  style: TextStyle(
                      color: Color(0XFF235CB2),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sora',
                      fontSize: 15)),
              const SizedBox(height: 10),
              TextField(
                obscureText: true,
                controller: controller.txtPassword,
                decoration: InputDecoration(
                  fillColor: const Color(0xFF83C7FF), // Label pada TextField
                  filled: true, // Mengaktifkan warna background
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Radius border
                    borderSide: const BorderSide(
                        color: Color(0XFF83C7FF)), // Warna border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15), // Radius border saat fokus
                    borderSide: const BorderSide(
                        color: Color(0XFF83C7FF),
                        width: 2), // Border lebih tebal
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Forget Password?",
                style: const TextStyle(
                  color: Color(0XFF144795),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  fontFamily: 'Sora',
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => controller.register(),
                  child: Text(
                    "S I G N  U P",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Sora',
                        fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFD766),
                      fixedSize: Size(176, 45)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
