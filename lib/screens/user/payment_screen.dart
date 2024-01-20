import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/cart.dart';
import 'package:urban/constants/cities.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/constants/product.dart';
import 'package:urban/providers/fireProvider.dart';
import 'package:urban/providers/lang_provider.dart';

import '../image_view_screen.dart';

class PaymentScreen extends StatefulWidget {
  static const String route='PaymentScreen/';
  final Cart cart;
  final String payment;
  const PaymentScreen({Key? key, required this.cart, required this.payment}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

getCity(){
  String? idOfCity=Provider.of<FireProvider>(context,listen: false).myUserInfo!.cityId;
  City city1=City().getCity(key: cityId, value: idOfCity!);
  setState(() {
    myGovernorateId=city1.governId;
    myCityId=city1.id;

  });

}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCity();
  }
@override
Widget build(BuildContext context) {
  double height=MediaQuery.of(context).size.height;
  double width=MediaQuery.of(context).size.width;
  if(MediaQuery.of(context).orientation==Orientation.landscape){
    height=MediaQuery.of(context).size.width;
    width=MediaQuery.of(context).size.height;
  }



    Product product=Product.i(widget.cart.product);
TextStyle nameStyle=TextStyle(fontSize: height*.022,fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.bodySmall!.color);
TextStyle valueStyle=TextStyle(fontSize: height*.022,color: Theme.of(context).textTheme.bodySmall!.color);
    return

    Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 20,
            color:Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                //  SizedBox(height: height*.03),
                  Center(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPhoto(url:product.imageUrl!),));


                      },
                      child: Container(
                        height: height*.2,width: width*.4,
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


                        ,style: TextStyle(fontSize: width*.05,fontWeight: FontWeight.w900,color: Theme.of(context).textTheme.bodySmall!.color),maxLines: 1,overflow: TextOverflow.visible,textAlign: TextAlign.center,)),
                  SizedBox(height: height*.05),
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 5,
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Text('${getLang(context, "quantity")} : ',style:nameStyle),
                                Text(widget.cart.quantity.toString(),style: valueStyle),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Text('${getLang(context, "price per day")} : ',style:nameStyle),
                                Text('${widget.cart.codePrice??widget.cart.product![productPrice]}',style: valueStyle),
                                Text(' ${getLang(context, "L.E")} ',style: valueStyle),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Text('${getLang(context, "total price")} : ',style:nameStyle),
                                Text(widget.cart.totalPrice.toString(),style: valueStyle),
                                Text(' ${getLang(context, "L.E")} ',style: valueStyle),
                              ],
                            ),
                          ),
                          SizedBox(height: height*.05),
                        myCityId==null||myGovernorateId==null?const SizedBox():

                        ChangeNotifierProvider(
                          create: (_) =>LangProvider() ,
                          child:  Consumer<LangProvider>(
                              builder: (context,LangProvider lanNoty,child) {
                                return  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                  children: [

                                    Material(
                                      color: Theme.of(context).appBarTheme.backgroundColor,
                                      elevation: 3,
                                      borderRadius: BorderRadius.circular(10),
                                      child: DropdownButton(
                                        borderRadius: BorderRadius.circular(10),
                                        elevation: 5,
                                        alignment: Alignment.center,
                                        underline: const SizedBox(),
                                        dropdownColor:Theme.of(context).appBarTheme.backgroundColor,
                                        iconEnabledColor: Colors.white,

                                        items:Governorate().getGovernorates() .map((e) =>
                                            DropdownMenuItem(value: e.id,child: Text(lanNoty.isEn?e.en!:e.ar!,style: const TextStyle(fontSize: 12,color: Colors.white),),)).toList(),

                                        value:myGovernorateId,

                                        onChanged: (Object? value) {

                                          City myCity1=City().getCity(key: cityGovernId, value:value.toString() );

                                          setState(() {
                                            myGovernorateId=value.toString();
                                            myCityId=myCity1.id!;
                                          });

                                        } ,




                                      ),
                                    ),



                                    Material(
                                      color: Theme.of(context).appBarTheme.backgroundColor,
                                      elevation: 3,
                                      borderRadius: BorderRadius.circular(10),
                                      child: DropdownButton(
                                        borderRadius: BorderRadius.circular(10),
                                        elevation: 5,
                                        alignment: Alignment.center,
                                        underline: const SizedBox(),
                                        dropdownColor: Theme.of(context).appBarTheme.backgroundColor,
                                        iconEnabledColor: Colors.white,
                                        items: City().getCities(key: cityGovernId, value: myGovernorateId!) .map((e) =>
                                            DropdownMenuItem(value: e.id,child: Text(lanNoty.isEn?e.en!:e.ar!,style: const TextStyle(fontSize: 12,color: Colors.white),),)).toList(),

                                        value:myCityId,

                                        onChanged: (Object? value) {



                                          setState(() {
                                            myCityId=value.toString();
                                          });



                                        } ,




                                      ),
                                    ),





                                  ],
                                );
                              }
                          ),
                        ),

                          SizedBox(height: height*.05),
                          Form(
                            key: _myKey,
                            child: Material(
                              color: Colors.white,
                              elevation: 5,
                              borderRadius: BorderRadius.circular(30),
                              child: PhoneTextField(
                                sFuntion: (s){setState(() {phone=s;});return null;},
                                vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "phone")}';}return null;},
                                icon: const Icon(Icons.phone_iphone),
                                input: TextInputType.name,
                                value: Provider.of<FireProvider>(context,listen: false).myUserInfo!.phone,
                              ),
                            ),
                          ),


                          SizedBox(height: height*.05),




                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height*.001),
                 widget.payment==visa? Material(
                    elevation: 5,
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _myKey2,
                        child: Column(

                          children: [
                            SizedBox(height: height*.025),
                            PaymentTextField(
                              input: TextInputType.number,
                              icon:  Icon(Icons.numbers,color: Theme.of(context).canvasColor.withOpacity(.5)),
                              sFuntion: (s){setState(() {cardNumber=s;});return null;},
                              vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "card number")}';}return null;},
                              label: '${getLang(context, "card number")}',
                            ),
                            SizedBox(height: height*.025),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: width*.35,
                                  child: PaymentTextField(
                                    input: TextInputType.number,
                                    icon:  Icon(Icons.date_range,color: Theme.of(context).canvasColor.withOpacity(.5)),
                                    sFuntion: (s){setState(() {cardDate=s;});return null;},
                                    vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "card date")}';}return null;},
                                    label: '${getLang(context, "card date")}',
                                  ),
                                ),
                                SizedBox(
                                  width: width*.35,
                                  child: PaymentTextField(
                                    input: TextInputType.number,
                                    icon:  Icon(Icons.credit_card,color: Theme.of(context).canvasColor.withOpacity(.5)),
                                    sFuntion: (s){setState(() {cardCvv=s;});return null;},
                                    vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "card cvv")}';}return null;},
                                    label: '${getLang(context, "card cvv")}',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height*.025),
                            PaymentTextField(
                              input: TextInputType.name,
                              icon:  Icon(Icons.credit_card,color: Theme.of(context).canvasColor.withOpacity(.5)),
                              sFuntion: (s){setState(() {cardName=s;});return null;},
                              vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "card name")}';}return null;},
                              label: '${getLang(context, "card name")}',
                            ),
                            SizedBox(height: height*.025),
                          ],
                        ),
                      ),
                    ),
                  ):const SizedBox(),
                  SizedBox(height: height*.05),
                  EbottonI(
                      onpressed: ()async{
                       await _save(context);
                      },
                      icon: const Icon(Icons.done,color: Colors.white,),
                    elevation: 5,
                    borderRadius:20,
                    overColor: Colors.orange,
                    padding: 12,
                    backgroundcolor: Theme.of(context).appBarTheme.backgroundColor!,
                    shadowcolor: Colors.black,
                      child: Text('${getLang(context, "done")}',style: const TextStyle(color: Colors.white,)),


                  ),
                  SizedBox(height: height*.05),

                ],
              ),
            ),
          ),
        ),
      ),


    );


}
String? cardNumber;
String? cardName;
String? cardDate;
String? cardCvv;
_save(context)async{
if(widget.payment==visa){
  if(_myKey.currentState!.validate()&&_myKey2.currentState!.validate()){
    MyIndicator().loading(context);
    _myKey.currentState!.save();
    await Cart().editCart(cartId: widget.cart.id!, map:
    {
      cartPayment:visa,
      cartPhone:phone,
      cartCityId:myCityId,
      cartStatus:ordered

    }
    );
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);



  }
  else{return;}
}

