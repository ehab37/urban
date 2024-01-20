// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/cart.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/data/main_info.dart';
import 'package:urban/constants/my_flush.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/constants/product.dart';
import 'package:urban/providers/fireProvider.dart';
import 'package:urban/screens/image_view_screen.dart';
class ProductDetails extends StatefulWidget {
  static const String route='ProductDetails/';
  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}


class _ProductDetailsState extends State<ProductDetails> {
final GlobalKey<FormState> _myKey=GlobalKey<FormState>();
final GlobalKey<FormState> _myKey2=GlobalKey<FormState>();
  String?code;
  String quantity='1';
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    bool isAdmin=Provider.of<FireProvider>(context).isAdmin!;

    return Scaffold(
      appBar: AppBar(
        title:  Text('${getLang(context, "details")}'),
      ),

      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height*.03),
                Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPhoto(url:widget.product.imageUrl!),));


                    },
                    child: Material(
                      color: Colors.white,
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: height*.3,width: width*.6,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                         // color: Colors.red,
                          image: DecorationImage(image: CachedNetworkImageProvider(widget.product.imageUrl!),fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(30)

                        ),

                      ),
                    ),
                  ),
                ),


                SizedBox(height: height*.05),
                SizedBox(
                  width: width*.8,

                    child: Text(
                      widget.product.name!


                      ,style: TextStyle(fontSize: width*.05,fontWeight: FontWeight.w900,color: Colors.white),maxLines:2 ,overflow: TextOverflow.visible,textAlign: TextAlign.center,)),
                SizedBox(height: height*.05),
                SizedBox(
                  width:  width*.8,
                  child: Row(
                    children: [
                      const SizedBox(),
                      Material(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).primaryColor,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(' ${getLang(context, "price")} : ',
                                style:TextStyle(color: Colors.orange.withOpacity(1),
                                  fontSize: height*.015,
                                  fontWeight: FontWeight.normal,




                                ) ,),
                              SizedBox(
                                width:width*.3,
                                child: Text('${widget.product.price}',
                                  style:TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,
                                    fontSize: height*.018,
                                    fontWeight: FontWeight.normal,) ,
                                  textAlign: TextAlign.start,



                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height*.01),
                Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5,
                  color: Theme.of(context).primaryColor,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: width*.8,
                      minHeight: height*.1,
                      minWidth: width*.8
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: height*.01,horizontal: width*.05),
                      child: Text(
                       widget.product.details!


                        ,style: TextStyle(
                          fontSize: width*.04,
                          color: Theme.of(context).textTheme.titleMedium!.color),
                          textDirection: TextDirection.ltr,
                        textAlign: TextAlign.start,



                      ),
                    ),
                  ),
                ),
               isAdmin?const SizedBox(): Column(
                  children: [
                    SizedBox(height: height*.025),
                    widget.product.section!=paints?const SizedBox(): SizedBox(
                      height: height*.18,
                      width: width*.8,
                      child: Row(

                        children: [

                          Expanded(
                            child: anotherBox(height: height),
                          ),
                          Expanded(
                            child: whiteBox(height: height),
                          ),

                        ],
                      ),
                    ),


                    SizedBox(height: height*.025),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${getLang(context, "quantity")} : ',
                          style: TextStyle(color:Theme.of(context).textTheme.bodySmall!.color,fontWeight: FontWeight.bold),


                        ),
                        SizedBox(
                          height: height*.07,
                          width: height*.2,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:Form(
                                  key: _myKey2,
                                  child: QuantityTextField(
                                    input: TextInputType.phone,
                                    value: quantity,
                                    sFuntion: (s){setState(() {quantity=s!;});return null;},
                                    vFuntion: (v){if(v!.isEmpty||v=="0"){return'${getLang(context, "enter")} ${getLang(context, "quantity")}';}return null;},



                                  )),
                            ),
                          ),
                        ),

                      ],
                    ),


                    SizedBox(height: height*.05),


                    widget.product.section==paints?  EbottonI(
                        onpressed: ()async{

                          var uid=Provider.of<FireProvider>(context,listen: false).myId;
                          if(radioSelect=='isWhite'){
                            if(!_myKey2.currentState!.validate()){return;}
                            else{
                              MyIndicator().loading(context);
                              _myKey2.currentState!.save();
                              await Cart().addCart(cart:
                              Cart(
                                product: Product().getMap(widget.product),
                                status: selling,

                                uid:uid,

                                id: Random().nextInt(1000000).toString(),
                                quantity:double.parse(quantity) ,

                                totalPrice: widget.product.price!*double.parse(quantity),
                                isAvailable: true,
                                isAccepted: false,



                              )
                              );
                              Navigator.pop(context);
                              MyFlush().showAddedToCartDoneFlush(context: context);

                            }


                          }




                          else if(radioSelect=='notWhite'){
                            if(!_myKey.currentState!.validate()){return;}
                            else{
                              MyIndicator().loading(context);
                              _myKey.currentState!.save();
                              await Cart().addCart(cart: Cart(
                                  product: Product().getMap(widget.product),
                                  status: waiting,
                                  uid:uid,
                                  id: Random().nextInt(1000000).toString(),
                                  colorCode: code,
                                  quantity:double.parse(quantity) ,
                                  isAvailable: true,
                                  isAccepted: false

                              ));
                              Navigator.pop(context);
                              MyFlush().showAddedToCartDoneFlush(context: context);

                            }

                          }



                        },
                        backgroundcolor:  Theme.of(context).appBarTheme.backgroundColor!,
                        padding: 15,
                        elevation: 10,
                        shadowcolor: Colors.black.withOpacity(.5),
                        borderRadius: 10,
                        alignmentt: Alignment.center,
                        borderColor: Colors.white.withOpacity(0),
                        overColor: Colors.orange,
                        icon: const Icon(Icons.add_shopping_cart,color: Colors.white,),

                        child:  Text('${getLang(context, "add to cart")}',style: const TextStyle(color: Colors.white)))


                        :
                    EbottonI(
                        onpressed: ()async{

                          var uid=Provider.of<FireProvider>(context,listen: false).myId;

                          MyIndicator().loading(context);
                          await Cart().addCart(cart:
                          Cart(
                            product: Product().getMap(widget.product),
                            status: selling,

                            uid:uid,

                            id: Random().nextInt(1000000).toString(),
                            quantity:double.parse(quantity) ,

                            totalPrice: widget.product.price!*double.parse(quantity),
                            isAvailable: true,
                            isAccepted: false,



                          )
                          );
                          Navigator.pop(context);
                          MyFlush().showAddedToCartDoneFlush(context: context);











                        },
                        backgroundcolor:  Theme.of(context).appBarTheme.backgroundColor!,
                        padding: 15,
                        elevation: 5,
                        borderRadius: 10,
                        alignmentt: Alignment.center,
                        borderColor: Colors.white.withOpacity(0),
                        overColor: Colors.orange,
                        icon: const Icon(Icons.add_shopping_cart,color: Colors.white,),

                        child:  Text('${getLang(context, "add to cart")}',style: const TextStyle(color: Colors.white)))
                  ],
                )


                ,
                SizedBox(height: height*.1),


              ],
            ),
          ),
          Provider.of<FireProvider>(context,listen: false).isAdmin!?const NewFloatingAdmin(): const NewFloatingUser()
        ],
      ),

    );
  }


  bool isWhite=true;
  List<String> radioList=['isWhite','notWhite'];
  String? radioSelect='isWhite';

  Duration myDuration=const Duration(milliseconds: 500);
  anotherBox({required double height}){
    return Padding(
      padding:  EdgeInsets.all(height*.01),
      child: Material(
        color:Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
        elevation: 5,
        child: InkWell(
          borderRadius:BorderRadius.circular(20),
          splashColor: Colors.blue,
          onTap: (){
            setState(() {
              radioSelect='notWhite';
            });
          },
          child: AnimatedContainer(
            duration: myDuration,

            decoration: BoxDecoration(
            //  color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: Colors.black.withOpacity(.1),width: 3
                )

            ),
            child: ListView(
             // mainAxisAlignment: radioSelect=='isWhite'?MainAxisAlignment.start: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  children: [
                    Radio(
                        value: radioList[1],
                        groupValue: radioSelect,
                        onChanged: (String? s){setState(() {radioSelect=s;});},
                    //  focusColor: Colors.red,
                     // hoverColor: Colors.yellow,
                     // activeColor: Colors.green,
                      fillColor: MaterialStateProperty.all(Colors.white),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,



                    ),
                    Text('${getLang(context, "Another Color")}',style: TextStyle(fontSize: height*.015,fontWeight: FontWeight.bold,color: Colors.white),)
                  ],

                ),
                radioSelect=='isWhite'?const SizedBox()
                    : AnimatedContainer(
                  duration: myDuration,
                  width: height*.15,
                  padding: EdgeInsets.symmetric(vertical: height*.02),
                  child: Form(
                    key: _myKey,
                    child: CodeTextField(
                      input: TextInputType. text,
                      sFuntion: (s){setState(() {code=s;});return null;},
                      vFuntion: (v){if(v!.isEmpty){return'enter code';}return null;},
                      label: '${getLang(context, "color code")}',

                    ),
                  ),
                ),


              ],
            ),



          ),
        ),
      ),
    );
  }

  whiteBox({required double height}){
    return Padding(
      padding:  EdgeInsets.all(height*.01),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 4,

        child: InkWell(
          borderRadius:BorderRadius.circular(20),
          splashColor: Colors.blue,
          onTap: (){
            setState(() {
              radioSelect='isWhite';
            });
          },
          child: AnimatedContainer(
            duration: myDuration,

            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black.withOpacity(.1),width: 3
              )

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Radio(
                      value: radioList[0],
                      groupValue: radioSelect,
                      onChanged: (String? s){setState(() {radioSelect=s;});},
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap


                    ),
                    Text('${getLang(context, "White Color")}',style: TextStyle(fontSize: height*.015,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(.7)),)
                  ],

                ),



              ],
            ),



          ),
        ),
      ),
    );
  }

}
class CodeTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.black.withOpacity(.3);
  Color fillColor = Colors.grey.withOpacity(1);
  double borderRadus = 20;


  TextEditingController? myController ;
  final String label;
 // final Icon icon;
  final bool obsecure;
  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  CodeTextField({Key? key,
    required this.label,
    this.obsecure = false,
   // required this.icon,
    required this.vFuntion,
    required this.sFuntion,
    this.myController,
    required this.input,



  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder=OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadus),
      borderSide: BorderSide(color: borderColor, width: borderWidth),
    );

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }

    return  TextFormField(
      style: TextStyle(color: Colors.black,fontSize:height*.019 ),
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(.8),
        // counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: height*.015),
        filled: true,


          contentPadding:  EdgeInsets.all(height*.015),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          labelStyle: TextStyle(color:Colors.black,fontWeight: FontWeight.w500,fontSize:height*.015 ),


         // prefixIcon: icon,
          enabledBorder: outlineInputBorder,
          disabledBorder:outlineInputBorder,
          focusedBorder: outlineInputBorder,
          errorBorder: outlineInputBorder,
          focusedErrorBorder: outlineInputBorder
      ),

      obscureText: obsecure,
      textInputAction: TextInputAction.done,
      keyboardType: input,
      enabled: true,
      minLines: 1,
      maxLines: 1,
      selectionControls: CupertinoTextSelectionControls(),
      // maxLength: 20,
      // initialValue: 'bota',

      validator:vFuntion ,
      onSaved:sFuntion ,

      controller: myController,
    );
  }

