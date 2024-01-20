import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urban/constants/data/main_info.dart';
import 'package:urban/constants/equipment.dart';
import 'package:urban/constants/product.dart';

class Cart {
  final String? uid;
  final String? id;

  final String? status;
  final double? codePrice;
  final double? quantity;
  final Map<String, dynamic>? product;
  final Map<String, dynamic>? equip;
  final String? colorCode;
  final String? date;
  final int? days;
  final String? cityId;

  final double? totalPrice;
  final bool? isAvailable;
  final String? payment;
  final String? phone;
  final bool? isAccepted;

  Cart({
    this.uid,
    this.id,
    this.product,
    this.equip,
    this.codePrice,
    this.status,
    this.colorCode,
    this.quantity,
    this.cityId,
    this.days,
    this.date,
    this.totalPrice,
    this.isAvailable,
    this.payment,
    this.phone,
    this.isAccepted,
  });

  factory Cart.i(Map<String, dynamic>? map) {
    return Cart(
      uid: map![userId],
      id: map[cartId],
      status: map[productStatus],
      product: map[cartProduct],
      equip: map[cartEquip],
      codePrice: map[codePricee],
      colorCode: map[productColorCode],
      quantity: map[cartQuantity],
      cityId: map[cartCityId],
      days: map[cartDays],
      date: map[cartDate],
      totalPrice: map[cartTotalPrice],
      isAvailable: map[cartIsAvailable],
      payment: map[cartPayment],
      phone: map[cartPhone],
      isAccepted: map[cartIsAccepted],
    );
  }

  Map<String, dynamic> getMap(Cart cart) {
    return {
      userId: cart.uid,
      cartId: cart.id,
      cartStatus: cart.status,
      cartProduct: cart.product,
      codePricee: cart.codePrice,
      productColorCode: cart.colorCode,
      cartQuantity: cart.quantity,
      cartEquip: cart.equip,
      cartCityId: cart.cityId,
      cartDays: cart.days,
      cartDate: cart.date,
      cartTotalPrice: cart.totalPrice,
      cartIsAvailable: cart.isAvailable,
      cartPayment: cart.payment,
      cartIsAccepted: cart.isAccepted,
    };
  }

  addCart({required Cart cart}) async {
    CollectionReference fire = FirebaseFirestore.instance.collection(carts);

    await fire.doc(cart.id).set(Cart().getMap(cart));

    debugPrint('cart added ');
  }

  Future<List<Cart>> getMyCarts({required String myUserId}) async {
    QuerySnapshot<Map<String, dynamic>> fire = await FirebaseFirestore.instance
        .collection(carts)
        .where(userId, isEqualTo: myUserId)
        .get();
    var docs = fire.docs;
    List<Cart> myCarts = [];

    myCarts.clear();

    for (var doc in docs) {
      Map<String, dynamic> data = doc.data();
      myCarts.add(Cart.i(data));
    }

    await checkingCarts(myCarts);

    QuerySnapshot<Map<String, dynamic>> fire2 = await FirebaseFirestore.instance
        .collection(carts)
        .where(userId, isEqualTo: myUserId)
        .get();
    var docs2 = fire2.docs;
    List<Cart> myCarts2 = [];

    myCarts2.clear();

    for (var doc2 in docs2) {
      Map<String, dynamic> data2 = doc2.data();
      myCarts2.add(Cart.i(data2));
    }

    return myCarts2;
  }

  Future<List<Cart>> getAllCarts() async {
    QuerySnapshot<Map<String, dynamic>> fire =
        await FirebaseFirestore.instance.collection(carts).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = fire.docs;
    List<Cart> myCarts = [];

    myCarts.clear();

    for (var doc in docs) {
      Map<String, dynamic> data = doc.data();
      myCarts.add(Cart.i(data));
    }

    await checkingCarts(myCarts);

    QuerySnapshot<Map<String, dynamic>> fire2 =
        await FirebaseFirestore.instance.collection(carts).get();
    var docs2 = fire2.docs;
    List<Cart> myCarts2 = [];

    myCarts2.clear();

    for (var doc2 in docs2) {
      Map<String, dynamic> data2 = doc2.data();
      myCarts2.add(Cart.i(data2));
    }

    return myCarts2;
  }

