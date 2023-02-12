// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pikiranrakyat_newsroom/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // function redirect to main page
  void toMainPage(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return MainPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage("assets/images/bg_screen.png"),
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/logo_splash.png"),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.7,
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Text(
                  "MASUK MENGGUNAKAN",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 4,
                    20,
                    MediaQuery.of(context).size.width / 4,
                    20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Image(
                          image: AssetImage("assets/images/login_fb.png"),
                          height: MediaQuery.of(context).size.width / 10,
                        ),
                        onTap: () => toMainPage(context),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Image(
                          image: AssetImage("assets/images/login_google.png"),
                          height: MediaQuery.of(context).size.width / 10,
                        ),
                        onTap: () => toMainPage(context),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Image(
                          image: AssetImage("assets/images/login_phone.png"),
                          height: MediaQuery.of(context).size.width / 10,
                        ),
                        onTap: () => toMainPage(context),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 6,
                    0,
                    MediaQuery.of(context).size.width / 6,
                    0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: Colors.white60),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Text(
                      "Dengan mendaftar berarti anda setuju dengan",
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "Syarat & Ketentuan ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text("yang berlaku.",
                          style: TextStyle(color: Colors.white)),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
