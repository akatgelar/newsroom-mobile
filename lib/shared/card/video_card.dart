// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pikiranrakyat_newsroom/models/video_model.dart';
import 'package:pikiranrakyat_newsroom/pages/video/video_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({
    Key? key,
    required List<VideoModel> data,
    required this.index,
  })  : dataVideo = data,
        super(key: key);

  final List<VideoModel> dataVideo;
  final int index;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
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
                return VideoDetailPage(id: widget.dataVideo[widget.index].id);
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
                      widget.dataVideo[widget.index].image,
                      // width: 200,
                      height: 100,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    heightFactor: 2,
                    child: Image(
                      image: AssetImage('assets/images/icon_video.png'),
                      height: 50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(children: [
                Text(
                  widget.dataVideo[widget.index].category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "  |  ${dateFormat.format(
                    DateTime.parse(
                      widget.dataVideo[widget.index].created_at,
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
                widget.dataVideo[widget.index].title,
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
