import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban/constants/cart.dart';
import 'package:urban/constants/message_info.dart';
import 'package:urban/constants/request_worker.dart';

class NotifyProvider extends ChangeNotifier {
  int?
      currentCarts; // int get currentCarts => _currentCarts!;set currentCarts(int value) {_currentCarts = value;notifyListeners();}

  int?
      currentOrdered; //int get currentOrdered => _currentOrdered!;set currentOrdered(int value) {_currentOrdered = value;notifyListeners();}
  int?
      currentRequested; //int get currentRequested => _currentRequested!;set currentRequested(int value) {_currentRequested = value;notifyListeners();}

  int?
      oldCarts; //int get oldCarts => _oldCarts!;set oldCarts(int value) {_oldCarts = value;notifyListeners();}
  int?
      oldOrdered; // get oldOrdered => _oldOrdered!;set oldOrdered(int value) {_oldOrdered = value;notifyListeners();}
  int?
      oldRequested; //int get oldRequested => _oldRequested!;set oldRequested(int value) {_oldRequested = value;notifyListeners();}

  bool?
      cartsNoty; //bool get cartsNoty => _cartsNoty!;set cartsNoty(bool value) {_cartsNoty = value;notifyListeners();}
  bool?
      orderedNoty; //bool get orderedNoty => _orderedNoty!;set orderedNoty(bool value) {_orderedNoty = value;notifyListeners();}
  bool?
      requestedNoty; //bool get requestedNoty => _requestedNoty!;set requestedNoty(bool value) {_requestedNoty = value;notifyListeners();}

  NotifyProvider() {
    // cartsNoty=false;
    // orderedNoty=false;
    // requestedNoty=false;
  }

  thePrint() {
    debugPrint('=======oldCarts===$oldCarts');
    debugPrint('======oldOrdered===$oldOrdered');
    debugPrint('======oldRequested===$oldRequested');

    debugPrint(' currentCarts===========$currentCarts');
    debugPrint(' currentOrdered=========$currentOrdered');
    debugPrint(' currentRequested=======$currentRequested');
    debugPrint(' cartsNoty=======$cartsNoty');
    debugPrint(' orderedNoty=======$orderedNoty');
    debugPrint(' requestedNoty=======$requestedNoty');
  }

  checkNoty({required String myId}) async {
    if (oldCarts == null) {
      await getPreference();
    }

    await getData(myId: myId);
    getNoty();
    notifyListeners();
  }

  getNoty() {
    if (oldCarts == null) {
      oldCarts = 0;
      if (currentCarts! > oldCarts!) {
        cartsNoty = true;
      } else {
        cartsNoty = false;
      }
    } else {
      if (currentCarts! > oldCarts!) {
        cartsNoty = true;
      } else {
        cartsNoty = false;
      }
    }

    if (oldOrdered == null) {
      oldOrdered = 0;
      if (currentOrdered! > oldOrdered!) {
        orderedNoty = true;
      } else {
        orderedNoty = false;
      }
    } else {
      if (currentOrdered! > oldOrdered!) {
        orderedNoty = true;
      } else {
        orderedNoty = false;
      }
    }
    if (oldRequested == null) {
      oldRequested = 0;
      if (currentRequested! > oldRequested!) {
        requestedNoty = true;
      } else {
        requestedNoty = false;
      }
    } else {
      if (currentRequested! > oldRequested!) {
        requestedNoty = true;
      } else {
        requestedNoty = false;
      }
    }
    notifyListeners();
  }

  enterCarts() async {
    cartsNoty = false;
    await setPreference(key: 'oldCarts', value: currentCarts!);
    oldCarts = currentCarts;
    notifyListeners();
  }

  enterOrders() async {
    orderedNoty = false;
    await setPreference(key: 'oldOrdered', value: currentOrdered!);
    oldOrdered = currentOrdered;
    notifyListeners();
  }

  enterRequests() async {
    requestedNoty = false;
    await setPreference(key: 'oldRequested', value: currentRequested!);
    oldRequested = currentRequested;
    notifyListeners();
  }

  getData({required String myId}) async {
    var carts = await Cart().getMyCartsNoty(myUserId: myId);
    var requests = await RequestWorker().getMyRequests(myId: myId);
    await Message().userCheckIsSeen(myUserId: myId);

    currentCarts = carts.length;
    currentOrdered = carts.where((element) => element.status == ordered).length;
    currentRequested =
        requests.where((element) => element.status == requested).length;

    notifyListeners();
  }

  setPreference({required String key, required int value}) async {
    User? myUser1 = await FirebaseAuth.instance.authStateChanges().first;
    String id = myUser1!.uid;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('$id$key', value);
    notifyListeners();
  }

  getPreference() async {
    User? myUser1 = await FirebaseAuth.instance.authStateChanges().first;
    String id = myUser1!.uid;
    SharedPreferences pref = await SharedPreferences.getInstance();
    oldCarts = pref.getInt('${id}oldCarts');
    oldOrdered = pref.getInt('${id}oldOrdered');
    oldRequested = pref.getInt('${id}oldRequested');

    debugPrint('oldCarts=======$oldCarts');
    debugPrint('oldOrdered=====$oldOrdered');
    debugPrint('oldRequested===$oldRequested');
    notifyListeners();
  }
}