  checkingCarts(List<Cart> myCarts) async {
    for (var cart in myCarts) {
      if (cart.product == null) {
        Equip equip = Equip.fromJson(cart.equip);
        DocumentSnapshot<Map<String, dynamic>> fire = await FirebaseFirestore
            .instance
            .collection(equipments)
            .doc(equip.id)
            .get();
        Map<String, dynamic>? data = fire.data();
        if (data == null) {
          await FirebaseFirestore.instance
              .collection(carts)
              .doc(cart.id)
              .update({cartIsAvailable: false});
        }
      } else {
        Product product = Product.i(cart.product);
        DocumentSnapshot<Map<String, dynamic>> fire = await FirebaseFirestore
            .instance
            .collection(materials)
            .doc(product.productId)
            .get();
        Map<String, dynamic>? data = fire.data();
        if (data == null) {
          await FirebaseFirestore.instance
              .collection(carts)
              .doc(cart.id)
              .update({cartIsAvailable: false});
        }
      }
    }
  }

  deleteCart({required String cartId}) async {
    await FirebaseFirestore.instance.collection(carts).doc(cartId).delete();
    debugPrint('cart deleted');
  }

  editCart({required String cartId, required Map<String, dynamic> map}) async {
    await FirebaseFirestore.instance.collection(carts).doc(cartId).update(map);
  }

  Future<List<Cart>> getAllWaitingCarts() async {
    QuerySnapshot<Map<String, dynamic>> fire = await FirebaseFirestore.instance
        .collection(carts)
        .where(cartStatus, isEqualTo: waiting)
        .where(cartIsAvailable, isEqualTo: true)
        .get();
    var docs = fire.docs;
    List<Cart> myWaitingCarts = [];

    myWaitingCarts.clear();

    for (var doc in docs) {
      Map<String, dynamic> data = doc.data();

      myWaitingCarts.add(Cart.i(data));
    }
    return myWaitingCarts;
  }

  Future<List<Cart>> getAllCartsNoty() async {
    QuerySnapshot<Map<String, dynamic>> fire =
        await FirebaseFirestore.instance.collection(carts).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = fire.docs;
    List<Cart> myCarts = [];

    myCarts.clear();

    for (var doc in docs) {
      Map<String, dynamic> data = doc.data();
      myCarts.add(Cart.i(data));
    }

    return myCarts;
  }

  Future<List<Cart>> getMyCartsNoty({required String myUserId}) async {
    QuerySnapshot<Map<String, dynamic>> fire = await FirebaseFirestore.instance
        .collection(carts)
        .where(userId, isEqualTo: myUserId)
        .get();
    var docs = fire.docs;
    List<Cart> myCarts = [];

    myCarts.clear();

    for (var doc in docs) {
      Map<String, dynamic> data = doc.data();
      myCarts.add(Cart.i(data));
    }
    return myCarts;
  }
}

const String cartProduct = 'Product';
const String cartEquip = 'Equip';
const String codePricee = 'codePrice';
const String cartStatus = 'status';
const String userId = 'userId';
const String cartId = 'cartId';
const String carts = 'carts';
const String cart = 'cart';
const String cartQuantity = 'quantity';
const String cartCityId = 'cityId';
const String cartDate = 'date';
const String cartDays = 'days';
const String cartTotalPrice = 'totalPrice';
const String cartIsAvailable = 'isAvailable';
const String cartPayment = 'cartPayment';
const String cartPhone = 'cartPhone';
const String cartIsAccepted = 'isAccepted';
//status
const String selling = 'selling';
const String waiting = 'waiting';
const String available = 'available';
const String notAvailable = 'not_Available';
const String ordered = 'ordered';
const String ordering = 'ordering';

//payment method
const String visa = 'visa';
const String cash = 'cash';

//admin
