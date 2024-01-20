import 'package:cloud_firestore/cloud_firestore.dart';

class RequestWorker {
  final String? id;
  final String? userId;
  final Map<String, dynamic>? worker;
  final String? phone;
  final String? cityId;
  final String? category;
  final String? imageUrl;
  final String? imageLoc;
  final String? details;
  final String? date;
  final String? time;
  final String? status;

  RequestWorker(
      {this.id,
      this.userId,
      this.worker,
      this.phone,
      this.cityId,
      this.category,
      this.imageUrl,
      this.imageLoc,
      this.details,
      this.date,
      this.time,
      this.status});

  factory RequestWorker.fromJson(Map<String, dynamic> map) {
    return RequestWorker(
      id: map[requestWorkerId],
      userId: map[requestWorkerUserId],
      worker: map[requestWorkerWorker],
      phone: map[requestWorkerPhone],
      cityId: map[requestWorkerCityId],
      category: map[requestWorkerCategory],
      imageUrl: map[requestWorkerImageUrl],
      imageLoc: map[requestWorkerImageLoc],
      details: map[requestWorkerDetails],
      date: map[requestWorkerDate],
      time: map[requestWorkerTime],
      status: map[requestWorkerStatus],
    );
  }

  Map<String, dynamic> toMap(RequestWorker requestWorker) {
    return {
      requestWorkerId: requestWorker.id,
      requestWorkerUserId: requestWorker.userId,
      requestWorkerWorker: requestWorker.worker,
      requestWorkerPhone: requestWorker.phone,
      requestWorkerCityId: requestWorker.cityId,
      requestWorkerCategory: requestWorker.category,
      requestWorkerImageUrl: requestWorker.imageUrl,
      requestWorkerImageLoc: requestWorker.imageLoc,
      requestWorkerDetails: requestWorker.details,
      requestWorkerDate: requestWorker.date,
      requestWorkerTime: requestWorker.time,
      requestWorkerStatus: requestWorker.status,
    };
  }

  addRequest({required RequestWorker requestWorker}) async {
    CollectionReference fire = FirebaseFirestore.instance.collection(requests);
    fire.doc(requestWorker.id).set(RequestWorker().toMap(requestWorker));
  }

  Future<List<RequestWorker>> getAllRequests() async {
    var fire = await FirebaseFirestore.instance.collection(requests).get();
    List<RequestWorker> allRequests1 = [];
    allRequests1.clear();
    var docs = fire.docs;
    for (var doc in docs) {
      Map<String, dynamic> data = doc.data();
      allRequests1.add(RequestWorker.fromJson(data));
    }

    return allRequests1;
  }

  Future<List<RequestWorker>> getMyRequests({required String myId}) async {
    var fire = await FirebaseFirestore.instance
        .collection(requests)
        .where(requestWorkerUserId, isEqualTo: myId)
        .get();
    List<RequestWorker> myRequests1 = [];
    myRequests1.clear();
    var docs = fire.docs;
    for (var doc in docs) {
      Map<String, dynamic> data = doc.data();
      myRequests1.add(RequestWorker.fromJson(data));
    }
    return myRequests1;
  }

  editRequest({required String id, required Map<String, dynamic> map}) async {
    await FirebaseFirestore.instance.collection(requests).doc(id).update(map);
  }

  removeRequest({required String requestId}) async {
    await FirebaseFirestore.instance
        .collection(requests)
        .doc(requestId)
        .delete();
  }
}

const String requestWorkerId = 'id';
const String requestWorkerUserId = 'userId';
const String requestWorkerWorker = 'worker';
const String requestWorkerPhone = 'phone';
const String requestWorkerCityId = 'cityId';
const String requestWorkerCategory = 'category';
const String requestWorkerImageUrl = 'imageUrl';
const String requestWorkerImageLoc = 'imageLoc';
const String requestWorkerDetails = 'details';
const String requestWorkerDate = 'date';
const String requestWorkerTime = 'time';
const String requestWorkerStatus = 'status';

const String requests = 'requests';
const String requesting = 'requesting';
const String requested = 'requested';
