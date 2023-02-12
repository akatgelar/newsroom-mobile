import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pikiranrakyat_newsroom/models/artikel_model.dart';
import 'package:pikiranrakyat_newsroom/models/koran_model.dart';
import 'package:pikiranrakyat_newsroom/models/podcast_model.dart';
import 'package:pikiranrakyat_newsroom/models/video_model.dart';
import 'package:pikiranrakyat_newsroom/pages/artikel/artikel_detail_page.dart';
import 'package:pikiranrakyat_newsroom/pages/koran/koran_detail_page.dart';
import 'package:pikiranrakyat_newsroom/pages/video/video_detail_page.dart';
import 'package:pikiranrakyat_newsroom/pages/podcast/podcast_detail_page.dart';
import 'package:pikiranrakyat_newsroom/shared/my_appbar_back.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late DateFormat dateFormat;

  int dataPerPage = 1;
  int dataPage = 1;
  String dataSort = 'updated_at:desc';

  List<ArtikelModel> dataArtikel = [];
  List<VideoModel> dataVideo = [];
  List<PodcastModel> dataPodcast = [];
  List<KoranModel> dataKoran = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMd('id');
    getArtikel();
    getVideo();
    getPodcast();
    getKoran();
  }

  void getArtikel() {
    ArtikelModel.getAll(dataPerPage, dataPage, dataSort).then((value) {
      setState(() {
        if (value != null) {
          for (var element in value) {
            dataArtikel.add(element);
          }
        }
      });
    });
  }

  void getVideo() {
    VideoModel.getAll(dataPerPage, dataPage, dataSort).then((value) {
      setState(() {
        if (value != null) {
          for (var element in value) {
            dataVideo.add(element);
          }
        }
      });
    });
  }

  void getPodcast() {
    PodcastModel.getAll(dataPerPage, dataPage, dataSort).then((value) {
      setState(() {
        if (value != null) {
          for (var element in value) {
            dataPodcast.add(element);
          }
        }
      });
    });
  }

  void getKoran() {
    KoranModel.getAll(dataPerPage, dataPage, dataSort).then((value) {
      setState(() {
        if (value != null) {
          for (var element in value) {
            dataKoran.add(element);
          }
        }
      });
    });
  }

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
                  "AKTIVITAS ANDA",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(40, 168, 224, 1),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: ExpansionTile(
                title: const Text('History'),
                leading: const Icon(
                  Ionicons.timer_outline,
                  color: Colors.blue,
                ),
                children: [
                  for (var i = 0; i < dataArtikel.length; i++)
                    ListTile(
                      leading: Image.network(
                        dataArtikel[i].image,
                        fit: BoxFit.fitWidth,
                        width: 100,
                      ),
                      title: Text(
                        '${dataArtikel[i].category} | ${dateFormat.format(
                          DateTime.parse(dataArtikel[i].created_at),
                        )}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(40, 168, 224, 1),
                        ),
                      ),
                      subtitle: Text(
                        dataArtikel[i].title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ArtikelDetailPage(id: dataArtikel[i].id);
                          }),
                        );
                      },
                    ),
                  for (var i = 0; i < dataVideo.length; i++)
                    ListTile(
                      leading: Image.network(
                        dataVideo[i].image,
                        fit: BoxFit.fitWidth,
                        width: 100,
                      ),
                      title: Text(
                        '${dataVideo[i].category} | ${dateFormat.format(
                          DateTime.parse(dataVideo[i].created_at),
                        )}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(40, 168, 224, 1),
                        ),
                      ),
                      subtitle: Text(
                        dataVideo[i].title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return VideoDetailPage(id: dataVideo[i].id);
                          }),
                        );
                      },
                    ),
                  for (var i = 0; i < dataPodcast.length; i++)
                    ListTile(
                      leading: Image.network(
                        dataPodcast[i].image,
                        fit: BoxFit.fitWidth,
                        width: 100,
                      ),
                      title: Text(
                        '${dataPodcast[i].category} | ${dateFormat.format(
                          DateTime.parse(dataPodcast[i].created_at),
                        )}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(40, 168, 224, 1),
                        ),
                      ),
                      subtitle: Text(
                        dataPodcast[i].title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return PodcastDetailPage(id: dataPodcast[i].id);
                          }),
                        );
                      },
                    ),
                  for (var i = 0; i < dataKoran.length; i++)
                    ListTile(
                      leading: Image.network(
                        dataKoran[i].image,
                        fit: BoxFit.fitWidth,
                        width: 100,
                      ),
                      title: Text(
                        '${dataKoran[i].category} | ${dateFormat.format(
                          DateTime.parse(dataKoran[i].created_at),
                        )}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(40, 168, 224, 1),
                        ),
                      ),
                      subtitle: Text(
                        dataKoran[i].title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return KoranDetailPage(id: dataKoran[i].id);
                          }),
                        );
                      },
                    ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: ExpansionTile(
                title: const Text('Artikel Disukai'),
                leading: const Icon(
                  Ionicons.book_outline,
                  color: Colors.blue,
                ),
                children: [
                  for (var i = 0; i < dataArtikel.length; i++)
                    ListTile(
                      leading: Image.network(
                        dataArtikel[i].image,
                        fit: BoxFit.fitWidth,
                        width: 100,
                      ),
                      title: Text(
                        '${dataArtikel[i].category} | ${dateFormat.format(
                          DateTime.parse(dataArtikel[i].created_at),
                        )}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(40, 168, 224, 1),
                        ),
                      ),
                      subtitle: Text(
                        dataArtikel[i].title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ArtikelDetailPage(id: dataArtikel[i].id);
                          }),
                        );
                      },
                    ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: ExpansionTile(
                title: const Text('Video Disukai'),
                leading: const Icon(
                  Ionicons.play_circle_outline,
                  color: Colors.blue,
                ),
                children: [
                  for (var i = 0; i < dataVideo.length; i++)
                    ListTile(
                      leading: Image.network(
                        dataVideo[i].image,
                        fit: BoxFit.fitWidth,
                        width: 100,
                      ),
                      title: Text(
                        '${dataVideo[i].category} | ${dateFormat.format(
                          DateTime.parse(dataVideo[i].created_at),
                        )}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(40, 168, 224, 1),
                        ),
                      ),
                      subtitle: Text(
                        dataVideo[i].title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return VideoDetailPage(id: dataVideo[i].id);
                          }),
                        );
                      },
                    ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: ExpansionTile(
                title: const Text('Podcast Disukai'),
                leading: const Icon(
                  Ionicons.mic_outline,
                  color: Colors.blue,
                ),
                children: [
                  for (var i = 0; i < dataPodcast.length; i++)
                    ListTile(
                      leading: Image.network(
                        dataPodcast[i].image,
                        fit: BoxFit.fitWidth,
                        width: 100,
                      ),
                      title: Text(
                        '${dataPodcast[i].category} | ${dateFormat.format(
                          DateTime.parse(dataPodcast[i].created_at),
                        )}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(40, 168, 224, 1),
                        ),
                      ),
                      subtitle: Text(
                        dataPodcast[i].title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return PodcastDetailPage(id: dataPodcast[i].id);
                          }),
                        );
                      },
                    ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: ExpansionTile(
                title: const Text('Koran'),
                leading: const Icon(
                  Ionicons.newspaper_outline,
                  color: Colors.blue,
                ),
                children: [
                  for (var i = 0; i < dataKoran.length; i++)
                    ListTile(
                      leading: Image.network(
                        dataKoran[i].image,
                        fit: BoxFit.fitWidth,
                        width: 100,
                      ),
                      title: Text(
                        '${dataKoran[i].category} | ${dateFormat.format(
                          DateTime.parse(dataKoran[i].created_at),
                        )}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(40, 168, 224, 1),
                        ),
                      ),
                      subtitle: Text(
                        dataKoran[i].title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return KoranDetailPage(id: dataKoran[i].id);
                          }),
                        );
                      },
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
