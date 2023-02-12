import 'package:flutter/material.dart';
import 'package:pikiranrakyat_newsroom/shared/my_appbar_back.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppbarBack(),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "PROFIL ANDA",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(40, 168, 224, 1),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: Image.asset('assets/images/uploadfile.png'),
                    title: const Text('SURE NAME'),
                    subtitle: const Text('surename@gmail.com'),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Respond to button press
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        side: const BorderSide(
                          width: 1.0,
                          color: Color.fromRGBO(40, 168, 224, 1),
                        ),
                      ),
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text(
                        "Ubah Profil",
                        style: TextStyle(
                          color: Color.fromRGBO(40, 168, 224, 1),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Respond to button press
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        side: const BorderSide(
                          width: 1.0,
                          color: Color.fromRGBO(40, 168, 224, 0.5),
                        ),
                      ),
                      icon: const Icon(
                        Icons.logout,
                        size: 18,
                        color: Color.fromRGBO(40, 168, 224, 0.5),
                      ),
                      label: const Text(
                        "Keluar",
                        style: TextStyle(
                          color: Color.fromRGBO(40, 168, 224, 0.5),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Status Langganan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(40, 168, 224, 1),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        // Respond to button press
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        side: const BorderSide(
                          width: 1.0,
                          color: Color.fromRGBO(40, 168, 224, 0.5),
                        ),
                      ),
                      child: const Text(
                        "Anda Belum Berlangganan",
                        style: TextStyle(
                          color: Color.fromRGBO(40, 168, 224, 0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              /*width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,*/
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Berlangganan Sekarang",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(40, 168, 224, 1),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('assets/images/icons_whatsapp.png'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('assets/images/icons_phone.png'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('assets/images/icons_email.png'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
