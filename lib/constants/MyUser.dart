// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? photo;
  final String? photoLoc;
  final String? cityId;

  MyUser({
    this.phone,
    this.email,
    this.name,
    this.photo,
    this.photoLoc,
    this.id,
    this.cityId,
  });

  factory MyUser.i(Map<String, dynamic> map) {
    return MyUser(
      name: map[userName],
      phone: map[userPhone],
      email: map[userEmail],
      photo: map[userPhoto],
      photoLoc: map[userPhotoLoc],
      id: map[userId],
      cityId: map[userCityId],
    );
  }

  Map<String, dynamic> getMap(MyUser myUser) {
    return {
      userName: myUser.name,
      userPhone: myUser.phone,
      userPhoto: myUser.photo,
      userPhotoLoc: myUser.photoLoc,
      userEmail: myUser.email,
      userId: myUser.id,
      userCityId: myUser.cityId,
    };
  }

  Future<bool> editUser(
      {required String userId, required String key, dynamic newValue}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('info')
          .doc(userId)
          .update({key: newValue});

      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> addUser(MyUser myUser) async {
    try {
      Map<String, dynamic> map = getMap(myUser);

      var fire = FirebaseFirestore.instance;
      await fire
          .collection('users')
          .doc(myUser.id)
          .collection('info')
          .doc(myUser.id)
          .set(map);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<MyUser> getUserInfo({required String userId}) async {
    DocumentSnapshot<Map<String, dynamic>> fire = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(userId)
        .collection('info')
        .doc(userId)
        .get();
    var data = fire.data();
    return MyUser.i(data!);
  }
}

const String userName = 'userName';
const String userPhone = 'userPhone';
const String userPhoto = 'userPhoto';
const String userPhotoLoc = 'userPhotoLoc';
const String userEmail = 'userEmail';
const String userId = 'userId';
const String userCityId = 'userCityId';
