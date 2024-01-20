import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/MyUser.dart';
import 'package:urban/constants/data/main_info.dart';
import 'package:urban/constants/message_info.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/providers/notifications.dart';
import 'package:urban/screens/user/User_profile.dart';
import 'package:urban/screens/user/user_experts.dart';

import '../providers/fireProvider.dart';
import 'material_screens/section_screen.dart';
import 'user/User_Orders_screen.dart';
import 'user/carts_screen.dart';
import 'equipments_screens/kinds_screen.dart';
import 'user/user_workers.dart';

class Home extends StatefulWidget {
  static const String route = 'Home/';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isChecked = false;
  bool messageIsSeen = true;
  String? myId;

  func() async {
    var fire = Provider.of<FireProvider>(context, listen: false);
    await fire.getMyUserInfo(context: context).then((value) => setState(() {
          myId = fire.myId!;
        }));
    var messageIsSeen1 = await Message().userCheckIsSeen(myUserId: fire.myId!);
    setState(() {
      messageIsSeen = messageIsSeen1;
    });
    debugPrint(messageIsSeen1.toString());
    debugPrint(fire.myId.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    func();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.height;
    }
    height = height;
    width = width;

    return SafeArea(
      child: myId == null
          ? Scaffold(body: Center(child: myCircularIndicator(context)))
          : ChangeNotifierProvider(
              create: (_) => NotifyProvider(),
              child: Consumer<NotifyProvider>(
                  builder: (context, NotifyProvider noty, child) {
                if (!Provider.of<FireProvider>(context, listen: false)
                    .isAdmin!) {
                  if (!isChecked) {
                    noty.checkNoty(
                        myId: Provider.of<FireProvider>(context, listen: false)
                            .myId!);
                    isChecked = true;
                    log('check');
                  }
                }

                //  noty.thePrint();

                return Scaffold(
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  body: Stack(
                    children: [
                      const Positioned(
                        right: 0,
                        top: 0,
                        left: 0,
                        bottom: 0,
                        child: Image(
                            image:
                                AssetImage('assets/images/homeBackground.png'),
                            fit: BoxFit.fill),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [HomeUser()],
                        ),
                      ),
                      /*      Provider.of<FireProvider>(context,listen: false).isAdmin!?

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    _item(text: '${getLang(context, "finishes")}',
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const MaterialSectionsScreen(category: finishes),));},
                        image: 'finishes',
                      noty: false,),

                    _item(text: '${getLang(context, "constructions")}',
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const MaterialSectionsScreen(category: constructions),));},
                        image: 'constructions',
                      noty: false,),

                    _item(text: '${getLang(context, "Equipments")}',
                      onTap: (){Navigator.pushNamed(context, EquipmentsKindScreen.route);},
                      image: 'equipments',
                      noty: false,),


                    _item(text: '${getLang(context, "cart")}',
                        onTap: (){Navigator.pushNamed(context, CallCenterCarts.route);},
                        image: 'cart',
                      noty: false,),




                    _item(text: '${getLang(context, "orders")}',
                        onTap: (){Navigator.pushNamed(context, AdminOrdersScreen.route);},
                        image: 'orders',
                      noty: false,),

                    _item(text: '${getLang(context, "workers")}'
                        ,onTap: (){Navigator.pushNamed(context, AdminWorkersScreen.route);},
                        image: 'workers',
                      noty: false,),

                    _item(text: '${getLang(context, "requests")}'
                        ,onTap: (){Navigator.pushNamed(context, AdminRequestsScreen.route);},
                        image: 'requests',
                      noty: false,),

                    _item(text: '${getLang(context, "messages")}'
                        ,onTap: (){Navigator.pushNamed(context, AdminMessagesList.route);},
                        image: 'messages',
                      noty: false,),



                  ],
                ):*/

                      //user
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _item(
                            text: '${getLang(context, "finishes")}',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MaterialSectionsScreen(
                                            category: finishes),
                                  ));
                            },
                            image: 'finishes',
                            noty: false,
                          ),
                          _item(
                            text: '${getLang(context, "constructions")}',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MaterialSectionsScreen(
                                            category: constructions),
                                  ));
                            },
                            image: 'constructions',
                            noty: false,
                          ),
                          _item(
                            text: '${getLang(context, "Equipments")}',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, EquipmentsKindScreen.route);
                            },
                            image: 'equipments',
                            noty: false,
                          ),
                          _item(
                            text: '${getLang(context, "cart")}',
                            onTap: () async {
                              await Provider.of<NotifyProvider>(context,
                                      listen: false)
                                  .enterCarts();
                              //  print( Provider.of<NotifyProvider>(context,listen: false).currentCarts);
                                if(context.mounted)  {
                                Navigator.pushNamed(context, CartsScreen.route);
                              }
                            },
                            image: 'cart',
                            noty: noty.cartsNoty == null ||
                                    noty.cartsNoty == false
                                ? false
                                : true,
                          ),
                          _item(
                            text: '${getLang(context, "orders")}',
                            onTap: () async {
                              await Provider.of<NotifyProvider>(context,
                                      listen: false)
                                  .enterOrders();
                              if(context.mounted){
                                Navigator.pushNamed(
                                    context, UserOrdersScreen.route);
                              }
                            },
                            image: 'orders',
                            noty: noty.orderedNoty == null ||
                                    noty.orderedNoty == false
                                ? false
                                : true,
                          ),
                          _item(
                            text: '${getLang(context, "workers")}',
                            onTap: () async {
                              await Provider.of<NotifyProvider>(context,
                                      listen: false)
                                  .enterRequests();
                              if(context.mounted){
                                Navigator.pushNamed(
                                    context, UserWorkersScreen.route);
                              }
                            },
                            image: 'userWorker',
                            noty: noty.requestedNoty == null ||
                                    noty.requestedNoty == false
                                ? false
                                : true,
                          ),
                          _item(
                            text: '${getLang(context, "experts")}',
                            onTap: () {
                              setState(() {
                                messageIsSeen = true;
                              });
                              Navigator.pushNamed(
                                  context, UserExpertsScreen.route);
                            },
                            image: 'callCenter',
                            noty: !messageIsSeen,
                          ),
                        ],
                      ),

                      // NewFloatingUser()
                    ],
                  ),
                );
              }),
            ),
    );
  }

  // _homeItem(
  //     {required String name,
  //     required String imageUrl,
  //     required double height,
  //     required VoidCallback onTap}) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: InkWell(
  //       onTap: onTap,
  //       child: Material(
  //         color: Colors.green,
  //         borderRadius: BorderRadius.circular(20),
  //         elevation: 3,
  //         child: Container(
  //           height: 80,
  //           decoration: BoxDecoration(
  //             color: Colors.black, borderRadius: BorderRadius.circular(20),
  //             // image: DecorationImage(image: AssetImage(imageUrl),fit: BoxFit.fill)
  //           ),
  //           child: Stack(
  //             children: [
  //               Center(
  //                 child: Text(
  //                   name,
  //                   style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: height * .02,
  //                       fontWeight: FontWeight.w900,
  //                       shadows: const [
  //                         BoxShadow(
  //                             color: Colors.black,
  //                             spreadRadius: 1,
  //                             blurRadius: 1)
  //                       ]),
  //                 ),
  //               ),
  //               Provider.of<FireProvider>(context, listen: false).isAdmin!
  //                   ? const SizedBox()
  //                   : const Positioned(
  //                       top: 0,
  //                       child: Icon(Icons.radio_button_checked_outlined,
  //                           color: Colors.red),
  //                     )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _item(
      {required VoidCallback onTap,
      required String text,
      required String image,
      required bool noty}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: SizedBox(
            width: 300,
            height: 50,
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 5,
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            text,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            // backgroundImage:  AssetImage('assets/images/homeIcons/$image.png'),
                            radius: 10,
                            backgroundColor: Colors.white.withOpacity(0),
                            child: Image(
                              image: AssetImage(
                                  'assets/images/homeIcons/$image.png'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  noty
                      ? const Positioned(
                          top: 0,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(Icons.notifications_on_rounded,
                                color: Colors.red, size: 15),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeUser extends StatefulWidget {
  const HomeUser({Key? key}) : super(key: key);

  @override
  HomeUserState createState() => HomeUserState();
}

class HomeUserState extends State<HomeUser> {
  MyUser? userInfoo;
  String fName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    var fire = Provider.of<FireProvider>(context, listen: false);
    if (fire.myUserInfo == null) {
      fire.getMyUserInfo(context: context).then((value) {
        var user1 = fire.myUserInfo;
        var name = user1!.name;

        if (name!.contains(' ')) {
          var list = name.split(' ');
          var firstName = list[0];
          setState(() {
            fName = firstName;
          });
        } else {
          setState(() {
            fName = name;
          });
        }
        setState(() {
          userInfoo = user1;
        });
      });
    } else {
      var user1 = fire.myUserInfo;
      var name = user1!.name;

      if (name!.contains(' ')) {
        var list = name.split(' ');
        var firstName = list[0];
        setState(() {
          fName = firstName;
        });
      } else {
        setState(() {
          fName = name;
        });
      }
      setState(() {
        userInfoo = user1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.height;
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, UserProfileScreen.route);
      },
      child: userInfoo == null
          ? myCircularIndicator(context)
          : Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0, right: 3),
                  child: userInfoo!.photo != null
                      ? Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor!,
                                  width: 2,
                                  style: BorderStyle.solid),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    userInfoo!.photo!,
                                  ),
                                  fit: BoxFit.fill)),
                        )
                      : Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(
                                color: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor!,
                                width: 2,
                                style: BorderStyle.solid),
                          ),
                          child: Text(
                            userInfoo!.name![0].toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                ),
                /*    isAdmin!? Text('${getLang(context, "admin")}',style: TextStyle(
             color: Theme.of(context).appBarTheme.backgroundColor!,
             fontWeight: FontWeight.bold,
             fontSize: height*.018),)


             :*/

                Row(
                  children: [
                    Text(
                      '${getLang(context, "welcome")} ,',
                      style: TextStyle(
                          color: Theme.of(context).appBarTheme.backgroundColor!,
                          fontSize: height * .018),
                    ),
                    SizedBox(
                      width: width * .3,
                      child: Text(
                        fName,
                        style: TextStyle(
                          color: Theme.of(context).appBarTheme.backgroundColor!,
                          fontSize: height * .018,
                          fontWeight: FontWeight.w800,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
