import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:urban/constants/MyUser.dart';
import 'package:urban/constants/message_info.dart';
import 'package:urban/constants/my_flush.dart';
import 'package:urban/providers/fireProvider.dart';
import 'package:urban/screens/image_view_screen.dart';

class AdminChatScreen extends StatefulWidget {
  static const String route = 'AdminChatScreen/';
  final MyUser myUser;

  const AdminChatScreen({Key? key, required this.myUser}) : super(key: key);

  @override
  State<AdminChatScreen> createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  TextEditingController textController = TextEditingController();
  List<Message> messages = [];

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: width * .5, child: Text(widget.myUser.name!)),
            const SizedBox(width: 20),
            widget.myUser.photo != null
                ? CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(widget.myUser.photo!),
                    radius: 20,
                  )
                : Material(
                    color: Theme.of(context).primaryColor,
                    type: MaterialType.circle,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        // radius: 30,
                        backgroundColor:
                            Theme.of(context).appBarTheme.backgroundColor,
                        child: Text(
                          widget.myUser.name![0].toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontSize: height * .025),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                primary: true,
                reverse: true,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: Message()
                        .streamAdminGetMessages(userId: widget.myUser.id!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        QuerySnapshot<Map<String, dynamic>>? myStream =
                            snapshot.data;

                        messages.clear();
                        var docs = myStream!.docs;
                        for (var doc in docs) {
                          var data = doc.data();
                          messages.add(Message.fromJson(data));
                          // messages.sort((a,b)=>a.date!.compareTo(b.date! ));
                        }
                      }

                      return Column(
                        children: messages.map((e) {
                          if (e.sender == 'user') {
                            return userMessage(message: e, height: height);
                          } else {
                            return adminMessage(message: e, height: height);
                          }
                        }).toList(),
                      );
                    }),
              ),
            ),
            Material(
              elevation: 5,
              color: Colors.teal.shade50,
              child: Container(
                color: Colors.teal.shade50,
                height: height * .2,
                width: width,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: height * .15,
                        width: width * .8,
                        child: Form(
                          key: _myKey,
                          child: MyMessageTextField(
                            sFuntion: (s) {
                              setState(() {
                                message = s!;
                              });
                              return null;
                            },
                            vFuntion: (v) {
                              if (v!.isEmpty) {
                                return 'enter details';
                              }
                              return null;
                            },
                            controller: textController,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        bigImage(height: height, width: width),
                        InkWell(
                          onTap: () async {
                            var fire = Provider.of<FireProvider>(context,
                                listen: false);

                            if (_myKey.currentState!.validate()) {
                              // MyIndicator().loading(context);
                              _myKey.currentState!.save();
                              debugPrint('save done');

                              textController.clear();

                              if (picked != null) {
                                if (!await fire.uploadImage(
                                    imageFile: imageFile!, picked: picked!)) {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    MyFlush().showFlush(
                                        context: context,
                                        text: 'wrong try again');
                                  }
                                  return;
                                }
                              }

                              String id = Random().nextInt(100000).toString();
                              if (await Message().adminSendMessage(Message(
                                  text: message,
                                  sender: 'admin',
                                  imageUrl: fire.imageUrl,
                                  time: FieldValue.serverTimestamp(),
                                  userId: widget.myUser.id,
                                  id: id))) {
                                await fire.clearImages();
                                setState(() {
                                  picked = null;
                                  imageFile = null;
                                });

                                await Message().adminMakeChatSeen(
                                    userId: widget.myUser.id!);
                              } else {
                                if (context.mounted) {
                                  MyFlush().showFlush(
                                      context: context, text: 'try again');
                                }
                              }
                            } else {
                              return;
                            }
                          },
                          child: Material(
                            elevation: 3,
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            borderRadius: BorderRadius.circular(5),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.send,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final GlobalKey<FormState> _myKey = GlobalKey<FormState>();
  String? message;
  File? imageFile;
  XFile? picked;

  Widget bigImage({required double height, required double width}) {
    if (imageFile == null) {
      return InkWell(
          onTap: () async {
            var fire = Provider.of<FireProvider>(context, listen: false);

            await fire.addImage();
            setState(() {
              imageFile = fire.imageFile;
              picked = fire.picked;
            });
          },
          child: Material(
              elevation: 3,
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.attachment_outlined,
                    color: Theme.of(context).primaryColor),
              )));
    } else {
      return InkWell(
        onTap: () async {
          var fire = Provider.of<FireProvider>(context, listen: false);

          await fire.addImage();
          setState(() {
            imageFile = fire.imageFile;
            picked = fire.picked;
          });
        },
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          elevation: 10,
          child: Container(
            height: height * .08,
            width: width * .15,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: FileImage(
                      imageFile!,
                    ),
                    fit: BoxFit.contain)),
          ),
        ),
      );
    }
  }

  Widget adminMessage({required Message message, required double height}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 8, right: 50),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Material(
          elevation: 20,
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20),
            // bottomLeft:  Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: message.imageUrl == null
              ? Container(
                  padding: const EdgeInsets.all(12),
                  child: Text(message.text!,
                      style: const TextStyle(color: Colors.black)),
                )
              : Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ShowPhoto(url: message.imageUrl!),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          height: height * .1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                              //image: DecorationImage(image: CachedNetworkImageProvider(message.imageUrl!),fit: BoxFit.contain)
                              ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Text(message.text!,
                          style:
                              TextStyle(color: Theme.of(context).canvasColor)),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget userMessage({required Message message, required double height}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 50, right: 8),
      child: Container(
        alignment: Alignment.centerRight,
        child: Material(
          elevation: 5,
          color: Colors.teal.shade100,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(20),
            //topRight:   Radius.circular(20),
          ),
          child: message.imageUrl == null
              ? Container(
                  padding: const EdgeInsets.all(12),
                  child: Text(message.text!,
                      style: const TextStyle(color: Colors.black)),
                )
              : Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ShowPhoto(url: message.imageUrl!),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          height: height * .1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      message.imageUrl!),
                                  fit: BoxFit.contain)),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Text(message.text!,
                          style:
                              TextStyle(color: Theme.of(context).canvasColor)),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

