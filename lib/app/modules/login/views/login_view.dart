import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puu1/global.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50), // Mengisi ruang atas
                    Center(
                      child: Image.asset(
                        "asset/logo/600.png",
                        width: 100,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Ngabsen-Kuy",
                        style: GoogleFonts.sora(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                          color: primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.sora(color: secondchoice),
                      controller: controller.txtEmail,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: GoogleFonts.sora(color: secondchoice),
                        icon: const Icon(Icons.mail, color: secondchoice),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: secondchoice),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: primary, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 17),
                    Obx(
                      () => TextField(
                        style: GoogleFonts.sora(color: secondchoice),
                        obscureText: controller.hidePass.value,
                        controller: controller.txtPassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: GoogleFonts.sora(color: secondchoice),
                          suffixIcon: IconButton(
                            onPressed: controller.showPass,
                            icon: controller.hidePass.value
                                ? const Icon(Icons.visibility,
                                    color: secondchoice)
                                : const Icon(Icons.visibility_off,
                                    color: secondchoice),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: secondchoice),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: primary, width: 2),
                          ),
                          icon: const Icon(Icons.lock, color: secondchoice),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Add your forget password logic here
                        },
                        child: Text(
                          "Forget Password?",
                          style: GoogleFonts.sora(
                            color: const Color(0XFF144795),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 27),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => controller.auth(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          fixedSize: const Size(155, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: GoogleFonts.sora(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: Image.asset(
                "asset/logo/brand.png",
                width: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
