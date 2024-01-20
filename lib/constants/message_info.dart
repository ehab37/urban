import 'package:cloud_firestore/cloud_firestore.dart';

import 'MyUser.dart';

class Message {
  final String? id;
  final String? userId;
  final String? text;
  final FieldValue? time;
  final String? imageUrl;
  final String? sender;

  Message(
      {this.userId, this.text, this.time, this.imageUrl, this.id, this.sender});

  factory Message.fromJson(Map<String, dynamic>? map) {
    return Message(
      id: map![messageId],
      userId: map[messageUserId],
      // time: map[messageTime],
      imageUrl: map[messageImageUrl],
      text: map[messageText],
      sender: map[messageSender],
    );
  }

  Map<String, dynamic> toMap(Message message) {
    return {
      messageId: message.id,
      messageUserId: message.userId,
      messageTime: message.time,
      messageImageUrl: message.imageUrl,
      messageSender: message.sender,
      messageText: message.text,
    };
  }

  Future<bool> userSendMessage(Message message) async {
    Map<String, dynamic> map = Message().toMap(message);
    try {
      await FirebaseFirestore.instance
          .collection(users)
          .doc(message.userId)
          .collection(chat)
          .doc(admin)
          .collection(messages)
          .doc(message.id)
          .set(map); //user save

      await FirebaseFirestore.instance
          .collection(users)
          .doc(message.userId)
          .collection(chat)
          .doc(admin)
          .set({
        'id': message.userId,
        messageTime: FieldValue.serverTimestamp(),
        isSeen: true
      }); //user save

      await FirebaseFirestore.instance
          .collection(admins)
          .doc(messages)
          .collection(chat)
          .doc(message.userId)
          .collection(messages)
          .doc(message.id)
          .set(map); //admin save

      await FirebaseFirestore.instance
          .collection(admins)
          .doc(messages)
          .collection(chat)
          .doc(message.userId)
          .set({
        'id': message.userId,
        messageTime: FieldValue.serverTimestamp(),
        isSeen: false
      }); //admin save

      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> adminSendMessage(Message message) async {
    Map<String, dynamic> map = Message().toMap(message);
    try {
      await FirebaseFirestore.instance
          .collection('admins')
          .doc('messages')
          .collection('chat')
          .doc(message.userId)
          .collection('messages')
          .doc(message.id)
          .set(map); //admin save

      await FirebaseFirestore.instance
          .collection('admins')
          .doc('messages')
          .collection('chat')
          .doc(message.userId)
          .set({
        'id': message.userId,
        'time': FieldValue.serverTimestamp(),
        'isSeen': true
      }); //admin save

      await FirebaseFirestore.instance
          .collection('users')
          .doc(message.userId)
          .collection('chat')
          .doc('admin')
          .collection('messages')
          .doc(message.id)
          .set(map); //user save

      await FirebaseFirestore.instance
          .collection('users')
          .doc(message.userId)
          .collection('chat')
          .doc('admin')
          .set({
        'id': message.userId,
        'time': FieldValue.serverTimestamp(),
        'isSeen': false
      }); //user save

      return true;
    } on Exception {
      return false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAdminGetMessages(
      {required String userId}) {
    Stream<QuerySnapshot<Map<String, dynamic>>> myStream = FirebaseFirestore
        .instance
        .collection(admins)
        .doc(messages)
        .collection(chat)
        .doc(userId)
        .collection(messages)
        .orderBy(messageTime)
        .snapshots();
    return myStream;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamUserGetMessages(
      {required String myUserId}) {
    Stream<QuerySnapshot<Map<String, dynamic>>> myStream = FirebaseFirestore
        .instance
        .collection(users)
        .doc(myUserId)
        .collection(chat)
        .doc(admin)
        .collection(messages)
        .orderBy(messageTime)
        .snapshots();

    return myStream;
  }

  Future<List<MyUser>> getAdminsChatList() async {
    // List<String>usersIdsList=[];
    List<MyUser> myUsersList = [];

    myUsersList.clear();

    var fire = await FirebaseFirestore.instance
        .collection(admins)
        .doc(messages)
        .collection(chat)
        .orderBy(messageTime)
        .get();
    var docs = fire.docs;
    for (var doc in docs) {
      Map<String, dynamic> data = doc.data();

      MyUser user1 = await MyUser().getUserInfo(userId: data['id']);
      myUsersList.add(user1);
    }

    return myUsersList;
  }

  Future<bool> adminCheckIsSeen({
    required String userId,
  }) async {
    var fire = await FirebaseFirestore.instance
        .collection(admins)
        .doc(messages)
        .collection(chat)
        .doc(userId)
        .get();
    var chatExist = fire.exists;
    if (chatExist) {
      Map<String, dynamic>? data = fire.data();
      bool isSeen1 = data![isSeen];
      if (isSeen1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  adminMakeChatSeen({required String userId}) async {
    var fire = await FirebaseFirestore.instance
        .collection(admins)
        .doc(messages)
        .collection(chat)
        .doc(userId)
        .get();
    bool chatExist = fire.exists;

    if (chatExist) {
      Map<String, dynamic>? data = fire.data();
      var time = data![messageTime];

      await FirebaseFirestore.instance
          .collection(admins)
          .doc(messages)
          .collection(chat)
          .doc(userId)
          .update({'id': userId, messageTime: time, isSeen: true}); //admin save
    }
  }

  userMakeChatSeen({required String myUserId}) async {
    var fire = await FirebaseFirestore.instance
        .collection(users)
        .doc(myUserId)
        .collection(chat)
        .doc(admin)
        .get();
    bool chatExist = fire.exists;
    if (chatExist) {
      Map<String, dynamic>? data = fire.data();
      var time = data![messageTime];

      await FirebaseFirestore.instance
          .collection(users)
          .doc(myUserId)
          .collection(chat)
          .doc(admin)
          .update(
              {'id': myUserId, messageTime: time, isSeen: true}); //user save
    }
  }

  Future<bool> userCheckIsSeen({required String myUserId}) async {
    var fire = await FirebaseFirestore.instance
        .collection(users)
        .doc(myUserId)
        .collection(chat)
        .doc(admin)
        .get();

    var chatExist = fire.exists;
    if (chatExist) {
      Map<String, dynamic>? data = fire.data();
      bool isSeen1 = data![isSeen];
      if (isSeen1) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}

const String messageId = 'id';
const String messageUserId = 'userId';
const String messageTime = 'time';
const String messageImageUrl = 'imageUrl';
const String messageSender = 'sender';
const String messageText = 'text';
const String messages = 'messages';
const String admin = 'admin';
const String admins = 'admins';
const String chat = 'chat';
const String users = 'users';
const String isSeen = 'isSeen';
