import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/cart.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/equipment.dart';
import 'package:intl/intl.dart';
import 'package:urban/constants/my_flush.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/providers/fireProvider.dart';
import 'package:urban/screens/image_view_screen.dart';
import 'package:urban/screens/material_screens/product_details.dart';

class EquipmentDetails extends StatefulWidget {
  static const String route='EquipmentDetails/';
  final Equip equip;
  const EquipmentDetails({Key? key, required this.equip}) : super(key: key);

  @override
  State<EquipmentDetails> createState() => _EquipmentDetailsState();
}

class _EquipmentDetailsState extends State<EquipmentDetails> {
  final GlobalKey<FormState> _myKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }

    bool isAdmin=Provider.of<FireProvider>(context).isAdmin!;

    String kind=widget.equip.kind!;
    Equip equip=widget.equip;

   var nameStyle= TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.8),fontWeight: FontWeight.bold,fontSize: height*.02,);
   var valueStyle= TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.8),fontWeight: FontWeight.w400,fontSize: height*.02);
    return  Scaffold(
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
                SizedBox(height: height*.05),
                Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPhoto(url:widget.equip.imageUrl!),));


                    },
                    child: Container(
                      height: height*.3,width: height*.4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                         // color: Colors.red,
                          image: DecorationImage(image: CachedNetworkImageProvider(widget.equip.imageUrl!),fit: BoxFit.contain),
                          borderRadius: BorderRadius.circular(30)

                      ),

                    ),
                  ),
                ),
                SizedBox(height: height*.05),
                Text(
                  widget.equip.name!
                  ,style: TextStyle(fontSize: height*.03,fontWeight: FontWeight.bold,color:Theme.of(context).textTheme.bodySmall!.color),),
                SizedBox(height: height*.05),
               Material(
                 borderRadius: BorderRadius.circular(20),
                 elevation: 5,
                 color:Theme.of(context).primaryColor,
                 child: ConstrainedBox(
                   constraints: BoxConstraints(
                       maxWidth: width*.8,
                       minHeight: height*.1,
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
                             myText(text:'${getLang(context, "price per day")} : ',myStyle: nameStyle ),
                             myText(text:equip.pricePerDay.toString(),myStyle: valueStyle ),

                          //   Text('  ${getLang(context, "per day")}  ',style: TextStyle(color: Colors.orange.withOpacity(.7),fontWeight: FontWeight.w400,fontSize: height*.018),),
                           ],
                         ),//price
                       ],
                     ),
                   ),
                 ),
               ),
             const SizedBox(height: 20),

             isAdmin?const SizedBox():   Column(
                  children: [
                    Material(
                      color: Theme.of(context).primaryColor,
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: height*.3,
                        width: width*.8,


                        child: Form(
                          key: _myKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: width*.5,
                                child: MyTextField(
                                  input: TextInputType.number,
                                  sFuntion: (s){setState(() {days=int.parse(s!);});return null;},
                                  vFuntion:(v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "days")}';}return null;},
                                  label: '${getLang(context, "days")}',
                                  length: 3,
                                ),
                              ),

                              EbottonI(
                                icon: Icon(myDate==null?Icons.calendar_month:Icons.done_all_outlined,color: Colors.white),

                                padding: height*.02,
                                borderRadius: 20,
                                backgroundcolor:myDate==null? Colors.deepOrange.withOpacity(.6):Colors.green,
                                elevation: 5,
                                shadowcolor: Colors.black,


                                onpressed: ()async{

                                  DateTime? myDate1=await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2024,12),
                                    // currentDate: myDate
                                  );
                                  setState(() {
                                    myDate=myDate1;
                                  });

                                  print(myDate);

                                },
                                child: Text(myDate==null?'${getLang(context, "date")}':DateFormat.yMd().format(myDate!),style: TextStyle(color: myDate==null?Colors.white:Colors.white)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${getLang(context, "quantity")} : ',
                                    style: TextStyle(color: Colors.black.withOpacity(.7),fontWeight: FontWeight.bold),


                                  ),
                                  SizedBox(
                                    height: height*.07,
                                    width: height*.2,
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:QuantityTextField(
                                          input: TextInputType.phone,
                                          value: quantity,
                                          sFuntion: (s){setState(() {quantity=s!;});return null;},
                                          vFuntion: (v){if(v!.isEmpty||v=="0"){return'${getLang(context, "enter")} ${getLang(context, "quantity")}';}return null;},



                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),



                    const SizedBox(height: 50,),
                    EbottonI(
                        onpressed: ()async{
                          if(_myKey.currentState!.validate()){


                            MyIndicator().loading(context);
                            _myKey.currentState!.save();
                            debugPrint ('save done');


                            if (myDate==null) {
                              Navigator.pop(context);
                              MyFlush().showFlush(context: context, text: '${getLang(context, "enter")} ${getLang(context, "date")}');
                              return;}
                            else{



                              String id= Random().nextInt(100000).toString();
                              var uid=Provider.of<FireProvider>(context,listen: false).myId;

                              await Cart().addCart(cart: Cart(


                                  status: selling,

                                  uid:uid,

                                  id: id,
                                  quantity: double.parse(quantity),
                                  equip: Equip().getMap(equip),
                                  date: DateFormat.yMMMd().format(myDate!),
                                  days: days,

                                  totalPrice:  double.parse(quantity)  *equip.pricePerDay!*days!.toDouble(),
                                  isAvailable: true,
                                  isAccepted: false



                              ));






                              Navigator.pop(context);

                              MyFlush().showAddedToCartDoneFlush(context: context);
                              setState(() {

                                myDate=null;

                              });


                            }






                          }
                          else{return;}




                        },
                        backgroundcolor: Theme.of(context).appBarTheme.backgroundColor!,
                        padding: 15,
                        elevation: 5,
                        borderRadius: 10,
                        alignmentt: Alignment.center,
                        borderColor: Colors.white.withOpacity(0),
                        overColor: Colors.orange,
                        icon: const Icon(Icons.add_shopping_cart,color: Colors.white,),

                        child:  Text('${getLang(context, "add to cart")}',style: const TextStyle(color: Colors.white))),

                    const SizedBox(height: 30,),
                  ],
                )










              ],
            ),
          ),
          Provider.of<FireProvider>(context,listen: false).isAdmin!?const NewFloatingAdmin(): const NewFloatingUser()
        ],
      ),








    );
  }

  String quantity='1';
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
class MyTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.black.withOpacity(1);
  Color fillColor = Colors.white.withOpacity(.1);
  double borderRadus = 5;


  TextEditingController? myController ;
  final String label;
 // final Icon icon;
  final bool obsecure;
  final TextInputType input;
  final int length;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  MyTextField({Key? key,
    required this.label,
    this.obsecure = false,
   // required this.icon,
    required this.vFuntion,
    required this.sFuntion,
    this.myController,
    required this.input,
    required this.length



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
      style: TextStyle(color: Colors.black,fontSize:height*.019,fontWeight: FontWeight.bold ),
      decoration: InputDecoration(
        //fillColor: Theme.of(context).primaryColor,
        // counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: height*.015),
        //filled: true,
          isCollapsed: true,
          enabled: true,
          contentPadding:  EdgeInsets.all(height*.015),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: label,
          labelStyle: TextStyle(color:Colors.black,fontWeight: FontWeight.normal,fontSize:height*.015 ),

         // prefixIcon: icon,
         // prefixIconColor: Colors.orangeAccent,
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
      maxLength: length,
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