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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 30,
            left: 25,
            right: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Text(
                  "Ngabsen-Kuy",
                  style: GoogleFonts.sora(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                      color: primary),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              // Text("Email",
              //     style: GoogleFonts.sora(
              //         color: Color(0XFF235CB2),
              //         fontWeight: FontWeight.w600,
              //         fontSize: 15)),
              // const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.sora(color: secondchoice),
                controller: controller.txtEmail,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: GoogleFonts.sora(color: secondchoice),
                  icon: const Icon(
                    Icons.mail,
                    color: secondchoice,
                  ),
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              // Text("Password",
              //     style: GoogleFonts.sora(
              //         color: Color(0XFF235CB2),
              //         fontWeight: FontWeight.w600,
              //         fontSize: 15)),
              // const SizedBox(height: 10),
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
                          ? const Icon(
                              Icons.visibility,
                              color: secondchoice,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: secondchoice,
                            ),
                    ),
                    // fillColor: primary, // Label pada TextField
                    // filled: true, // Mengaktifkan warna background
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(15), // Radius border
                    //   borderSide:
                    //       const BorderSide(color: primary), // Warna border
                    // ),
                    // focusedBorder: OutlineInputBorder(
                    //   borderRadius:
                    //       BorderRadius.circular(15), // Radius border saat fokus
                    //   borderSide: const BorderSide(
                    //       color: primary, width: 2), // Border lebih tebal
                    // ),
                    icon: const Icon(
                      Icons.lock,
                      color: secondchoice,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Forget Password?",
                style: GoogleFonts.sora(
                  color: Color(0XFF144795),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.auth(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          fixedSize: const Size(155, 45)),
                      child: Text(
                        "Login",
                        style: GoogleFonts.sora(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    ),
                    const SizedBox(
                      height: 195,
                    ),
                    Text(
                      "Copyright By",
                      style: GoogleFonts.sora(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: primary),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "asset/images/upi.png",
                            width: 100,
                          ),
                          Image.asset(
                            "asset/images/tekkom.png",
                            width: 70,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
