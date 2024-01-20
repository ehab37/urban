import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/equipment.dart';
import 'package:urban/constants/product.dart';
import 'package:urban/screens/image_view_screen.dart';

import '../../constants/cart.dart';
class CartDetailsScreen extends StatefulWidget {
  static const String route='CartDetailsScreen/';
  final Cart cart;
  const CartDetailsScreen({Key? key, required this.cart}) : super(key: key);

  @override
  State<CartDetailsScreen> createState() => _CartDetailsScreenState();
}

class _CartDetailsScreenState extends State<CartDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }



    if(widget.cart.equip==null){
    Product product= Product.i(widget.cart.product);
      return Scaffold(
        appBar: AppBar(
          title:  Text('${getLang(context, "details")}'),
        ),

        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*.03),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPhoto(url:product.imageUrl!),));


                  },
                  child: Container(
                    height: height*.3,width: width*.6,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                       // color: Colors.red,
                        image: DecorationImage(image: CachedNetworkImageProvider(product.imageUrl!),fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(30)

                    ),

                  ),
                ),
              ),
              SizedBox(height: height*.05),
              SizedBox(
                  width: width*.8,

                  child: Text(
                    product.name!


                    ,style: TextStyle(fontSize: width*.05,fontWeight: FontWeight.w900,color: Colors.white),maxLines: 1,overflow: TextOverflow.visible,textAlign: TextAlign.center,)),
              SizedBox(height: height*.05),
              Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 5,
                color:Theme.of(context).primaryColor,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: width*.8,
                      minHeight: height*.2,
                      minWidth: width*.8
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*.02,horizontal: width*.05),
                    child: Text(
                     product.details!


                      ,style: TextStyle(
                        fontSize: width*.045,
                        color: Colors.black.withOpacity(.7)),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.start,



                    ),
                  ),
                ),
              ),
              SizedBox(height: height*.05),










            ],
          ),
        ),

      );
    }
    else{

      Equip equip=Equip.fromJson(widget.cart.equip);
      String kind=equip.kind!;

      var nameStyle= TextStyle(color: Colors.black.withOpacity(.7),fontWeight: FontWeight.bold,fontSize: height*.02,);
      var valueStyle= TextStyle(color: Colors.black.withOpacity(.7),fontWeight: FontWeight.w400,fontSize: height*.02);
      return  Scaffold(
        appBar: AppBar(
          title: Text('${getLang(context, "details")}'),
        ),

        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*.05),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPhoto(url:equip.imageUrl!),));


                  },
                  child: Container(
                    height: height*.3,width: height*.4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      //  color: Colors.red,
                        image: DecorationImage(image: CachedNetworkImageProvider(equip.imageUrl!),fit: BoxFit.contain),
                        borderRadius: BorderRadius.circular(30)

                    ),

                  ),
                ),
              ),
              SizedBox(height: height*.05),
              Text(equip.name!,style: TextStyle(fontSize: height*.03,fontWeight: FontWeight.bold,color: Colors.black),),
              SizedBox(height: height*.05),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: width*.8,
                      minHeight: height*.2,
                      minWidth: width*.8
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(height*.01),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [


                        (kind==mixerTruck||kind==loader||kind==excavator||kind==mobileCrane)?  Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            myText(text:'${getLang(context, "capacity")} : ',myStyle: nameStyle ),
                            myText(text:'${equip.capacity}',myStyle: valueStyle ),

                          ],
                        ):const SizedBox(),//capacity
                        kind==trailerConcretePump? Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            myText(text:'${getLang(context, "pressure")} : ',myStyle: nameStyle ),
                            myText(text:'${equip.pressure}',myStyle: valueStyle ),

                          ],
                        ):const SizedBox(),//pressure
                        kind==mobilePlacingBoom?  Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(text:'${getLang(context, "length Of Boom")} : ',myStyle: nameStyle ),
                            myText(text:'${

                                equip.lengthOfBoom
                            }',myStyle: valueStyle ),

                          ],
                        ):const SizedBox(),//lengthOfBoom
                        kind==loader||kind==bulldozer? Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(text:'${getLang(context, "engine")} : ',myStyle: nameStyle ),
                            myText(text:'${equip.engine}',myStyle: valueStyle ),

                          ],
                        ):const SizedBox(),//engine
                        kind==bulldozer||kind==excavator? Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(text:'${getLang(context, "weight")} : ',myStyle: nameStyle ),
                            myText(text:'${equip.weight}',myStyle: valueStyle ),

                          ],
                        ):const SizedBox(),//weight
                        kind==mixerTruck||kind==mobileCrane||kind==truckPump? Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            myText(text:'${getLang(context, "brand")} : ',myStyle: nameStyle ),
                            myText(text:'${equip.brand}',myStyle: valueStyle ),

                          ],
                        ):const SizedBox(),//brand




                        kind==trailerConcretePump||kind==truckPump?  Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(text:'${getLang(context, "output")} : ',myStyle: nameStyle ),
                            myText(text:'${equip.output}',myStyle: valueStyle ),

                          ],
                        ):const SizedBox(),//output
                        kind==mobilePlacingBoom? Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(text:'${getLang(context, "number Of Boom")} : ',myStyle: nameStyle ),
                            myText(text:'${equip.numberOfBoom}',myStyle: valueStyle ),

                          ],
                        ):const SizedBox(),//numberOfBoom
                        kind==trailerConcretePump||kind==bulldozer||kind==excavator?   Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(text:'${getLang(context, "power")} : ',myStyle: nameStyle ),
                            myText(text:'${equip.power}',myStyle: valueStyle ),

                          ],
                        ):const SizedBox(),//power
                        kind==truckPump? Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(text:'${getLang(context, "reach")} : ',myStyle: nameStyle ),
                            myText(text:'${equip.reach}',myStyle: valueStyle ),

                          ],
                        ):const SizedBox(),//reach



                        kind==loader?  Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(text:'${getLang(context, "load")} : ',myStyle: nameStyle ),
                            myText(text:'${equip.load}',myStyle: valueStyle ),

                          ],
                        ):const SizedBox(),//load
                        kind==mobileCrane? Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(text:'${getLang(context, "extended Boom")} : ',myStyle: nameStyle ),
                            myText(text:'${equip.extendedBoom}',myStyle: valueStyle ),

                          ],
                        ):const SizedBox(),//extendedBoom







                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            myText(text:'${getLang(context, "price")} : ',myStyle: nameStyle ),
                            myText(text:equip.pricePerDay.toString(),myStyle: valueStyle ),

                            Text('  ${getLang(context, "per day")}',style: TextStyle(color: Colors.green.withOpacity(.7),fontWeight: FontWeight.w400,fontSize: height*.018),),
                          ],
                        ),//price
                      ],
                    ),
                  ),
                ),
              ),




              const SizedBox(height: 80,),







            ],
          ),
        ),








      );
    }

  }



  DateTime? myDate;
  int?days;
  String?city;
  myText({required String text,required TextStyle myStyle}){

    return
      Padding(
        padding:  const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(text,

          style: myStyle,

          maxLines: 1,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.left,



        ),
      )
    ;
  }
}
