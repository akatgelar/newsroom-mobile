// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pikiranrakyat_newsroom/models/koran_model.dart';
import 'package:pikiranrakyat_newsroom/pages/koran/koran_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class KoranCard extends StatefulWidget {
  const KoranCard({
    Key? key,
    required List<KoranModel> data,
    required this.index,
  })  : dataKoran = data,
        super(key: key);

  final List<KoranModel> dataKoran;
  final int index;

  @override
  State<KoranCard> createState() => _KoranCardState();
}

class _KoranCardState extends State<KoranCard> {
  late DateFormat dateFormat;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMd('id');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return KoranDetailPage(id: widget.dataKoran[widget.index].id);
              }),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.dataKoran[widget.index].image,
                  width: 200,
                  height: 300,
                  // width: 500,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 4),
              Row(children: [
                Text(
                  widget.dataKoran[widget.index].category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "  |  ${dateFormat.format(
                    DateTime.parse(
                      widget.dataKoran[widget.index].created_at,
                    ),
                  )}",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ]),
              Text(
                widget.dataKoran[widget.index].title,
                textAlign: TextAlign.left,
                maxLines: 3,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
