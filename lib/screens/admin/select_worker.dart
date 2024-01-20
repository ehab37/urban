import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/cities.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/my_flush.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/constants/request_worker.dart';
import 'package:urban/constants/worker.dart';
import 'package:urban/providers/lang_provider.dart';

class SelectWorkerScreen extends StatefulWidget {
  static const String route = 'SelectWorkerScreen/';
  final RequestWorker requestWorker;

  const SelectWorkerScreen({Key? key, required this.requestWorker})
      : super(key: key);

  @override
  State<SelectWorkerScreen> createState() => _SelectWorkerScreenState();
}

class _SelectWorkerScreenState extends State<SelectWorkerScreen> {
  List<Worker>? workersList;

  getWorkers() async {
    var workers = await Worker().getWorkers(
        category: widget.requestWorker.category!,
        cityId: widget.requestWorker.cityId!);
    setState(() {
      workersList = workers;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWorkers();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.height;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
              '${getLang(context, "selecting")} ${getLang(context, widget.requestWorker.category!)}'),
        ),
        body: workersList == null
            ? myShimmer(context)
            : Stack(
                children: [
                  ListView.builder(
                    itemCount: workersList!.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return workerItem(
                          worker: workersList![index],
                          height: height,
                          index: index);
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: width * .4,
                    child: EbottonI(
                      icon: const Icon(Icons.done, color: Colors.white),
                      elevation: 5,
                      padding: 12,
                      borderRadius: 10,
                      backgroundcolor:
                          Theme.of(context).appBarTheme.backgroundColor!,
                      onpressed: () async {
                        if (selectedIndex == null) {
                          MyFlush().showFlush(
                              context: context,
                              text: ' you must select worker');
                          return;
                        } else {
                          RequestWorker()
                              .editRequest(id: widget.requestWorker.id!, map: {
                            requestWorkerStatus: requested,
                            requestWorkerWorker:
                                Worker().toMap(workersList![selectedIndex!])
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        '${getLang(context, "done")}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ));
  }

  int? selectedIndex;

  workerItem(
      {required double height, required Worker worker, required int index}) {
    var city = City().getCity(key: cityId, value: worker.cityId!);

    var nameStyle = TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: height * .014,
        color: Colors.black);
    var valueStyle = TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: height * .014,
        color: Colors.black);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: selectedIndex == index
              ? Colors.green
              : Theme.of(context).primaryColor,
          elevation: 5,
          child: SizedBox(
            height: height * .22,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: height * .01),
                        child: Text(
                          worker.name!,
                          style: TextStyle(
                              color: Colors.white, fontSize: height * .02),
                        ),
                      ),
                      Material(
                        elevation: 5,
                        color: Colors.white,
                        type: MaterialType.circle,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 35,
                            backgroundImage:
                                CachedNetworkImageProvider(worker.imageUrl!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: height * .08,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('${getLang(context, "category")} : ',
                                    style: nameStyle),
                                Text(
                                  '${getLang(context, worker.category!)}',
                                  style: valueStyle,
                                ),
                              ],
                            ),
                            ChangeNotifierProvider(
                              create: (_) => LangProvider(),
                              child: Consumer<LangProvider>(builder:
                                  (context, LangProvider lanNoty, child) {
                                return Row(
                                  children: [
                                    Text(
                                      '${getLang(context, "city")} : ',
                                      style: nameStyle,
                                    ),
                                    Text(
                                      lanNoty.isEn ? city.en! : city.ar!,
                                      style: valueStyle,
                                    )
                                  ],
                                );
                              }),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${getLang(context, "worker phone")} : ',
                                  style: nameStyle,
                                ),
                                Text(
                                  worker.phone!,
                                  style: valueStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Material(
                          color: Colors.white,
                          elevation: 2,
                          borderRadius: BorderRadius.circular(5),
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(Icons.phone, color: Colors.orange),
                          ),
                        ),
                        const SizedBox()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