/*
  validator:( String v){
  if(v.isEmpty){return 'wrong';}
  return  null;
  }
   */
/*
 onPressed:(){if (!formKey.currentState.validate()) {return;}
                    formKey.currentState.save();
                    }
 */
}



class QuantityTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.black.withOpacity(.3).withOpacity(1);
  Color fillColor = Colors.white.withOpacity(.1);
  double borderRadus = 50;


  TextEditingController? myController ;
  // final String label;
  final String? value;
 // final Icon icon;
  final bool obsecure;
  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  QuantityTextField({Key? key,
    // required this.label,
    this.obsecure = false,
   // required this.icon,
    required this.vFuntion,
    required this.sFuntion,
    this.myController,
    required this.input,
    this.value



  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder=OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadus),
      borderSide: BorderSide(color: borderColor, width: borderWidth),
    );

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }

    return  TextFormField(
      style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize:height*.019 ),
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(.1),
        // counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: height*.015),
        filled: true,
          isCollapsed: true,
          enabled: true,
          contentPadding:  EdgeInsets.all(height*.015),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          //labelText: label,
          //labelStyle: TextStyle(color:Colors.black,fontWeight: FontWeight.normal,fontSize:height*.015 ),

       //   prefixIcon: icon,
          enabledBorder: outlineInputBorder,
          disabledBorder:outlineInputBorder,
          focusedBorder: outlineInputBorder,
          errorBorder: outlineInputBorder,
          focusedErrorBorder: outlineInputBorder
      ),

      obscureText: obsecure,
      textInputAction: TextInputAction.done,
      keyboardType: input,
      enabled: true,
      minLines: 1,
      maxLines: 1,
       maxLength: 3,
      initialValue: value,

      validator:vFuntion ,
      onSaved:sFuntion ,

      controller: myController,
    );
  }

/*
  validator:( String v){
  if(v.isEmpty){return 'wrong';}
  return  null;
  }
   */
/*
 onPressed:(){if (!formKey.currentState.validate()) {return;}
                    formKey.currentState.save();
                    }
 */
}