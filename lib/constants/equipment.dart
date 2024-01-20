import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Equip {
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? imageLoc;
  final double? pricePerDay;

  final String? kind;
  final String? company;

  final String? capacity;
  final String? brand;
  final String? pressure;
  final String? output;
  final String? power;
  final String? lengthOfBoom;
  final String? numberOfBoom;
  final String? engine;
  final String? load;
  final String? weight;
  final String? extendedBoom;

  final String? reach;

  Equip({
    this.id,
    this.name,
    this.imageUrl,
    this.imageLoc,
    this.pricePerDay,
    this.kind,
    this.company,
    this.capacity,
    this.brand,
    this.pressure,
    this.output,
    this.power,
    this.lengthOfBoom,
    this.numberOfBoom,
    this.engine,
    this.load,
    this.weight,
    this.extendedBoom,
    this.reach,
  });

  factory Equip.fromJson(Map<String, dynamic>? map) {
    return Equip(
      id: map![equipId],
      name: map[equipName],
      imageUrl: map[equipUrl],
      imageLoc: map[equipLoc],
      pricePerDay: map[equipPricePerDay],
      kind: map[equipKind],
      company: map[equipCompany],
      capacity: map[equipCapacity],
      brand: map[equipBrand],
      pressure: map[equipPressure],
      output: map[equipOutput],
      power: map[equipPower],
      lengthOfBoom: map[equipLengthOfBoom],
      numberOfBoom: map[equipNumberOfBoom],
      engine: map[equipEngine],
      load: map[equipLoad],
      weight: map[equipWeight],
      extendedBoom: map[equipExtendedBoom],
      reach: map[equipReach],
    );
  }

  Map<String, dynamic> getMap(Equip equip) {
    return {
      equipId: equip.id,
      equipName: equip.name,
      equipUrl: equip.imageUrl,
      equipLoc: equip.imageLoc,
      equipPricePerDay: equip.pricePerDay,
      equipKind: equip.kind,
      equipCompany: equip.company,
      equipCapacity: equip.capacity,
      equipBrand: equip.brand,
      equipPressure: equip.pressure,
      equipOutput: equip.output,
      equipPower: equip.power,
      equipLengthOfBoom: equip.lengthOfBoom,
      equipNumberOfBoom: equip.numberOfBoom,
      equipEngine: equip.engine,
      equipLoad: equip.load,
      equipWeight: equip.weight,
      equipExtendedBoom: equip.extendedBoom,
      equipReach: equip.reach,
    };
  }

  addEquip(Equip equip) async {
    CollectionReference fire =
        FirebaseFirestore.instance.collection(equipments);

    try {
      await fire

          /*  .doc(equipments)
          .collection(equip.kind!).doc(equip.kind)
          .collection(equip.company!).doc(equip.company)
          .collection(equipments)
          */
          .doc(equip.id)
          .set(Equip().getMap(equip));

      debugPrint('equip  added ');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<Equip>> getEquips(
      {required String company, required String kind}) async {
    var fire = await FirebaseFirestore.instance
        .collection(equipments)
        .where(equipKind, isEqualTo: kind)
        .where(equipCompany, isEqualTo: company)

        // doc(equipments).collection(kind).doc(kind)
        //     .collection(company).doc(company)
        //     .collection(equipments)

        .get();

    var docs = fire.docs;
    List<Equip> myEquips = [];

    myEquips.clear();

    for (var doc in docs) {
      Map<String, dynamic> data = doc.data();

      myEquips.add(Equip.fromJson(data));
    }

    debugPrint('my Equips got');

    return myEquips;
  }

  removeEquip({required Equip equip}) async {
    CollectionReference fire =
        FirebaseFirestore.instance.collection(equipments);
    await fire.doc(equip.id).delete();
  }
}

const String equipments = 'Equipments';

const String equipId = 'id';
const String equipName = 'name';

const String equipUrl = 'imageUrl';
const String equipLoc = 'imageLoc';
const String equipPricePerDay = 'price per day';

const String equipKind = 'kind';
const String equipCompany = 'company';

const String equipCapacity = 'capacity';
const String equipBrand = 'brand';
const String equipPressure = 'pressure';
const String equipOutput = 'output';
const String equipPower = 'power';
const String equipLengthOfBoom = 'length Of Boom';
const String equipNumberOfBoom = 'number Of Boom';
const String equipEngine = 'engine';
const String equipLoad = 'load';
const String equipWeight = 'weight';
const String equipExtendedBoom = 'extended Boom';
const String equipReach = 'reach';

const String mixerTruck = 'Mixer Truck';
const String trailerConcretePump = 'Trailer Concrete Pump';
const String mobilePlacingBoom = 'Mobile Placing Boom';
const String loader = 'Loader';
const String bulldozer = 'Bulldozer';
const String excavator = 'excavator';
const String mobileCrane = 'Mobile Crane';
const String truckPump = 'Truck Pump';

const String elRowad = 'ElRowad';
const String elArab = 'ElArab';

const List<String> equipmentKinds = [
  mixerTruck,
  trailerConcretePump,
  mobilePlacingBoom,
  loader,
  bulldozer,
  excavator,
  mobileCrane,
  truckPump
];
const List<String> equipmentsCompanies = [elRowad, elArab];
