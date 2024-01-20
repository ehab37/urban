import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../components/app_local.dart';

class MyFlush {
  showFlush({required BuildContext context, required String text}) async {
    await Flushbar(
      isDismissible: true,
      backgroundColor: Colors.white,
      //  onTap: (){},
      // title: 'title',
      duration: const Duration(seconds: 1),
      borderRadius: BorderRadius.circular(30),
      //borderColor: Colors.black,
      animationDuration: const Duration(seconds: 1),
      icon: const Icon(
        Icons.error,
        color: Colors.red,
      ),
      barBlur: 100,

      shouldIconPulse: true,
      padding: const EdgeInsets.only(left: 50, bottom: 10, top: 10),
      margin: const EdgeInsets.only(left: 50, bottom: 10, top: 10, right: 50),

      flushbarPosition: FlushbarPosition.BOTTOM,

      messageText: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
    ).show(context);
  }

  showError({required BuildContext context, required String text}) async {
    await Flushbar(
      isDismissible: true,
      backgroundColor: Colors.white,
      //  onTap: (){},
      // title: 'title',
      duration: const Duration(seconds: 1),
      borderRadius: BorderRadius.circular(30),
      //borderColor: Colors.black,
      animationDuration: const Duration(seconds: 1),
      icon: const Icon(
        Icons.error,
        color: Colors.red,
      ),
      barBlur: 100,

      shouldIconPulse: true,
      padding: const EdgeInsets.only(left: 50, bottom: 10, top: 10),
      margin: const EdgeInsets.only(left: 50, bottom: 10, top: 10, right: 50),

      flushbarPosition: FlushbarPosition.BOTTOM,

      messageText: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
    ).show(context);
  }

  showUploadingFlush({required BuildContext context}) async {
    await Flushbar(
      isDismissible: true,
      backgroundColor: Colors.grey,
      //  onTap: (){},
      // title: 'title',
      duration: const Duration(seconds: 5),
      borderRadius: BorderRadius.circular(30),
      //borderColor: Colors.black,
      animationDuration: const Duration(seconds: 1),
      icon: const Icon(
        Icons.arrow_circle_up_sharp,
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 50, bottom: 10, top: 10),
      margin: const EdgeInsets.only(left: 50, bottom: 10, top: 10, right: 50),

      barBlur: 20,

      shouldIconPulse: true,
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.black,
      flushbarPosition: FlushbarPosition.BOTTOM,
      routeBlur: 50,
      messageText: const Text(
        ' ...... جارِ تحميل المنتج',
        style: TextStyle(color: Colors.white), //textAlign: TextAlign.center,
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
    ).show(context);
  }

  showUploadingDoneFlush({required BuildContext context}) async {
    await Flushbar(
      isDismissible: true,
      backgroundColor: Colors.white,
      //  onTap: (){},
      // title: 'title',
      duration: const Duration(seconds: 1),
      borderRadius: BorderRadius.circular(30),
      //borderColor: Colors.black,
      animationDuration: const Duration(seconds: 1),
      icon: const Icon(
        Icons.cloud_done_outlined,
        color: Colors.green,
        size: 30,
      ),
      padding: const EdgeInsets.only(left: 50, bottom: 10, top: 10),
      margin: const EdgeInsets.only(left: 50, bottom: 10, top: 10, right: 50),

      barBlur: 20,

      shouldIconPulse: true,
      showProgressIndicator: false,
      // progressIndicatorBackgroundColor: Colors.black,
      flushbarPosition: FlushbarPosition.BOTTOM,
      routeBlur: 50,
      messageText: Text(
        '${getLang(context, "upload done")}',
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold), //textAlign: TextAlign.center,
      ),
      // titleText:Text('تم تحميل المنتج بنجاح',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,) ,
      flushbarStyle: FlushbarStyle.FLOATING,
    ).show(context);
  }