class MyMessageTextField extends StatefulWidget {
  final String? Function(String?) vFuntion;
  final String? Function(String?) sFuntion;
  final TextEditingController controller;

  const MyMessageTextField(
      {Key? key,
      required this.vFuntion,
      required this.sFuntion,
      required this.controller})
      : super(key: key);

  @override
  State<MyMessageTextField> createState() => _MyMessageTextFieldState();
}

class _MyMessageTextFieldState extends State<MyMessageTextField> {
  double borderWidth = 0;

  Color borderColor = Colors.white.withOpacity(.0);

  Color fillColor = Colors.white.withOpacity(.0);

  double borderRadus = 5;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.height;
    }
    width = width;

    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 1),
    );
    return TextFormField(
      obscureText: false,
      textInputAction: TextInputAction.newline,

      keyboardType: TextInputType.multiline,
      enabled: true,
      // minLines: 14,
      maxLines: 15,
      // maxLength: 1000,

      validator: widget.vFuntion,
      onSaved: widget.sFuntion,
      textDirection: TextDirection.ltr,
      scrollController: ScrollController(),

      selectionControls: CupertinoTextSelectionControls(),
      controller: widget.controller,

      style: TextStyle(
        color: Colors.white,
        fontSize: height * .02,
        leadingDistribution: TextLeadingDistribution.even,
        textBaseline: TextBaseline.alphabetic,
      ),
      decoration: InputDecoration(
          // fillColor: Theme.of(context).primaryColor,
          // counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: height*.015),
          filled: true,
          isCollapsed: true,
          enabled: true,
          contentPadding: EdgeInsets.all(height * .025),
          focusColor: Colors.yellow,
          hoverColor: Colors.red,
          // labelText:'details' ,
          labelStyle: TextStyle(color: Colors.black, fontSize: height * .025),
          //  floatingLabelBehavior: FloatingLabelBehavior.always,

          enabledBorder: outlineInputBorder,
          disabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          errorBorder: outlineInputBorder,
          focusedErrorBorder: outlineInputBorder),
    );
  }
}
