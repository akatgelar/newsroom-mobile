// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pikiranrakyat_newsroom/models/artikel_model.dart';
import 'package:pikiranrakyat_newsroom/pages/artikel/artikel_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ArtikelCard extends StatefulWidget {
  const ArtikelCard({
    Key? key,
    required List<ArtikelModel> data,
    required this.index,
  })  : dataArtikel = data,
        super(key: key);

  final List<ArtikelModel> dataArtikel;
  final int index;

  @override
  State<ArtikelCard> createState() => _ArtikelCardState();
}

class _ArtikelCardState extends State<ArtikelCard> {
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
                return ArtikelDetailPage(
                  id: widget.dataArtikel[widget.index].id,
                );
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
                  widget.dataArtikel[widget.index].image,
                  // width: 200,
                  height: 100,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 4),
              Row(children: [
                Text(
                  widget.dataArtikel[widget.index].category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "  |  ${dateFormat.format(
                    DateTime.parse(
                      widget.dataArtikel[widget.index].created_at,
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
                widget.dataArtikel[widget.index].title,
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
