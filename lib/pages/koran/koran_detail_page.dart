import 'package:flutter/material.dart';
import 'package:pikiranrakyat_newsroom/models/koran_model.dart';
import 'package:pikiranrakyat_newsroom/shared/my_appbar_back.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pikiranrakyat_newsroom/shared/skeleton/detail_skeleton.dart';

class KoranDetailPage extends StatefulWidget {
  final int id;
  const KoranDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<KoranDetailPage> createState() => _KoranDetailPageState();
}

class _KoranDetailPageState extends State<KoranDetailPage> {
  late DateFormat dateFormat;

  late KoranModel dataKoran = KoranModel(
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
    edition: '',
    link: '',
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
    KoranModel.getById(id.toString()).then((value) {
      setState(() {
        if (value != null) {
          dataKoran = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const MyAppbarBack(),
        body: dataKoran.id > 0
            ? ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: NetworkImage(dataKoran.image),
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 400,
                        fit: BoxFit.fitHeight,
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
                              dataKoran.category,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "  |  ${dateFormat.format(
                                DateTime.parse(
                                  dataKoran.created_at,
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
                      dataKoran.title,
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
                      dataKoran.desc_short,
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              )
            : ListView(
                children: const [DetailSkeleton()],
              ));
    //         Container(
    //   margin: EdgeInsets.all(15),
    //   color: Colors.white,
    //   child: ListView(
    //     children: [
    //       Container(
    //         /*width: MediaQuery.of(context).size.width,
    //         height: MediaQuery.of(context).size.height,*/
    //         color: Colors.white,
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text(
    //             "PROFIL ANDA",
    //             style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 color: Color.fromRGBO(40, 168, 224, 1)),
    //           ),
    //         ),
    //       ),
    //       Container(
    //           color: Colors.white,
    //           child: Column(
    //             children: [
    //               ListTile(
    //                 leading: Image.asset('assets/images/uploadfile.png'),
    //                 title: Text('SURE NAME'),
    //                 subtitle: Text('surename@gmail.com'),
    //               ),
    //             ],
    //           )),
    //     ],
    //   ),
    // ),
    // );
  }
}
