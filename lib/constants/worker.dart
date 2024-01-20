import 'package:cloud_firestore/cloud_firestore.dart';

class Worker {
  final String? id;
  final String? name;
  final String? phone;
  final String? cityId;
  final String? category;
  final String? status;
  final String? imageUrl;
  final String? imageLoc;

  Worker(
      {this.id,
      this.name,
      this.phone,
      this.cityId,
      this.category,
      this.status,
      this.imageUrl,
      this.imageLoc});

  factory Worker.fromJson(Map<String, dynamic> map) {
    return Worker(
        id: map[workerId],
        name: map[workerName],
        phone: map[workerPhone],
        cityId: map[workerCityId],
        category: map[workerCategory],
        status: map[workerStatus],
        imageUrl: map[workerImageUrl],
        imageLoc: map[workerImageLoc]);
  }

  Map<String, dynamic> toMap(Worker worker) {
    return {
      workerId: worker.id,
      workerName: worker.name,
      workerPhone: worker.phone,
      workerCityId: worker.cityId,
      workerCategory: worker.category,
      workerStatus: worker.status,
      workerImageUrl: worker.imageUrl,
      workerImageLoc: worker.imageLoc,
    };
  }

  addWorker({required Worker worker}) async {
    CollectionReference fire = FirebaseFirestore.instance.collection(workers);

    await fire.doc(worker.id).set(Worker().toMap(worker));
  }

  Future<List<Worker>> getWorkers(
      {required String category, required String cityId}) async {
    var fire = await FirebaseFirestore.instance
        .collection(workers)
        .where(workerCategory, isEqualTo: category)
        .where(workerCityId, isEqualTo: cityId)
        .get();

    var docs = fire.docs;
    List<Worker> myWorkers = [];

    myWorkers.clear();
    for (var doc in docs) {
      Map<String, dynamic> data = doc.data();
      myWorkers.add(Worker.fromJson(data));
    }
    return myWorkers;
  }

  Future<List<Worker>> getAllWorkers() async {
    var fire = await FirebaseFirestore.instance.collection(workers).get();

    var docs = fire.docs;
    List<Worker> allWorkers = [];

    allWorkers.clear();
    for (var doc in docs) {
      Map<String, dynamic> data = doc.data();
      allWorkers.add(Worker.fromJson(data));
    }
    return allWorkers;
  }

  removeWorker({required String workerId}) async {
    await FirebaseFirestore.instance.collection(workers).doc(workerId).delete();
  }
}

const String workers = 'workers';

const String workerId = 'id';
const String workerName = 'name';
const String workerPhone = 'phone';
const String workerCityId = 'cityId';
const String workerCategory = 'category';
const String workerStatus = 'status';
const String workerImageUrl = 'imageUrl';
const String workerImageLoc = 'imageLoc';

const String carpenter = 'carpenter';
const String blacksmith = 'blacksmith';
const String plumber = 'plumber';
const String electrician = 'electrician';
const String tiler = 'tiler';
const String plasterer = 'plasterer';
const String conditioningTechnician = 'conditioning technician';
const String homeApplianceTechnician = 'home appliance technician';
const String satelliteTechnician = 'satellite technician';

List<String> workersCategories = [
  carpenter,
  blacksmith,
  plumber,
  electrician,
  tiler,
  plasterer,
  conditioningTechnician,
  homeApplianceTechnician,
  satelliteTechnician,
];