else{
  if(_myKey.currentState!.validate()){
    MyIndicator().loading(context);
    _myKey.currentState!.save();
    await Cart().editCart(cartId: widget.cart.id!, map:
    {
      cartPayment:cash,
      cartPhone:phone,
      cartCityId:myCityId,
      cartStatus:ordered

    }
    );
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);



  }
  else{return;}
}

}
final GlobalKey<FormState> _myKey=GlobalKey<FormState>();
final GlobalKey<FormState> _myKey2=GlobalKey<FormState>();
String? myGovernorateId;

String? myCityId;
String? phone;
}
// ignore: must_be_immutable
class PhoneTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.black.withOpacity(.3);
  Color fillColor = Colors.white.withOpacity(.1);
  double borderRadus = 50;


  TextEditingController? myController ;
 // final String label;
  final String? value;
  final Icon icon;
  final bool obsecure;
  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  PhoneTextField({Key? key,
   // required this.label,
    this.obsecure = false,
    required this.icon,
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
      style: TextStyle(color: Colors.black,fontSize:height*.019 ),
      decoration: InputDecoration(
        //fillColor: Theme.of(context).primaryColor,
        // counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: height*.015),
        //filled: true,
          isCollapsed: true,
          enabled: true,
          contentPadding:  EdgeInsets.all(height*.015),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          //labelText: label,
          labelStyle: TextStyle(color:Colors.black,fontWeight: FontWeight.normal,fontSize:height*.015 ),

          prefixIcon: icon,
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
      // maxLength: 20,
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

class PaymentTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.black.withOpacity(.3);
  Color fillColor = Colors.white.withOpacity(.1);
  double borderRadus = 50;


  TextEditingController? myController ;
  final String label;
  final Icon icon;
  final bool obsecure;
  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  PaymentTextField({Key? key,
    required this.label,
    this.obsecure = false,
    required this.icon,
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
        fillColor: Colors.white,
        // counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: height*.015),
        //filled: true,
          isCollapsed: true,
          enabled: true,
          contentPadding:  EdgeInsets.all(height*.015),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          labelStyle: TextStyle(color:Theme.of(context).canvasColor,fontWeight: FontWeight.normal,fontSize:height*.015 ),

          prefixIcon: icon,
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