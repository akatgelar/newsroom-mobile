// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pikiranrakyat_newsroom/models/podcast_model.dart';
import 'package:pikiranrakyat_newsroom/pages/podcast/podcast_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class PodcastCard extends StatefulWidget {
  const PodcastCard({
    Key? key,
    required List<PodcastModel> data,
    required this.index,
  })  : dataPodcast = data,
        super(key: key);

  final List<PodcastModel> dataPodcast;
  final int index;

  @override
  State<PodcastCard> createState() => _PodcastCardState();
}

class _PodcastCardState extends State<PodcastCard> {
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
                return PodcastDetailPage(
                  id: widget.dataPodcast[widget.index].id,
                );
              }),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.dataPodcast[widget.index].image,
                      // width: 200,
                      height: 150,
                      // width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    heightFactor: 3,
                    widthFactor: 3,
                    child: Image(
                      image: AssetImage('assets/images/icon_podcast.png'),
                      height: 50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(children: [
                Text(
                  widget.dataPodcast[widget.index].category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "  |  ${dateFormat.format(
                    DateTime.parse(
                      widget.dataPodcast[widget.index].created_at,
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
                widget.dataPodcast[widget.index].title,
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
