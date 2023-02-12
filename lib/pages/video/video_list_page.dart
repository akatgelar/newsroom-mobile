// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pikiranrakyat_newsroom/models/video_model.dart';
import 'package:pikiranrakyat_newsroom/models/category_model.dart';
import 'package:pikiranrakyat_newsroom/pages/video/video_detail_page.dart';
import 'package:pikiranrakyat_newsroom/shared/skeleton/list_skeleton.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loadmore/loadmore.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({Key? key}) : super(key: key);

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  late DateFormat dateFormat;

  // single choice value
  int tag = 0;
  List<String> dataCategory = ['All'];

  bool isLoadingVideo = true;
  int dataPerPage = 5;
  int dataPage = 1;
  bool dataEmpty = false;
  String dataSort = 'updated_at:desc';

  List<VideoModel> dataVideo = [];
  final PageController videoController = PageController(
    keepPage: false,
    viewportFraction: 1,
    initialPage: 0,
  );

  final formKey = GlobalKey<FormState>();
  List<String>? formValue;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMd('id');
    getCategory();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getCategory() {
    CategoryModel.getAll('video_category').then((value) {
      setState(() {
        if (value != null) {
          for (var element in value) {
            dataCategory.add(element.category);
          }
        }
      });
      isLoadingVideo = false;
    });
  }

  void getData() {
    isLoadingVideo = true;
    VideoModel.getAll(dataPerPage, dataPage, dataSort).then((value) {
      setState(() {
        if (value != null) {
          for (var element in value) {
            dataVideo.add(element);
          }
        } else {
          dataEmpty = true;
        }
      });
      isLoadingVideo = false;
    });
  }

  Future<bool> loadMore() async {
    dataPage += 1;
    await VideoModel.getAll(dataPerPage, dataPage, dataSort).then((value) {
      setState(() {
        if (value!.isNotEmpty) {
          for (var element in value) {
            dataVideo.add(element);
          }
        } else {
          dataEmpty = true;
        }
      });
    });
    if (dataEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> loadRefresh() async {
    dataPage = 1;
    dataEmpty = false;
    dataVideo.clear();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChipsChoice<int>.single(
          value: tag,
          onChanged: (val) => setState(() {
            tag = val;
            print(tag);
            print(dataCategory[tag]);
          }),
          choiceItems: C2Choice.listFrom<int, String>(
            source: dataCategory,
            value: (i, v) => i,
            label: (i, v) => v,
          ),
          choiceActiveStyle: const C2ChoiceStyle(
            color: Colors.white,
            borderColor: Colors.blue,
            backgroundColor: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          choiceStyle: const C2ChoiceStyle(
            color: Colors.blue,
            borderColor: Colors.blue,
            backgroundColor: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              contentPadding: EdgeInsets.all(10.0),
              hintText: 'Cari video..',
              hintStyle: TextStyle(color: Colors.blue),
              prefixIcon: Icon(
                Ionicons.search,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        Expanded(
          child: dataVideo.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: loadRefresh,
                  child: LoadMore(
                    isFinish: dataEmpty,
                    onLoadMore: loadMore,
                    whenEmptyLoad: false,
                    delegate: const DefaultLoadMoreDelegate(),
                    textBuilder: (status) {
                      if (status == LoadMoreStatus.nomore || dataEmpty) {
                        return "Tidak ada video lagi";
                      }
                      return DefaultLoadMoreTextBuilder.english(status);
                    },
                    child: ListView.builder(
                      controller: videoController,
                      itemCount: dataVideo.length,
                      itemBuilder: (BuildContext context, index) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return VideoDetailPage(
                                    id: dataVideo[index].id,
                                  );
                                }),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        image: NetworkImage(
                                          dataVideo[index].image,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Center(
                                      widthFactor: 3,
                                      heightFactor: 2,
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/icon_video.png"),
                                        height: 40,
                                      ),
                                    ),
                                  ]),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dataVideo[index].category,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "  |  ${dateFormat.format(
                                              DateTime.parse(
                                                dataVideo[index].created_at,
                                              ),
                                            )}",
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          dataVideo[index].title,
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : ListView(
                  children: const [
                    ListSkeleton(),
                    ListSkeleton(),
                    ListSkeleton(),
                    ListSkeleton(),
                    ListSkeleton(),
                  ],
                ),
        ),
      ],
    );
  }
}
