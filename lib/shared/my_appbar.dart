import 'package:flutter/material.dart';
import 'package:pikiranrakyat_newsroom/pages/setting/activity_page.dart';
import 'package:pikiranrakyat_newsroom/pages/setting/profile_page.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Image(
        image: AssetImage("assets/images/logonewsroom2.png"),
        fit: BoxFit.scaleDown,
        width: 120,
      ),
      actions: <Widget>[
        IconButton(
          constraints: const BoxConstraints(minWidth: 50),
          icon: Image.asset(
            "assets/images/tab_activity.png",
            height: 30,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const ActivityPage();
              }),
            );
          },
        ),
        IconButton(
          constraints: const BoxConstraints(minWidth: 50),
          icon: Image.asset(
            "assets/images/tab_profile.png",
            height: 30,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const ProfilePage();
              }),
            );
          },
        )
      ],
      elevation: 0,
    );
  }

  static final _appBar = AppBar();
  @override
  Size get preferredSize => _appBar.preferredSize;
}
