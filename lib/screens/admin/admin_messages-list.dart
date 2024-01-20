import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/MyUser.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/message_info.dart';
import 'package:urban/constants/my_indicators.dart';

import 'admin_chat.dart';

class AdminMessagesList extends StatefulWidget {
  static const String route = 'AdminMessagesList/';

  const AdminMessagesList({Key? key}) : super(key: key);

  @override
  State<AdminMessagesList> createState() => _AdminMessagesListState();
}

class _AdminMessagesListState extends State<AdminMessagesList> {
  List<MyUser>? myUsersMessages;

  getAdminsChatList() async {
    var myUsersMessages1 = await Message().getAdminsChatList();
    setState(() {
      myUsersMessages = myUsersMessages1.reversed.toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdminsChatList();
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
    height = height;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text('${getLang(context, "messages")}'),
        toolbarHeight: 50,
      ),
      body: myUsersMessages == null
          ? myShimmer(context)
          : Stack(
              children: [
                ListView.builder(
                  itemCount: myUsersMessages!.length,
                  itemExtent: 80,
                  itemBuilder: (context, index) => UserChatUnit(
                    user: myUsersMessages![index],
                  ),
                ),
                const NewFloatingAdmin()
              ],
            ),
    );
  }
}

class UserChatUnit extends StatefulWidget {
  final MyUser user;

  const UserChatUnit({Key? key, required this.user}) : super(key: key);

  @override
  UserChatUnitState createState() => UserChatUnitState();
}

class UserChatUnitState extends State<UserChatUnit> {
  bool adminIsSeen = false;

  adminCheckSeen() async {
    //var myId =Provider.of<FireProvider>(context,listen: false).myId;

    bool x = await Message().adminCheckIsSeen(userId: widget.user.id!);
    setState(() {
      adminIsSeen = x;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminCheckSeen();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.height;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminChatScreen(myUser: widget.user),
                )).then((value) => adminCheckSeen());
          },
          child: Material(
            elevation: 5,
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Material(
                        color: Theme.of(context).primaryColor,
                        elevation: 2,
                        type: MaterialType.circle,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: widget.user.photo != null
                              ? CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    widget.user.photo!,
                                  ),
                                  radius: 30,
                                  backgroundColor: Colors.blue.withOpacity(0),
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Text(
                                    widget.user.name![0].toUpperCase(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .appBarTheme
                                            .backgroundColor,
                                        fontSize: height * .025),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        width: width * .4,
                        child: Text(
                          widget.user.name!,
                          style: TextStyle(
                              color: adminIsSeen
                                  ? Colors.black.withOpacity(.5)
                                  : Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    )
                  ],
                ),
                adminIsSeen
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              '${getLang(context, "new message")}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  fontSize: height * .01,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.message,
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  size: height * .02),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          )),
    );
  }
}
