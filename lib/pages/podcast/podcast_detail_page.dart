// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pikiranrakyat_newsroom/models/podcast_model.dart';
import 'package:pikiranrakyat_newsroom/shared/my_appbar_back.dart';
import 'package:pikiranrakyat_newsroom/shared/skeleton/detail_skeleton.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:pikiranrakyat_newsroom/shared/audio_common.dart';
import 'package:pikiranrakyat_newsroom/shared/audio_control.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:just_audio_example/common.dart';
import 'package:rxdart/rxdart.dart';

class PodcastDetailPage extends StatefulWidget {
  final int id;
  const PodcastDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _PodcastDetailPageState createState() => _PodcastDetailPageState();
}

class _PodcastDetailPageState extends State<PodcastDetailPage> {
  late DateFormat dateFormat;

  late PodcastModel dataPodcast = PodcastModel(
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
    link_type: '',
    link: '',
  );

  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMd('id');
    getData(widget.id);

    // ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
  }

  @override
  void dispose() {
    // ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    _player.dispose();
    super.dispose();
  }

  void getData(id) {
    PodcastModel.getById(id.toString()).then((value) {
      setState(() {
        if (value != null) {
          dataPodcast = value;
          _init(dataPodcast.link);
        }
      });
    });
  }

  Future<void> _init(url) async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const MyAppbarBack(),
        body: dataPodcast.id > 0
            ? ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: NetworkImage(dataPodcast.image),
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ControlButtons(_player),
                  StreamBuilder<PositionData>(
                    stream: _positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return SeekBar(
                        duration: positionData?.duration ?? Duration.zero,
                        position: positionData?.position ?? Duration.zero,
                        bufferedPosition:
                            positionData?.bufferedPosition ?? Duration.zero,
                        onChangeEnd: _player.seek,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              dataPodcast.category,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "  |  ${dateFormat.format(
                                DateTime.parse(
                                  dataPodcast.created_at,
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
                      dataPodcast.title,
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
                      dataPodcast.desc_short,
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
