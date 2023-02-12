// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:pikiranrakyat_newsroom/shared/my_appbar.dart';
import 'package:pikiranrakyat_newsroom/pages/home/home_page.dart';
import 'package:pikiranrakyat_newsroom/pages/artikel/artikel_list_page.dart';
import 'package:pikiranrakyat_newsroom/pages/video/video_list_page.dart';
import 'package:pikiranrakyat_newsroom/pages/podcast/podcast_list_page.dart';
import 'package:pikiranrakyat_newsroom/pages/koran/koran_list_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;
  late var _pageOptions = [];

  @override
  void initState() {
    super.initState();
    _pageOptions = [
      HomePage(changeTab: _changeTab),
      ArtikelListPage(),
      VideoListPage(),
      PodcastListPage(),
      KoranListPage(),
    ];
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Scaffold(
        appBar: MyAppbar(),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text("Tekan tombol 'back' lagi untuk keluar."),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          child: _pageOptions[_currentIndex],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                offset: Offset(0, 0.75),
              )
            ],
            color: Colors.blue[500],
          ),
          child: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            items: [
              SalomonBottomBarItem(
                icon: Icon(Ionicons.home),
                title: Text("Home"),
                unselectedColor: Colors.white,
                selectedColor: Colors.white,
              ),
              SalomonBottomBarItem(
                icon: Icon(Ionicons.book_outline),
                title: Text("Artikel"),
                unselectedColor: Colors.white,
                selectedColor: Colors.white,
              ),
              SalomonBottomBarItem(
                icon: Icon(Ionicons.play_circle_outline),
                title: Text("Video"),
                unselectedColor: Colors.white,
                selectedColor: Colors.white,
              ),
              SalomonBottomBarItem(
                icon: Icon(Ionicons.mic_outline),
                title: Text("Podcast"),
                unselectedColor: Colors.white,
                selectedColor: Colors.white,
              ),
              SalomonBottomBarItem(
                icon: Icon(Ionicons.newspaper_outline),
                title: Text("Koran"),
                unselectedColor: Colors.white,
                selectedColor: Colors.white,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
