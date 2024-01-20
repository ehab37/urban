// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'data/main_info.dart';

class Product {
  final String? imageUrl;
  final String? photoLoc;
  final double? price;
  final String? details;
  final String? productId;
  final String? category;
  final String? section;
  final String? company;
  final String? kind;
  final String? name;

  Product({
    this.imageUrl,
    this.photoLoc,
    this.details,
    this.price,
    this.productId,
    this.company,
    this.category,
    this.section,
    this.kind,
    this.name,
  });

  factory Product.i(Map<String, dynamic>? map) {
    return Product(
      imageUrl: map![productImageUrl],
      photoLoc: map[productPhotoLoc],
      details: map[productDetails],
      price: map[productPrice],
      productId: map[productIde],
      category: map[productCategory],
      company: map[productCompany],
      section: map[productSection],
      kind: map[productKind],
      name: map[productName],
    );
  }

  Map<String, dynamic> getMap(Product product) {
    return {
      productIde: product.productId,
      productPrice: product.price,
      productDetails: product.details,
      productImageUrl: product.imageUrl,
      productPhotoLoc: product.photoLoc,
      productCategory: product.category,
      productCompany: product.company,
      productName: product.name,
      productSection: product.section,
      productKind: product.kind
    };
  }

  addProduct(Product product) async {
    CollectionReference fire = FirebaseFirestore.instance.collection(materials);

    try {
      await fire

          /*  .doc(materials)
          .collection(product.category!).doc(product.category)
          .collection(product.section!).doc(product.section)
          .collection(product.company!).doc(product.company)
          .collection(product.kind!).doc(product.kind)
          .collection('products')
          */
          .doc(product.productId)
          .set(Product().getMap(product));

      debugPrint('product added ');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Product> getProductInfo({required Product product}) async {
    DocumentSnapshot<Map<String, dynamic>> fire = await FirebaseFirestore
        .instance
        .collection(materials)
        .doc(product.category)
        .collection(product.section!)
        .doc(product.section)
        .collection(product.company!)
        .doc(product.company)
        .collection('products')
        .doc(product.productId)
        .get();

    Map<String, dynamic>? data = fire.data();

    return Product.i(data);
  }

  Future<List<Product>> getProducts(
      {required String category,
      required String company,
      required String section,
      required String kind}) async {
    var fire = await FirebaseFirestore.instance
        .collection(materials)
        /* .doc(materials)
        .collection(category).doc(category)
        .collection(section).doc(section)
        .collection(company).doc(company)
        .collection(kind).doc(kind)
        .collection('products').get();
*/

        .where(productCategory, isEqualTo: category)
        .where(productSection, isEqualTo: section)
        .where(productKind, isEqualTo: kind)
        .where(productCompany, isEqualTo: company)
        .get();

    var docs = fire.docs;
    List<Product> myProducts = [];

    myProducts.clear();

    for (var doc in docs) {
      Map<String, dynamic> data = doc.data();

      myProducts.add(Product.i(data));
    }

    debugPrint('my products got');

    return myProducts;
  }

  Future<void> editProduct(
      {required String productId,
      required String adminId,
      required String key,
      dynamic newValue}) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .update({key: newValue});
    debugPrint('all products updated');

    await FirebaseFirestore.instance
        .collection('admins')
        .doc(adminId)
        .collection('products')
        .doc(productId)
        .update({key: newValue});

    debugPrint('admin products updated');
  }

/*  Future<List<Product>>getAllProducts()async{
    List<Product>products=[];
    QuerySnapshot<Map<String, dynamic>> fire =  await FirebaseFirestore.instance.collection('products').get();
    var docs=fire.docs;
    products.clear();
    for(var doc in docs){
      Map<String, dynamic> data=doc.data();

      products.add(Product.i(data)


      );
    }
    debugPrint('all products got');

    return products;



  }*/

  removeProduct({required Product product}) async {
    await FirebaseFirestore.instance
        .collection(materials)
        .doc(product.productId)
        .delete();

    await FirebaseStorage.instance.ref().child(product.photoLoc!).delete();

    debugPrint('removed');
  }

  Future<bool> addProductToShoppingCart(
      {required String uid, required Product product}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('shoppingCart')
          .doc(product.productId)
          .set({
        productIde: product.productId,
        //  productAdminId:product.userId,
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<List<Product>> getShoppingProducts({required String uid}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('shoppingCart')
        .get();
    // var docs = fire.docs;
    List<Product> products = [];
    // for (var doc in docs) {
    //   // products.add( await Product().getProductInfo(productId: doc.data()['productId']));
    // }
    return products;
  }

  Future<bool> deleteShoppingCartProduct(
      {required String productId, required String uid}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('shoppingCart')
          .doc(productId)
          .delete();

      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
}

const String productImageUrl = 'imageUrl';
const String productPhotoLoc = 'photoLoc';
const String productDetails = 'details';
const String productPrice = 'price';
const String productIde = 'productId';
const String productCategory = 'category';
const String productCompany = 'company';
const String productName = 'name';
const String productStatus = 'status';
const String productColorCode = 'colorCode';
const String productColorCodePrice = 'colorCodePrice';
const String productSection = 'section';
const String productKind = 'kind';
