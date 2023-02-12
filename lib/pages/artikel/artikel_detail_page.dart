import 'package:flutter/material.dart';
import 'package:pikiranrakyat_newsroom/models/artikel_model.dart';
import 'package:pikiranrakyat_newsroom/shared/my_appbar_back.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pikiranrakyat_newsroom/shared/skeleton/detail_skeleton.dart';

class ArtikelDetailPage extends StatefulWidget {
  final int id;
  const ArtikelDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ArtikelDetailPage> createState() => _ArtikelDetailPageState();
}

class _ArtikelDetailPageState extends State<ArtikelDetailPage> {
  late DateFormat dateFormat;

  late ArtikelModel dataArtikel = ArtikelModel(
    id: 0,
    title: '',
    slug: '',
    image: '',
    category: '',
    tags: '',
    desc_short: '',
    desc_long: '',
    creator: '',
    source: '',
    created_at: '1970-01-01 12:59:59',
    created_by: 0,
    count_view: 0,
  );

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMd('id');
    getData(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getData(id) {
    ArtikelModel.getById(id.toString()).then((value) {
      setState(() {
        if (value != null) {
          dataArtikel = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const MyAppbarBack(),
        body: dataArtikel.id > 0
            ? ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: NetworkImage(dataArtikel.image),
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              dataArtikel.category,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "  |  ${dateFormat.format(
                                DateTime.parse(
                                  dataArtikel.created_at,
                                ),
                              )}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.bookmark_border,
                              color: Colors.grey,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.share,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Text(
                      dataArtikel.title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Text(
                      dataArtikel.desc_short,
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              )
            : ListView(
                children: const [DetailSkeleton()],
              ));
  }
}
