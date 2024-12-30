import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puu1/app/routes/app_pages.dart';
import 'package:sp_util/sp_util.dart';
import 'package:puu1/app/modules/onbording/controllers/contentOnboarding.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends StatefulWidget {
  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int currentIndex = 0;
  PageController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
        initialPage: 0); // Inisialisasi controller halaman onboarding
  }

  @override
  void dispose() {
    _controller?.dispose(); // Bersihkan controller saat widget dihancurkan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex =
                      index; // Memperbarui index halaman saat berpindah
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        contents[i].title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sora(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff144795),
                        ),
                      ),
                      const SizedBox(height: 27),
                      Text(
                        contents[i].description,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sora(
                          fontSize: 16,
                          color: const Color(0xff144795),
                        ),
                      ),
                      const SizedBox(height: 100),
                      Image.asset(
                        contents[i].image,
                        height: 300,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
              (index) => BuildDot(currentIndex == index),
            ),
          ),
          Container(
            height: 55,
            margin: const EdgeInsets.all(40),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff144795),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                if (currentIndex < contents.length - 1) {
                  // Jika bukan halaman terakhir, pindah ke halaman berikutnya
                  _controller!.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                } else {
                  // Jika halaman terakhir, navigasi ke login atau main menu
                  // controller
                  //     .onTapLogin(); // Arahkan ke halaman login atau menu utama
                }
              },
              child: Text(
                currentIndex == contents.length - 1 ? "Finish" : "Next",
                style: GoogleFonts.sora(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container BuildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 10,
      width: isActive ? 30 : 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isActive ? const Color(0xff144795) : const Color(0xffC4C4C4),
      ),
    );
  }
}