  showAddedToCartDoneFlush({required BuildContext context}) async {
    await Flushbar(
      isDismissible: true,
      backgroundColor: Colors.white,
      //  onTap: (){},
      // title: 'title',
      duration: const Duration(seconds: 1),
      borderRadius: BorderRadius.circular(30),
      //borderColor: Colors.black,
      animationDuration: const Duration(seconds: 1),
      icon: const Icon(
        Icons.add_shopping_cart,
        color: Colors.green,
        size: 30,
      ),
      padding: const EdgeInsets.only(left: 50, bottom: 10, top: 10),
      margin: const EdgeInsets.only(left: 50, bottom: 10, top: 10, right: 50),

      barBlur: 20,

      shouldIconPulse: true,
      showProgressIndicator: false,
      // progressIndicatorBackgroundColor: Colors.black,
      flushbarPosition: FlushbarPosition.BOTTOM,
      routeBlur: 50,
      messageText: Text(
        '${getLang(context, "added to cart")}',
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold), //textAlign: TextAlign.center,
      ),
      // titleText:Text('تم تحميل المنتج بنجاح',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,) ,
      flushbarStyle: FlushbarStyle.FLOATING,
    ).show(context);
  }

  showDeletingDoneFlush({required BuildContext context}) async {
    await Flushbar(
      isDismissible: true,
      backgroundColor: Colors.white,
      //  onTap: (){},
      // title: 'title',
      duration: const Duration(seconds: 1),
      borderRadius: BorderRadius.circular(30),
      //borderColor: Colors.black,
      animationDuration: const Duration(seconds: 1),
      icon: Icon(
        Icons.delete_forever,
        color: Colors.red.withOpacity(.5),
        size: 30,
      ),
      padding: const EdgeInsets.only(left: 50, bottom: 10, top: 10),
      margin: const EdgeInsets.only(left: 50, bottom: 10, top: 10, right: 50),

      barBlur: 20,

      shouldIconPulse: true,
      showProgressIndicator: false,
      // progressIndicatorBackgroundColor: Colors.black,
      flushbarPosition: FlushbarPosition.BOTTOM,
      routeBlur: 50,
      messageText: Text(
        '${getLang(context, "deleting done")}',
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold), //textAlign: TextAlign.center,
      ),

      flushbarStyle: FlushbarStyle.FLOATING,
    ).show(context);
  }

  showorderedDoneFlush({required BuildContext context}) async {
    await Flushbar(
      isDismissible: true,
      backgroundColor: Colors.white,
      //  onTap: (){},
      // title: 'title',
      duration: const Duration(seconds: 1),
      borderRadius: BorderRadius.circular(30),
      //borderColor: Colors.black,
      animationDuration: const Duration(seconds: 1),
      icon: const Icon(
        Icons.done,
        color: Colors.green,
        size: 30,
      ),
      padding: const EdgeInsets.only(left: 50, bottom: 10, top: 10),
      margin: const EdgeInsets.only(left: 50, bottom: 10, top: 10, right: 50),

      barBlur: 20,

      shouldIconPulse: true,
      showProgressIndicator: false,
      // progressIndicatorBackgroundColor: Colors.black,
      flushbarPosition: FlushbarPosition.BOTTOM,
      routeBlur: 50,
      messageText: Text(
        '${getLang(context, "ordered")}',
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold), //textAlign: TextAlign.center,
      ),
      // titleText:Text('تم تحميل المنتج بنجاح',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,) ,
      flushbarStyle: FlushbarStyle.FLOATING,
    ).show(context);
  }

  showDoneFlush({required BuildContext context, required String text}) async {
    await Flushbar(
      isDismissible: true,
      backgroundColor: Colors.white,
      //  onTap: (){},
      // title: 'title',
      duration: const Duration(seconds: 1),
      borderRadius: BorderRadius.circular(30),
      //borderColor: Colors.black,
      animationDuration: const Duration(seconds: 1),
      icon: const Icon(
        Icons.done,
        color: Colors.green,
        size: 30,
      ),
      padding: const EdgeInsets.only(left: 50, bottom: 10, top: 10),
      margin: const EdgeInsets.only(left: 50, bottom: 10, top: 10, right: 50),

      barBlur: 20,

      shouldIconPulse: true,
      showProgressIndicator: false,
      // progressIndicatorBackgroundColor: Colors.black,
      flushbarPosition: FlushbarPosition.BOTTOM,
      routeBlur: 50,
      messageText: Text(
        text,
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold), //textAlign: TextAlign.center,
      ),
      // titleText:Text('تم تحميل المنتج بنجاح',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,) ,
      flushbarStyle: FlushbarStyle.FLOATING,
    ).show(context);
  }
}
