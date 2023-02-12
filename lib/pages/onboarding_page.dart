// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unnecessary_const

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pikiranrakyat_newsroom/pages/login/login_page.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return LoginPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AssetImage("assets/images/bg_screen.png"),
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.transparent,
          pages: [
            PageViewModel(
              title: "",
              bodyWidget: Center(
                heightFactor: 1.5,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("assets/images/introduction_1.png"),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.width * 0.7,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "KELOLA INFORMASI",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Text(
                        "Mengelola informasi sesuai dengan kebutuhan dan minat anda.",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            PageViewModel(
              title: "",
              bodyWidget: Center(
                heightFactor: 1.5,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("assets/images/introduction_2.png"),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.width * 0.7,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "SIMPAN DENGAN MUDAH",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Text(
                        "Simpan informasi menarik yang anda dapatkan dan lihat kembali di waktu senggang.",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            PageViewModel(
              title: "",
              bodyWidget: Center(
                heightFactor: 1.5,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("assets/images/introduction_3.png"),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.width * 0.7,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "MULAI MENCOBA",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Text(
                        "Mulai mencoba pengalaman mendapatkan semua informasi dalam satu genggaman.",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          // showBackButton: false,
          showSkipButton: true,
          skipOrBackFlex: 0,
          nextFlex: 0,
          back: const Text(
            'Kembali',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          skip: const Text(
            'Lewati',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          next: const Text(
            'Lanjut',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          done: const Text(
            'Mulai',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Colors.white,
            activeColor: Colors.white,
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ],
    );
  }
}
