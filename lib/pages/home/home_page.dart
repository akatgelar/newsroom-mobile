import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pikiranrakyat_newsroom/models/artikel_model.dart';
import 'package:pikiranrakyat_newsroom/models/koran_model.dart';
import 'package:pikiranrakyat_newsroom/models/podcast_model.dart';
import 'package:pikiranrakyat_newsroom/models/slider_model.dart';
import 'package:pikiranrakyat_newsroom/models/video_model.dart';
import 'package:pikiranrakyat_newsroom/shared/card/artikel_card.dart';
import 'package:pikiranrakyat_newsroom/shared/card/koran_card.dart';
import 'package:pikiranrakyat_newsroom/shared/card/podcast_card.dart';
import 'package:pikiranrakyat_newsroom/shared/card/video_card.dart';
import 'package:pikiranrakyat_newsroom/shared/skeleton/slider_skeleton.dart';
import 'package:pikiranrakyat_newsroom/shared/skeleton/card_skeleton.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int> changeTab;
  const HomePage({Key? key, required this.changeTab}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variable
  int sliderCurrent = 0;
  bool isLoadingSlider = true;
  bool isLoadingArtikel = true;
  bool isLoadingVideo = true;
  bool isLoadingPodcast = true;
  bool isLoadingKoran = true;

  int dataPerPage = 4;
  int dataPage = 1;
  String dataSort = 'updated_at:desc';
  List<SliderModel> dataSlider = [];
  List<ArtikelModel> dataArtikel = [];
  List<VideoModel> dataVideo = [];
  List<PodcastModel> dataPodcast = [];
  List<KoranModel> dataKoran = [];

  final CarouselController slidercontroller = CarouselController();

  final PageController artikelController = PageController(
    keepPage: false,
    viewportFraction: 1,
    initialPage: 0,
  );

  final PageController videoController = PageController(
    keepPage: false,
    viewportFraction: 1,
    initialPage: 0,
  );

  final PageController podcastController = PageController(
    keepPage: false,
    viewportFraction: 1,
    initialPage: 0,
  );

  final PageController koranController = PageController(
    keepPage: false,
    viewportFraction: 1,
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    getSlider();
    getArtikel();
    getVideo();
    getPodcast();
    getKoran();
  }

  void getSlider() {
    isLoadingSlider = true;
    SliderModel.getAll(dataPerPage, dataPage, dataSort).then((value) {
      setState(() {
        if (value != null) {
          for (var element in value) {
            dataSlider.add(element);
          }
        }
      });
      isLoadingSlider = false;
    });
  }

  void getArtikel() {
    isLoadingArtikel = true;
    ArtikelModel.getAll(dataPerPage, dataPage, dataSort).then((value) {
      setState(() {
        if (value != null) {
          for (var element in value) {
            dataArtikel.add(element);
          }
        }
      });
      isLoadingArtikel = false;
    });
  }

  void getVideo() {
    isLoadingVideo = true;
    VideoModel.getAll(dataPerPage, dataPage, dataSort).then((value) {
      setState(() {
        if (value != null) {
          for (var element in value) {
            dataVideo.add(element);
          }
        }
      });
      isLoadingVideo = false;
    });
  }

  void getPodcast() {
    isLoadingPodcast = true;
    PodcastModel.getAll(dataPerPage, dataPage, dataSort).then((value) {
      setState(() {
        if (value != null) {
          for (var element in value) {
            dataPodcast.add(element);
          }
        }
      });
      isLoadingPodcast = false;
    });
  }

  void getKoran() {
    isLoadingKoran = true;
    KoranModel.getAll(dataPerPage, dataPage, dataSort).then((value) {
      setState(() {
        if (value != null) {
          for (var element in value) {
            dataKoran.add(element);
          }
        }
      });
      isLoadingKoran = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // slider
    Container sectionSlider = Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              items: dataSlider
                  .map(
                    (item) => InkWell(
                      onTap: () {
                        if (item.category == 'Artikel') {
                          widget.changeTab(1);
                        } else if (item.category == 'Video') {
                          widget.changeTab(2);
                        } else if (item.category == 'Podcast') {
                          widget.changeTab(3);
                        } else if (item.category == 'Koran') {
                          widget.changeTab(4);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        child: Stack(
                          children: <Widget>[
                            Image(
                              image: NetworkImage(item.image),
                              fit: BoxFit.cover,
                              width: 1000.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
              carouselController: slidercontroller,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: false,
                  aspectRatio: 2.9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      sliderCurrent = index;
                    });
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: dataSlider.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => slidercontroller.animateToPage(entry.key),
                child: Container(
                  width: 7.0,
                  height: 7.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.blue)
                        .withOpacity(sliderCurrent == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );

    // artikel
    Container sectionArtikel = Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      margin: const EdgeInsets.only(right: 10),
      child: PageView.builder(
        padEnds: false,
        controller: artikelController,
        itemCount: dataArtikel.length ~/ 2 + dataArtikel.length % 2,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                child: ArtikelCard(
                  data: dataArtikel,
                  index: index * 2,
                ),
              ),
              Expanded(
                child: index * 2 + 1 < dataArtikel.length
                    ? ArtikelCard(
                        data: dataArtikel,
                        index: index * 2 + 1,
                      )
                    : const SizedBox(),
              ),
            ],
          );
        },
      ),
    );

    // video
    Container sectionVideo = Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      margin: const EdgeInsets.only(right: 10),
      child: PageView.builder(
        padEnds: true,
        controller: videoController,
        itemCount: dataVideo.length ~/ 2 + dataVideo.length % 2,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                child: VideoCard(data: dataVideo, index: index * 2),
              ),
              Expanded(
                child: index * 2 + 1 < dataVideo.length
                    ? VideoCard(data: dataVideo, index: index * 2 + 1)
                    : const SizedBox(),
              )
            ],
          );
        },
      ),
    );

    // podcast
    Container sectionPodcast = Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.32,
      margin: const EdgeInsets.only(right: 10),
      child: PageView.builder(
        padEnds: true,
        controller: podcastController,
        itemCount: dataPodcast.length ~/ 2 + dataPodcast.length % 2,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                child: PodcastCard(data: dataPodcast, index: index * 2),
              ),
              Expanded(
                child: index * 2 + 1 < dataPodcast.length
                    ? PodcastCard(data: dataPodcast, index: index * 2 + 1)
                    : const SizedBox(),
              ),
            ],
          );
        },
      ),
    );

    // koran
    Container sectionKoran = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.50,
      margin: const EdgeInsets.only(right: 10),
      child: PageView.builder(
        padEnds: true,
        controller: koranController,
        itemCount: dataKoran.length ~/ 2 + dataKoran.length % 2,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                child: KoranCard(data: dataKoran, index: index * 2),
              ),
              Expanded(
                child: index * 2 + 1 < dataKoran.length
                    ? KoranCard(data: dataKoran, index: index * 2 + 1)
                    : const SizedBox(),
              ),
            ],
          );
        },
      ),
    );

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 10,
                bottom: 5,
                top: 10,
                right: 10,
              ),
              child: const Text(
                "Beranda",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            isLoadingSlider ? const SliderSkeleton() : sectionSlider,
            Material(
              color: Colors.white,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 10, bottom: 0, top: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    widget.changeTab(1);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Artikel Terbaru",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.lightBlue,
                      )
                    ],
                  ),
                ),
              ),
            ),
            isLoadingArtikel ? const CardSkeleton() : sectionArtikel,
            Material(
              color: Colors.white,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  bottom: 0,
                  top: 10,
                  right: 10,
                ),
                child: InkWell(
                  onTap: () {
                    widget.changeTab(2);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Video Terbaru",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.lightBlue,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isLoadingVideo ? const CardSkeleton() : sectionVideo,
            Material(
              color: Colors.white,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  bottom: 0,
                  top: 10,
                  right: 10,
                ),
                child: InkWell(
                  onTap: () {
                    widget.changeTab(3);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Podcast Terbaru",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.lightBlue,
                      )
                    ],
                  ),
                ),
              ),
            ),
            isLoadingPodcast ? const CardSkeleton() : sectionPodcast,
            Material(
              color: Colors.white,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  bottom: 0,
                  top: 10,
                  right: 10,
                ),
                child: InkWell(
                  onTap: () {
                    widget.changeTab(4);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Koran Terbaru",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.lightBlue,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isLoadingKoran ? const CardSkeleton() : sectionKoran,
          ],
        ),
      ),
    );
  }
}
