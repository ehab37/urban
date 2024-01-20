import 'dart:developer';

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

import 'select_worker.dart';

class AdminRequestsScreen extends StatefulWidget {
  static const String route = 'AdminRequestsScreen/';

  const AdminRequestsScreen({Key? key}) : super(key: key);

  @override
  State<AdminRequestsScreen> createState() => _AdminRequestsScreenState();
}

class _AdminRequestsScreenState extends State<AdminRequestsScreen> {
  List<RequestWorker>? allRequests;
  List<RequestWorker>? requestingList;
  List<RequestWorker>? requestedList;

  getAllRequests() async {
    var allRequests1 = await RequestWorker().getAllRequests();
    setState(() {
      requestingList = allRequests1
          .where((element) => element.status == requesting)
          .toList();
      requestedList =
          allRequests1.where((element) => element.status == requested).toList();
    });
    log(requestingList!.length.toString());
    log(requestedList!.length.toString());
    log(allRequests1.length.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllRequests();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.height;
    }
    width = width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            physics: const RangeMaintainingScrollPhysics(),
            padding: const EdgeInsets.all(0),
            automaticIndicatorColorAdjustment: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 7,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                height: 70,
                icon: Icon(Icons.cloud_done_rounded,
                    color: Theme.of(context).primaryColor.withOpacity(.5)),
                child: Text('${getLang(context, "requested")}',
                    style: TextStyle(color: Theme.of(context).primaryColor)),
              ),
              Tab(
                height: 70,
                icon: Icon(Icons.alarm,
                    color: Theme.of(context).primaryColor.withOpacity(.5)),
                child: Text('${getLang(context, "waiting")}',
                    style: TextStyle(color: Theme.of(context).primaryColor)),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                requestedList == null
                    ? myShimmer(context)
                    : ListView.builder(
                        itemCount: requestedList!.length,
                        itemBuilder: (context, index) => requestedItem(
                            height: height,
                            requestWorker: requestedList![index]),
                      ),
                requestingList == null
                    ? myShimmer(context)
                    : ListView.builder(
                        itemCount: requestingList!.length,
                        itemBuilder: (context, index) => requestingItem(
                            height: height,
                            requestWorker: requestingList![index]),
                      ),
              ],
            ),
            const NewFloatingAdmin()
          ],
        ),
      ),
    );
  }

  requestingItem(
      {required double height, required RequestWorker requestWorker}) {
    var city = City().getCity(key: cityId, value: requestWorker.cityId!);
    var nameStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: height * .014);
    var valueStyle =
        TextStyle(fontWeight: FontWeight.normal, fontSize: height * .014);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        elevation: 5,
        child: Container(
          height: height * .22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            //color: Colors.yellow
          ),
          child: Stack(
            children: [
              Positioned(
                child: InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                              elevation: 5,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: SizedBox(
                                height: height * .2,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Center(
                                        child: Text(
                                      '${getLang(context, "are you sure")}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black),
                                    )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        EbottonI(
                                          onpressed: () async {
                                            MyIndicator().loading(context);
                                            await RequestWorker().removeRequest(
                                                requestId: requestWorker.id!);
                                            await getAllRequests();
                                            if(context.mounted){
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            MyFlush().showDeletingDoneFlush(
                                                context: context);

                                            }
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red.withOpacity(.5),
                                          ),
                                          elevation: 3,
                                          borderRadius: 10,
                                          backgroundcolor: Colors.white,
                                          padding: 10,
                                          overColor: Colors.red,
                                          shadowcolor: Colors.black,
                                          child: Text(
                                              '${getLang(context, "yes")}',
                                              style: const TextStyle(
                                                  color: Colors.black)),
                                        ),
                                        EbottonI(
                                          onpressed: () async {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.keyboard_return,
                                            color: Colors.green.withOpacity(.5),
                                          ),
                                          elevation: 3,
                                          borderRadius: 10,
                                          backgroundcolor: Colors.white,
                                          padding: 10,
                                          overColor: Colors.red,
                                          shadowcolor: Colors.black,
                                          child: Text(
                                              '${getLang(context, "no")}',
                                              style: const TextStyle(
                                                  color: Colors.black)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: Material(
                    color: Colors.white,
                    elevation: 3,
                    type: MaterialType.circle,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(Icons.cancel,
                          color: Colors.redAccent.withOpacity(.5)),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${getLang(context, "category")} : ',
                              style: nameStyle,
                            ),
                            Text(
                              '${getLang(context, requestWorker.category!)}',
                              style: valueStyle,
                            )
                          ],
                        ),
                        ChangeNotifierProvider(
                          create: (_) => LangProvider(),
                          child: Consumer<LangProvider>(
                              builder: (context, LangProvider lanNoty, child) {
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
                              '${getLang(context, "phone")} : ',
                              style: nameStyle,
                            ),
                            Text(requestWorker.phone!, style: valueStyle)
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${getLang(context, "date")} : ',
                              style: nameStyle,
                            ),
                            Text(requestWorker.date!, style: valueStyle)
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${getLang(context, "time")} : ',
                              style: nameStyle,
                            ),
                            Text(
                              requestWorker.time!,
                              style: valueStyle,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Material(
                      elevation: 5,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectWorkerScreen(
                                    requestWorker: requestWorker),
                              )).then((value) => getAllRequests());
                        },
                        child: SizedBox(
                            height: height * .1,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                  child: Text(
                                      '${getLang(context, "select worker")}')),
                            )),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  requestedItem(
      {required double height, required RequestWorker requestWorker}) {
    var nameStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: height * .014);
    var valueStyle =
        TextStyle(fontWeight: FontWeight.normal, fontSize: height * .014);
    var city = City().getCity(key: cityId, value: requestWorker.cityId!);
    Worker worker = Worker.fromJson(requestWorker.worker!);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        elevation: 5,
        child: Container(
          height: height * .22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            //color: Colors.yellow
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${getLang(context, "name")} : ',
                          style: nameStyle,
                        ),
                        Text(
                          worker.name!,
                          style: valueStyle,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${getLang(context, "category")} : ',
                          style: nameStyle,
                        ),
                        Text(
                          '${getLang(context, requestWorker.category!)}',
                          style: valueStyle,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${getLang(context, "city")} : ',
                          style: nameStyle,
                        ),
                        ChangeNotifierProvider(
                          create: (_) => LangProvider(),
                          child: Consumer<LangProvider>(
                              builder: (context, LangProvider lanNoty, child) {
                            return Text(
                              lanNoty.isEn ? city.en! : city.ar!,
                              style: valueStyle,
                            );
                          }),
                        ),
                      ],
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
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${getLang(context, "date")} : ',
                          style: nameStyle,
                        ),
                        Text(
                          requestWorker.date!,
                          style: valueStyle,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${getLang(context, "time")} : ',
                          style: nameStyle,
                        ),
                        Text(requestWorker.time!, style: valueStyle)
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                        elevation: 5,
                        color: Colors.white,
                        type: MaterialType.circle,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              worker.imageUrl!,
                            ),
                            radius: 40,
                          ),
                        )),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectWorkerScreen(
                                  requestWorker: requestWorker,
                                ),
                              )).then((value) => getAllRequests());
                        },
                        child: Material(
                          color: Colors.white,
                          elevation: 3,
                          type: MaterialType.circle,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(Icons.change_circle,
                                color: Colors.red.withOpacity(.5)),
                          ),
                        ),
                      ), //change
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                    elevation: 5,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: SizedBox(
                                      height: height * .2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Center(
                                              child: Text(
                                            '${getLang(context, "are you sure")}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black),
                                          )),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              EbottonI(
                                                onpressed: () async {
                                                  MyIndicator()
                                                      .loading(context);
                                                  await RequestWorker()
                                                      .removeRequest(
                                                          requestId:
                                                              requestWorker
                                                                  .id!);
                                                  await getAllRequests();
                                                  if(context.mounted){
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    MyFlush()
                                                        .showDeletingDoneFlush(
                                                            context: context);
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red
                                                      .withOpacity(.5),
                                                ),
                                                elevation: 3,
                                                borderRadius: 10,
                                                backgroundcolor: Colors.white,
                                                padding: 10,
                                                overColor: Colors.red,
                                                shadowcolor: Colors.black,
                                                child: Text(
                                                    '${getLang(context, "yes")}',
                                                    style: const TextStyle(
                                                        color: Colors.black)),
                                              ),
                                              EbottonI(
                                                onpressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(
                                                  Icons.keyboard_return,
                                                  color: Colors.green
                                                      .withOpacity(.5),
                                                ),
                                                elevation: 3,
                                                borderRadius: 10,
                                                backgroundcolor: Colors.white,
                                                padding: 10,
                                                overColor: Colors.red,
                                                shadowcolor: Colors.black,
                                                child: Text(
                                                    '${getLang(context, "no")}',
                                                    style: const TextStyle(
                                                        color: Colors.black)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        child: Material(
                          color: Colors.white,
                          elevation: 3,
                          type: MaterialType.circle,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(Icons.cancel,
                                color: Colors.redAccent.withOpacity(.5)),
                          ),
                        ),
                      ), //delete
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
