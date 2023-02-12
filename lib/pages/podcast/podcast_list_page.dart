// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pikiranrakyat_newsroom/models/podcast_model.dart';
import 'package:pikiranrakyat_newsroom/models/category_model.dart';
import 'package:pikiranrakyat_newsroom/pages/podcast/podcast_detail_page.dart';
import 'package:pikiranrakyat_newsroom/shared/skeleton/list_skeleton.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loadmore/loadmore.dart';

class PodcastListPage extends StatefulWidget {
  const PodcastListPage({Key? key}) : super(key: key);

  @override
  State<PodcastListPage> createState() => _PodcastListPageState();
}

class _PodcastListPageState extends State<PodcastListPage> {
  late DateFormat dateFormat;

  // single choice value
  int tag = 0;
  List<String> dataCategory = ['All'];

  bool isLoadingPodcast = true;
  int dataPerPage = 5;
  int dataPage = 1;
  bool dataEmpty = false;
  String dataSort = 'updated_at:desc';

  List<PodcastModel> dataPodcast = [];
  final PageController podcastController = PageController(
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
    CategoryModel.getAll('podcast_category').then((value) {
      setState(() {
        if (value != null) {
          for (var element in value) {
            dataCategory.add(element.category);
          }
        }
      });
      isLoadingPodcast = false;
    });
  }

  void getData() {
    isLoadingPodcast = true;
    PodcastModel.getAll(dataPerPage, dataPage, dataSort).then((value) {
      setState(() {
        if (value != null) {
          for (var element in value) {
            dataPodcast.add(element);
          }
        } else {
          dataEmpty = true;
        }
      });
      isLoadingPodcast = false;
    });
  }

  Future<bool> loadMore() async {
    dataPage += 1;
    await PodcastModel.getAll(dataPerPage, dataPage, dataSort).then((value) {
      setState(() {
        if (value!.isNotEmpty) {
          for (var element in value) {
            dataPodcast.add(element);
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
    dataPodcast.clear();
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
              hintText: 'Cari podcast..',
              hintStyle: TextStyle(color: Colors.blue),
              prefixIcon: Icon(
                Ionicons.search,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        Expanded(
          child: dataPodcast.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: loadRefresh,
                  child: LoadMore(
                    isFinish: dataEmpty,
                    onLoadMore: loadMore,
                    whenEmptyLoad: false,
                    delegate: const DefaultLoadMoreDelegate(),
                    textBuilder: (status) {
                      if (status == LoadMoreStatus.nomore || dataEmpty) {
                        return "Tidak ada podcast lagi";
                      }
                      return DefaultLoadMoreTextBuilder.english(status);
                    },
                    child: ListView.builder(
                      controller: podcastController,
                      itemCount: dataPodcast.length,
                      itemBuilder: (BuildContext context, index) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return PodcastDetailPage(
                                    id: dataPodcast[index].id,
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
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image(
                                            image: NetworkImage(
                                              dataPodcast[index].image,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                              "assets/images/icon_podcast.png",
                                            ),
                                            height: 45,
                                          ),
                                        ),
                                      ],
                                    )),
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
                                            dataPodcast[index].category,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "  |  ${dateFormat.format(
                                              DateTime.parse(
                                                dataPodcast[index].created_at,
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
                                          dataPodcast[index].title,
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
