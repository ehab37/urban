import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/cities.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/constants/worker.dart';
import 'package:urban/providers/lang_provider.dart';

import 'add_worker.dart';

class AdminWorkersScreen extends StatefulWidget {
  static const String route = 'AdminWorkersScreen/';

  const AdminWorkersScreen({Key? key}) : super(key: key);

  @override
  State<AdminWorkersScreen> createState() => _AdminWorkersScreenState();
}

class _AdminWorkersScreenState extends State<AdminWorkersScreen> {
  List<Worker>? allWorkers;

  getAllWorkers() async {
    var allWorkers1 = await Worker().getAllWorkers();
    setState(() {
      allWorkers = allWorkers1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllWorkers();
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
      appBar: AppBar(title: Text('${getLang(context, "workers")}')),
      body: allWorkers == null
          ? myShimmer(context)
          : Stack(
              children: [
                ListView.builder(
                  itemCount: allWorkers!.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) =>
                      workerItem(worker: allWorkers![index], height: height),
                ),
                Positioned(
                  bottom: 10,
                  right: width * .4,
                  child: InkWell(
                    onTap: () async {
                      await Navigator.pushNamed(context, AddWorkerScreen.route)
                          .then((value) => getAllWorkers());
                    },
                    child: Material(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      shadowColor: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16),
                        child: Center(
                          child: Text(
                            '${getLang(context, "add worker")}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const NewFloatingAdmin()
              ],
            ),
    );
  }

  workerItem({required double height, required Worker worker}) {
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
      child: Stack(
        children: [
          Material(
            elevation: 3,
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: height * .01),
                          child: Text(
                            worker.name!,
                            style: TextStyle(
                                color: Colors.black, fontSize: height * .02),
                          ),
                        ),
                        Material(
                          elevation: 3,
                          color: Theme.of(context).primaryColor,
                          type: MaterialType.circle,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                  Text(
                                    '${getLang(context, "category")} : ',
                                    style: nameStyle,
                                  ),
                                  Text(
                                    '${getLang(context, worker.category!)}',
                                    style: nameStyle,
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
                                  Text(worker.phone!, style: nameStyle),
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
          Positioned(
            top: 10,
            //left: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: SizedBox(
                            height: height * .2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('${getLang(context, "are you sure")}'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Ebotton(
                                        onpressed: () async {
                                          await Worker().removeWorker(
                                              workerId: worker.id!);
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        elevation: 5,
                                        borderRadius: 10,
                                        backgroundcolor: Colors.white,
                                        padding: 10,
                                        overColor: Colors.red.withOpacity(.2),
                                        child: Text(
                                          '${getLang(context, "delete")}',
                                          style: const TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                      ),
                                      Ebotton(
                                        onpressed: () {
                                          Navigator.pop(context);
                                        },
                                        elevation: 5,
                                        borderRadius: 10,
                                        backgroundcolor: Colors.white,
                                        padding: 10,
                                        overColor: Colors.red.withOpacity(.2),
                                        child: Text(
                                          '${getLang(context, "cancel")}',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });

                  getAllWorkers();
                },
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(Icons.delete_forever_sharp,
                        color: Colors.red.withOpacity(.5)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
