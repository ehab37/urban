import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:urban/components/app_local.dart';

import 'package:urban/constants/cart.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/constants/product.dart';

class CallCenterCarts extends StatefulWidget {
  static const String route = 'CallCenterCarts/';

  const CallCenterCarts({Key? key}) : super(key: key);

  @override
  State<CallCenterCarts> createState() => _CallCenterCartsState();
}

class _CallCenterCartsState extends State<CallCenterCarts> {
  GlobalKey<ScaffoldState> myScaffold = GlobalKey<ScaffoldState>();

  List<Cart>? myWaitingCarts;

  getAllCarts() async {
    try {
      List<Cart> allCarts1 = await Cart().getAllWaitingCarts();
      setState(() {
        myWaitingCarts = allCarts1;
      });
    } on Exception catch (e) {
      log('\n \n \n \n${e.toString()}\n \n \n \n \n');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCarts();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width;
    }
    return Scaffold(
      key: myScaffold,
      appBar: AppBar(title: Text('${getLang(context, 'cart')}')),
      body: myWaitingCarts == null
          ? myShimmer(context)
          : Stack(
              children: [
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .5,
                      mainAxisSpacing: height * .02,
                      crossAxisSpacing: height * .01),
                  itemBuilder: (context, index) => WaitingCartItem(
                      height: height, cart: myWaitingCarts![index]),
                  itemCount: myWaitingCarts!.length,
                  padding: EdgeInsets.all(height * .01),
                ),
                const NewFloatingAdmin()
              ],
            ),
    );
  }
}

class WaitingCartItem extends StatefulWidget {
  final Cart cart;
  final double height;

  const WaitingCartItem({Key? key, required this.cart, required this.height})
      : super(key: key);

  @override
  State<WaitingCartItem> createState() => _WaitingCartItemState();
}

class _WaitingCartItemState extends State<WaitingCartItem> {
  final GlobalKey<FormState> _myKey1 = GlobalKey<FormState>();
  double? codePrice;

  bool done = false;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: widget.height * .12,
                  width: widget.height * .12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            widget.cart.product![productImageUrl]),
                        fit: BoxFit.fill),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    //  boxShadow:  [BoxShadow(color: Colors.black.withOpacity(.1),blurRadius: .1,spreadRadius: 3)],
                  ),
                ),
              ),
              Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: widget.height * .01),
                child: Text(widget.cart.product![productName],
                    style: TextStyle(
                        fontSize: widget.height * .018,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.visible),
              )),
              done
                  ? Center(
                      child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: widget.height * .03),
                      child: Icon(
                        Icons.done_all_outlined,
                        color: Colors.green,
                        size: widget.height * .04,
                      ),
                    ))
                  : Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: widget.height * .01),
                          child: Center(
                              child: Text(
                            widget.cart.colorCode.toString(),
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.w900,
                                fontSize: widget.height * .022),
                          )),
                        ),
                        Center(
                          child: Container(
                            width: widget.height * .1,
                            height: widget.height * .1,
                            // color: Colors.red,
                            padding: EdgeInsets.symmetric(
                                vertical: widget.height * .005),
                            alignment: Alignment.center,
                            child: Form(
                              key: _myKey1,
                              child: CodePriceTextField(
                                input: TextInputType.number,
                                sFuntion: (s) {
                                  setState(() {
                                    codePrice = double.parse(s!);
                                  });
                                  return null;
                                },
                                vFuntion: (v) {
                                  if (v!.isEmpty) {
                                    return 'enter price';
                                  }
                                  return null;
                                },
                                label: 'Color Price',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: widget.height * .01),
                          child: Center(
                            child: EbottonI(
                              onpressed: () async {
                                if (!_myKey1.currentState!.validate()) {
                                  return;
                                } else {
                                  _myKey1.currentState!.save();
                                  await Cart()
                                      .editCart(cartId: widget.cart.id!, map: {
                                    codePricee: codePrice,
                                    cartStatus: selling,
                                    cartTotalPrice: codePrice!.toDouble() *
                                        widget.cart.quantity!
                                  });
                                  setState(() {
                                    done = true;
                                  });

                                  //  getAllCarts();
                                }
                              },
                              icon: Icon(Icons.done_all_outlined,
                                  size: widget.height * .018,
                                  color: Colors.white),
                              elevation: 5,
                              borderRadius: 10,
                              overColor: Colors.red,
                              padding: widget.height * .01,
                              backgroundcolor: Colors.orange.shade600,
                              alignmentt: Alignment.center,
                              shadowcolor: Colors.black,
                              borderColor: Colors.black.withOpacity(.1),
                              child: Text('Done',
                                  style: TextStyle(
                                      fontSize: widget.height * .016,
                                      color: Colors.white)),
                            ),
                          ),
                        )
                      ],
                    )
            ],
          ),
        ));
  }
}

class CodePriceTextField extends StatefulWidget {
  final TextEditingController? myController;

  final String label;

  // final Icon icon;
  final bool obsecure;
  final TextInputType input;

  final String? Function(String?) vFuntion;
  final String? Function(String?) sFuntion;

  //Function ontapFunction;

  const CodePriceTextField({
    Key? key,
    required this.label,
    this.obsecure = false,
    // required this.icon,
    required this.vFuntion,
    required this.sFuntion,
    this.myController,
    required this.input,
  }) : super(key: key);

  @override
  State<CodePriceTextField> createState() => _CodePriceTextFieldState();
}

class _CodePriceTextFieldState extends State<CodePriceTextField> {
  double borderWidth = 3;

  Color borderColor = Colors.black.withOpacity(.3);

  Color fillColor = Colors.grey.withOpacity(1);

  double borderRadus = 20;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadus),
      borderSide: BorderSide(color: borderColor, width: borderWidth),
    );

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.height;
    }
    width = width;

    return TextFormField(
      style: TextStyle(color: Colors.black, fontSize: height * .019),
      decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(.8),
          // counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: height*.015),
          filled: true,
          isCollapsed: true,
          enabled: true,
          contentPadding: EdgeInsets.all(height * .01),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.label,
          labelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: height * .015),

          // prefixIcon: icon,
          enabledBorder: outlineInputBorder,
          disabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          errorBorder: outlineInputBorder,
          focusedErrorBorder: outlineInputBorder),

      obscureText: widget.obsecure,
      textInputAction: TextInputAction.done,
      keyboardType: widget.input,
      enabled: true,
      minLines: 1,
      maxLines: 1,
      // maxLength: 20,
      // initialValue: 'bota',

      validator: widget.vFuntion,
      onSaved: widget.sFuntion,

      controller: widget.myController,
    );
  }
}
