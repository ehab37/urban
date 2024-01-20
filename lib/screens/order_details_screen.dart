import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/MyUser.dart';
import 'package:urban/constants/cart.dart';
import 'package:urban/constants/cities.dart';
import 'package:urban/constants/equipment.dart';
import 'package:urban/constants/product.dart';
import 'package:urban/providers/lang_provider.dart';

import 'image_view_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String route = 'OrderDetailsScreen/';
  final Cart cart;

  const OrderDetailsScreen({Key? key, required this.cart}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  MyUser? myUser;

  getUserInfo() async {
    MyUser myUser1 = await MyUser().getUserInfo(userId: widget.cart.uid!);
    setState(() {
      myUser = myUser1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.height;
    }
    Cart cart = widget.cart;

    if (widget.cart.equip == null) {
      City city = City().getCity(key: cityId, value: cart.cityId!);
      double price = cart.codePrice ?? cart.product![productPrice];
      Product product = Product.i(widget.cart.product);
      return Scaffold(
        appBar: AppBar(
          title: Text('${getLang(context, "details")}'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * .03),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ShowPhoto(url: product.imageUrl!),
                        ));
                  },
                  child: Container(
                    height: height * .3,
                    width: width * .6,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        // color: Colors.red,
                        image: DecorationImage(
                            image:
                                CachedNetworkImageProvider(product.imageUrl!),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              SizedBox(height: height * .05),
              SizedBox(
                  width: width * .8,
                  child: Text(
                    product.name!,
                    style: TextStyle(
                        fontSize: width * .05,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  )),
              SizedBox(height: height * .05),
              Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 5,
                color: Colors.white,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: width * .8,
                      minHeight: height * .2,
                      minWidth: width * .8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            myUser == null
                                ? const SizedBox()
                                : Row(
                                    children: [
                                      Text(
                                        '${getLang(context, "name")} : ',
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(1),
                                            fontWeight: FontWeight.bold,
                                            fontSize: height * .016),
                                      ),
                                      Text(
                                        myUser!.name!,
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(.7),
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * .016),
                                      ),
                                    ],
                                  ),
                            Row(
                              children: [
                                Text(
                                  '${getLang(context, "phone")} : ',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: height * .016),
                                ),
                                Text(
                                  '${cart.phone}',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.7),
                                      fontWeight: FontWeight.w400,
                                      fontSize: height * .018),
                                ),
                              ],
                            ), //phone
                            Row(
                              children: [
                                Text(
                                  '${getLang(context, "city")} : ',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: height * .016),
                                ),
                                ChangeNotifierProvider(
                                  create: (_) => LangProvider(),
                                  child: Consumer<LangProvider>(builder:
                                      (context, LangProvider lanNoty, child) {
                                    return Text(
                                      lanNoty.isEn ? city.en! : city.ar!,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.7),
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * .018),
                                    );
                                  }),
                                ),
                              ],
                            ), //city
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            cart.colorCode == null
                                ? const SizedBox()
                                : Row(
                                    children: [
                                      Text(
                                        '${getLang(context, "color code")} : ',
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(.5),
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * .018),
                                      ),
                                      Text(
                                        '${cart.colorCode}',
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(.5),
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * .018),
                                      ),
                                    ],
                                  ), //code
                            Row(
                              children: [
                                Text(
                                  '${getLang(context, "price")} : ',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.5),
                                      fontWeight: FontWeight.w400,
                                      fontSize: height * .018),
                                ),
                                Text(
                                  '$price',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.5),
                                      fontWeight: FontWeight.w400,
                                      fontSize: height * .018),
                                ),
                              ],
                            ), //price
                            Row(
                              children: [
                                Text(
                                  '${getLang(context, "quantity")} : ',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.5),
                                      fontWeight: FontWeight.w400,
                                      fontSize: height * .018),
                                ),
                                Text(
                                  '${cart.quantity}',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.5),
                                      fontWeight: FontWeight.w400,
                                      fontSize: height * .018),
                                ),
                              ],
                            ), //quantity
                            Row(
                              children: [
                                Text(
                                  '${getLang(context, "payment")} : ',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.5),
                                      fontWeight: FontWeight.w400,
                                      fontSize: height * .018),
                                ),
                                Text(
                                  cart.payment.toString(),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.7),
                                      fontWeight: FontWeight.w400,
                                      fontSize: height * .018),
                                ),
                              ],
                            ), //payment
                            Material(
                              color: Colors.teal.shade100,
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '${getLang(context, "total price")} : ',
                                      style: TextStyle(
                                          color: Colors.green.withOpacity(1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: height * .012),
                                    ),
                                    Text(
                                      cart.totalPrice.toString(),
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.7),
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * .018),
                                    ),
                                  ],
                                ),
                              ),
                            ), //total price
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * .05),
            ],
          ),
        ),
      );
    } else {
      Equip equip = Equip.fromJson(widget.cart.equip);

      var nameStyle = TextStyle(
        color: Colors.black.withOpacity(.5),
        fontWeight: FontWeight.bold,
        fontSize: height * .02,
      );
      var valueStyle = TextStyle(
          color: Colors.black.withOpacity(.5),
          fontWeight: FontWeight.w400,
          fontSize: height * .02);
      return Scaffold(
        appBar: AppBar(
          title: const Text('details'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * .05),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowPhoto(url: equip.imageUrl!),
                        ));
                  },
                  child: Container(
                    height: height * .3,
                    width: height * .4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        //  color: Colors.red,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(equip.imageUrl!),
                            fit: BoxFit.contain),
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              SizedBox(height: height * .05),
              Text(
                equip.name!,
                style: TextStyle(
                    fontSize: height * .03,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: height * .05),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: width * .8,
                      minHeight: height * .2,
                      minWidth: width * .8),
                  child: Padding(
                    padding: EdgeInsets.all(height * .01),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        myUser == null
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  myText(
                                      text: '${getLang(context, "name")} : ',
                                      myStyle: nameStyle),
                                  myText(
                                      text: myUser!.name!, myStyle: valueStyle),
                                ],
                              ), //name
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(
                                text: '${getLang(context, "phone")} : ',
                                myStyle: nameStyle),
                            myText(text: '${cart.phone}', myStyle: valueStyle),
                          ],
                        ), //phone
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(
                                text: '${getLang(context, "price")} : ',
                                myStyle: nameStyle),
                            myText(
                                text: equip.pricePerDay.toString(),
                                myStyle: valueStyle),
                            Text(
                              '  ${getLang(context, "per day")}',
                              style: TextStyle(
                                  color: Colors.green.withOpacity(.7),
                                  fontWeight: FontWeight.w400,
                                  fontSize: height * .018),
                            ),
                          ],
                        ), //price per day

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(
                                text: '${getLang(context, "date")} : ',
                                myStyle: nameStyle),
                            myText(text: '${cart.date}', myStyle: valueStyle),
                          ],
                        ), //date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(
                                text: '${getLang(context, "days")} : ',
                                myStyle: nameStyle),
                            myText(text: '${cart.days}', myStyle: valueStyle),
                          ],
                        ), //days
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(
                                text: '${getLang(context, "quantity")} : ',
                                myStyle: nameStyle),
                            myText(
                                text: '${cart.quantity}', myStyle: valueStyle),
                          ],
                        ), //quantity
                        Material(
                          color: Colors.teal.shade100,
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                myText(
                                    text:
                                        '${getLang(context, "total price")} : ',
                                    myStyle: TextStyle(
                                        color: Colors.green.shade900,
                                        fontSize: height * 0.018)),
                                myText(
                                    text: '${cart.totalPrice}',
                                    myStyle: valueStyle),
                              ],
                            ),
                          ),
                        ), //total
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      );
    }
  }

  DateTime? myDate;
  int? days;
  String? city;

  myText({required String text, required TextStyle myStyle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: myStyle,
        maxLines: 1,
        overflow: TextOverflow.clip,
      ),
    );
  }
}
