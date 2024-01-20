import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/cart.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/equipment.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/constants/product.dart';
import 'package:urban/providers/fireProvider.dart';
import 'package:urban/screens/user/cart_Details.dart';

import 'payment_screen.dart';
class CartsScreen extends StatefulWidget {
  static const String route='CartsScreen/';
  const CartsScreen({Key? key}) : super(key: key);

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  List<Cart>?mySellingCarts;
  List<Cart>?myWaitingCarts;
  List<Cart>?myEquipmentsCarts;
  List<Cart>?myCarts;
  List<Cart>?allCarts;

  double equipmentsTotalPrice=0;
  double sellingTotalPrice=0;
  getMyCarts()async{
    String? myId=Provider.of<FireProvider>(context,listen: false).myId;
   try{
     List<Cart> myCarts1=await Cart().getMyCarts(myUserId: myId!);


     setState(() {
       myCarts=myCarts1;
       mySellingCarts=myCarts1.where((element) => element.status==selling&&element.equip==null).toList();
       myEquipmentsCarts=myCarts1.where((element) =>element.equip!=null).toList();
       myWaitingCarts=myCarts1.where((element) => element.status==waiting).toList();

     });

     double sellingTotalPrice1=0;
     double equipmentsTotalPrice1=0;
     for(var cart in mySellingCarts!){
         Product product1=Product.i(cart.product);
         double quantity=  cart.quantity!.toDouble();
         double price=cart.codePrice??product1.price!;
         sellingTotalPrice1=sellingTotalPrice1+cart.totalPrice!.toDouble() ;
     }


     for(var cart in myEquipmentsCarts!){
         Equip equip1=Equip.fromJson(cart.equip!);
         double days=cart.days!.toDouble() ;
         double price=equip1.pricePerDay!;
         equipmentsTotalPrice1=equipmentsTotalPrice1+cart.totalPrice!.toDouble() ;


     }

     setState(() {
       sellingTotalPrice=sellingTotalPrice1;
       equipmentsTotalPrice=equipmentsTotalPrice1;
     });

   }on Exception catch(e){print('\n \n \n \n${e.toString()}\n \n \n \n \n');}
  }
  @override
  void initState() {

    super.initState();
    getMyCarts();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return myCarts==null?Scaffold(appBar: AppBar(),body: myShimmer(context),):


    DefaultTabController (
      length: 3,
      child: Scaffold(

        appBar: AppBar(
          elevation: 5,
            title:  Row(
              children: [

                const Icon(Icons.shopping_cart),
                const SizedBox(width: 10),
                Text('${getLang(context, "cart")}'),

              ],
            ),
          toolbarHeight: 50,
          bottom:   TabBar(
            physics:const RangeMaintainingScrollPhysics(),

            padding: const EdgeInsets.all(0),
            automaticIndicatorColorAdjustment: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 7,
            indicatorColor: Colors.white,

            tabs: [
              Tab(
                height: 70,
                icon: Icon(Icons.sell,color: Theme.of(context).primaryColor.withOpacity(.5)),
                child: Text('${getLang(context, "selling")}',style: TextStyle(color: Theme.of(context).primaryColor),),


              ),
              Tab(height: 70,

                icon: Icon(Icons.alarm,color: Theme.of(context).primaryColor.withOpacity(.5)),
                child: Text('${getLang(context, "waiting")}',style: TextStyle(color: Theme.of(context).primaryColor)),),
              Tab(height: 70,

                icon: Icon(Icons.car_rental,color: Theme.of(context).primaryColor.withOpacity(.5)),
                child: Text('${getLang(context, "Equipments")}',style: TextStyle(color: Theme.of(context).primaryColor)),),
            ],
          ),






        ),







        body:Stack(

          children: [
            TabBarView(
              children: [

//selling
            CustomScrollView(
              slivers: [

                SliverAppBar(
                  backgroundColor: Colors.teal.withOpacity(0),
                  floating: true,
                  flexibleSpace:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      const SizedBox(),
                      Material(
                        elevation: 5,
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(

                            children:  [
                               Text('${getLang(context, "total price")} : ',style: const TextStyle(color: Colors.white,),),
                              Text(sellingTotalPrice.toString(),style: const TextStyle(color: Colors.white,)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(),


                    ],
                  ),
                  leading: const SizedBox(),
                ),

                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (context,index) {
                        return
                          _sellingCartItem(
                              height: height, cart: mySellingCarts![index]);


                      },
                    childCount: mySellingCarts!.length


                      ),

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:.65,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 30,
                    // mainAxisExtent: 400
                  ),



                ),
              ],

            ),



                //waiting
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .7,
                      mainAxisSpacing: height*.01,
                      crossAxisSpacing: height*.01
                  ) ,
                  itemBuilder:(context,index)=>_waitingCartItem(height: height,cart: myWaitingCarts![index]),
                  itemCount:myWaitingCarts!.length ,
                  padding: EdgeInsets.all(height*.01),




                ),


                CustomScrollView(
                  slivers: [

                    SliverAppBar(
                      backgroundColor: Colors.teal.withOpacity(0),
                      floating: true,
                      flexibleSpace: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          const SizedBox(),
                          Material(
                            elevation: 5,
                            color: Theme.of(context).appBarTheme.backgroundColor,
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(

                                children:  [
                                  const Text('Total Price : ',style: TextStyle(color: Colors.white,),textDirection: TextDirection.ltr,),
                                  Text(equipmentsTotalPrice.toString(),style: const TextStyle(color: Colors.white,),textDirection: TextDirection.ltr,),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(),


                        ],
                      ),
                      leading: const SizedBox(),
                    ),

                    SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                              (context,index) {
                            return
                              _equipmentCartItem(
                                  height: height, cart: myEquipmentsCarts![index]);


                          },
                          childCount: myEquipmentsCarts!.length


                      ),

                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:.7,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 30,
                        // mainAxisExtent: 400
                      ),



                    ),
                  ],

                ),//equip
              ],
            ),
            Provider.of<FireProvider>(context,listen: false).isAdmin!?const NewFloatingAdmin(): const NewFloatingUser()
          ],
        ),



      ),
    );
  }



  String? phone;
  final GlobalKey<FormState> _myKey=GlobalKey<FormState>();
  _sellingCartItem({required double height,required Cart cart}){
    double price=cart.codePrice??cart.product![productPrice];

    String color='';

    return InkWell(
      onTap: (){
        if(cart.isAvailable!){ Navigator.push(context, MaterialPageRoute(builder: (context) =>  CartDetailsScreen(cart: cart),));}

      },
        child: Material(
          color: Colors.white.withOpacity(.8),
            elevation: 5,
            borderRadius: BorderRadius.circular(20),



            child: Container(
             // color: Colors.white,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Center(
                    child:
                    cart.isAvailable==false?

                    Container(
                      height: height*.12,width: height*.12,
                    alignment: Alignment.center,
                    child:  Text('${getLang(context, "not available")}'),



                    ):

                    Container(
                      height: height*.12,width: height*.12,
                      decoration: BoxDecoration(
                          color: Colors.white,
                        image: DecorationImage(image: CachedNetworkImageProvider(cart.product![productImageUrl]),fit: BoxFit.fill),
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft:  Radius.circular(10),),
                      ),



                    ),
                  ),
                  Center(child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*.01),
                    child: Text(cart.product![productName],style: TextStyle(fontSize: height*.018,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.visible),
                  )),
                 Padding(
                   padding:   EdgeInsets.symmetric(horizontal: height*.01),
                   child: Column(
                     children: [
                       Row(
                         children: [
                           Text('${getLang(context, "price")} : ',style: TextStyle(color: Colors.black.withOpacity(.5),fontWeight: FontWeight.w400,fontSize: height*.012),),
                           Text('$price',style: TextStyle(color: Colors.black.withOpacity(.5),fontWeight: FontWeight.w400,fontSize: height*.012),),
                         ],
                       ),
                       Row(
                         children: [
                           Text('${getLang(context, "quantity")} : ',style: TextStyle(color: Colors.black.withOpacity(.5),fontWeight: FontWeight.w400,fontSize: height*.012),),
                           Text('${cart.quantity}',style: TextStyle(color: Colors.black.withOpacity(.5),fontWeight: FontWeight.w400,fontSize: height*.012),),
                         ],
                       ),
                       cart.colorCode==null?const SizedBox():  Row(
                         children: [
                           Text('${getLang(context, "color code")} : ',style: TextStyle(color: Colors.black.withOpacity(.5),fontWeight: FontWeight.w400,fontSize: height*.012),),
                           Text('${cart.colorCode}',style: TextStyle(color: Colors.black.withOpacity(.5),fontWeight: FontWeight.w400,fontSize: height*.012),),
                         ],
                       ),
                       Row(
                         children: [
                           Text('${getLang(context, "total price")} : ',style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.bold,fontSize: height*.012),),
                           Text(

                             cart.totalPrice.toString()



                             ,style: TextStyle(color: Colors.black.withOpacity(.7),fontWeight: FontWeight.w600,fontSize: height*.012),),
                         ],
                       ),
                     ],
                   ),
                 ),

                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EbottonI(
                            onpressed: ()async{
                              MyIndicator().loading(context);
                              await Cart().deleteCart(cartId: cart.id!);
                              await getMyCarts();
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.delete,size: height*.018,color: Colors.red.withOpacity(.7)),
                          elevation: 1,
                          borderRadius: 10,
                          overColor: Colors.red,
                          padding: height*.008,
                          backgroundcolor: Colors.white,
                          alignmentt: Alignment.center,
                          shadowcolor: Colors.black,
                          borderColor: Colors.black.withOpacity(.1),
                            child: Text('${getLang(context, "delete")}',style: TextStyle(fontSize: height*.012,color: Colors.black.withOpacity(.7))),



                        ),
                        cart.isAvailable!?    Ebotton(
                            onpressed: (){
                                showDialog(context: context, builder:(BuildContext context) =>
                              Dialog(
                                alignment: Alignment.center,
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Container(
                                  height: height*.22,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView(
                                      padding: const EdgeInsets.all(8),

                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: EbottonI(
                                            onpressed: ()async{
                                              await Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(cart:cart,payment: cash,)))
                                                  .then((value)=> getMyCarts());



                                            },
                                            icon: const Icon(Icons.attach_money_rounded,color: Colors.white,),
                                          elevation: 5,
                                            borderRadius: 10,
                                            padding: 12,
                                            backgroundcolor: Theme.of(context).appBarTheme.backgroundColor!,
                                            overColor: Colors.deepOrangeAccent,
                                            shadowcolor: Colors.black,
                                            child:  Text('${getLang(context, "cash")}',style: const TextStyle(color: Colors.white)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: EbottonI(
                                            onpressed: ()async{
                                              await Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(cart:cart,payment: visa,))).then((value) => getMyCarts());
                                            },
                                            icon: const Icon(Icons.credit_card,color: Colors.white,),
                                          elevation: 5,
                                            borderRadius: 10,
                                            padding: 12,
                                            backgroundcolor: Theme.of(context).appBarTheme.backgroundColor!,
                                            overColor: Colors.deepOrangeAccent,
                                            shadowcolor: Colors.black,
                                            child:  Text('${getLang(context, "visa")}',style: const TextStyle(color: Colors.white)),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ));
                            },
                           // icon: Icon(Icons.money,size: height*.018,color: Colors.green.withOpacity(.7)),
                          elevation: 1,
                          borderRadius: 10,
                          overColor: Colors.orangeAccent,
                          padding: height*.008,
                          backgroundcolor: cart.isAvailable!?Theme.of(context).appBarTheme.backgroundColor!:Colors.grey,
                          alignmentt: Alignment.center,
                          shadowcolor: Colors.black,
                          borderColor: Colors.black.withOpacity(.1),
                            child: Text('${getLang(context, "buy")}',style: TextStyle(fontSize: height*.012,color: Colors.white.withOpacity(1))),



                        ):const SizedBox(),
                      ],
                    ),
                  )
                ],
              ),

            )



        )





    );


  }




  _equipmentCartItem({required double height,required Cart cart}){
    Equip equip=Equip.fromJson(cart.equip);
    double price=equip.pricePerDay!;



    return InkWell(
      onTap: (){
        if(cart.isAvailable!){  Navigator.push(context, MaterialPageRoute(builder: (context) =>  CartDetailsScreen(cart: cart),));}

      },
        child: Material(
          color: Colors.white.withOpacity(.8),
            elevation: 5,
            borderRadius: BorderRadius.circular(20),



            child: Container(
             // color: Colors.white,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Center(
                    child: cart.isAvailable==false?

                    Container(
                      height: height*.12,width: height*.12,
                      alignment: Alignment.center,
                      child:  Text('${getLang(context, "not available")}')



                    ):
                    Container(
                      height: height*.12,width: height*.12,
                      decoration: BoxDecoration(
                          color: Colors.white,
                        image: DecorationImage(image: CachedNetworkImageProvider(equip.imageUrl!),fit: BoxFit.fill),
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft:  Radius.circular(10),),
                      //  boxShadow:  [BoxShadow(color: Colors.black.withOpacity(.1),blurRadius: .1,spreadRadius: 3)],




                      ),
                    ),
                  ),
                  Center(child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*.01),
                    child: Text(equip.name!,style: TextStyle(fontSize: height*.018,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.visible),
                  )),
                 Padding(
                   padding:   EdgeInsets.symmetric(horizontal: height*.01),
                   child: Column(
                     children: [
                       Row(
                         children: [
                           Text('${getLang(context, "price per day")} : ',style: TextStyle(color: Colors.black.withOpacity(.5),fontWeight: FontWeight.w400,fontSize: height*.014),),
                           Text('${equip.pricePerDay}',style: TextStyle(color: Colors.black.withOpacity(.5),fontWeight: FontWeight.w400,fontSize: height*.014),),
                         ],
                       ),
                       Row(
                         children: [
                           Text('${getLang(context, "days")} : ',style: TextStyle(color: Colors.black.withOpacity(.5),fontWeight: FontWeight.w400,fontSize: height*.014),),
                           Text('${cart.days}',style: TextStyle(color: Colors.black.withOpacity(.5),fontWeight: FontWeight.w400,fontSize: height*.014),),
                         ],
                       ),
                       Row(
                         children: [
                           Text('${getLang(context, "total price")} : ',style: TextStyle(color: Colors.green.withOpacity(1),fontWeight: FontWeight.bold,fontSize: height*.014),),
                           Text(cart.totalPrice.toString(),style: TextStyle(color: Colors.black.withOpacity(.7),fontWeight: FontWeight.bold,fontSize: height*.014),),
                         ],
                       ),
                     ],
                   ),
                 ),

                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EbottonI(
                            onpressed: ()async{
                              MyIndicator().loading(context);
                              await Cart().deleteCart(cartId: cart.id!);
                              await getMyCarts();
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.delete,size: height*.018,color: Colors.red.withOpacity(.7)),
                          elevation: 1,
                          borderRadius: 10,
                          overColor: Colors.red,
                          padding: height*.01,
                          backgroundcolor: Colors.white,
                          alignmentt: Alignment.center,
                          shadowcolor: Colors.black,
                          borderColor: Colors.black.withOpacity(.1),
                            child: Text('${getLang(context, "delete")}',style: TextStyle(fontSize: height*.012,color: Colors.black.withOpacity(.7))),



                        ),
                       cart.status!=selling?

                        Text('${getLang(context, "ordered")}',style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold),):
                       Ebotton(
                            onpressed: ()async{

                              await showDialog(context: context, builder: (BuildContext context)=>
                              Dialog(
                                elevation: 5,
                                alignment: Alignment.center,
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                                ),
                                child: SizedBox(
                                  height: height*.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            EbottonI(
                                              onpressed: ()async{
                                                if(_myKey.currentState!.validate()){
                                                  MyIndicator().loading(context);
                                                  _myKey.currentState!.save();
                                                  await Cart().editCart(cartId: cart.id!, map:
                                                  {
                                                    cartPhone:phone,
                                                    cartStatus:ordered
                                                  }
                                                  );
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                }
                                                else{return;}


                                              },
                                              icon: Icon(Icons.done,color: Colors.white,size: height*.018 ),
                                              elevation: 1,
                                              borderRadius:20,
                                              overColor: Colors.orange,
                                              padding: 8,
                                              backgroundcolor: Theme.of(context).appBarTheme.backgroundColor!,
                                              shadowcolor: Colors.black,
                                              child: Text('${getLang(context, "done")}',style: TextStyle(color: Colors.white,fontSize: height*.018)),


                                            ),
                                            EbottonI(
                                              onpressed: ()async{
                                            Navigator.pop(context);

                                              },
                                              icon:  Icon(Icons.close,color: Colors.white,size: height*.018),
                                              elevation: 1,
                                              borderRadius:20,
                                              overColor: Colors.orange,
                                              padding: 10,
                                              backgroundcolor: Theme.of(context).appBarTheme.backgroundColor!,
                                              shadowcolor: Colors.black,
                                              child:  Text('${getLang(context, "close")}',style: TextStyle(color: Colors.white,fontSize: height*.018)),


                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              )).then((value) =>  getMyCarts());

                            //  await Cart().editCart(cartId: cart.id!, map: {cartStatus:ordered});




                            },
                           // icon: Icon(Icons.money,size: height*.018,color: Colors.green.withOpacity(.7)),
                          elevation: 1,
                          borderRadius: 10,
                          overColor: Colors.orangeAccent,
                          padding: height*.01,
                          backgroundcolor:cart.isAvailable!? Theme.of(context).appBarTheme.backgroundColor!:Colors.grey,
                          alignmentt: Alignment.center,
                          shadowcolor: Colors.black,
                          borderColor: Colors.black.withOpacity(.1),
                            child: Text('${getLang(context, "order")}',style: TextStyle(fontSize: height*.012,color: Colors.white.withOpacity(1))),



                        ),
                      ],
                    ),
                  )
                ],
              ),

            )



        )





    );


  }







  _waitingCartItem({required double height,required Cart cart}){
    double price=cart.codePrice??cart.product![productPrice];
    double totalPrice=price*cart.quantity!.toDouble();
    return InkWell(
      onTap: (){

        if( cart.isAvailable!){ Navigator.push(context, MaterialPageRoute(builder: (context) =>  CartDetailsScreen(cart: cart),));}



      },
        child: Material(
          color: Colors.white.withOpacity(.8),
            elevation: 5,
            borderRadius: BorderRadius.circular(20),



            child: Container(
             // color: Colors.white,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Center(
                    child:  cart.isAvailable==false?

                    Container(
                      height: height*.12,width: height*.12,
                      alignment: Alignment.center,
                      child:Text('${getLang(context, "not available")}')



                    ):
                    Container(
                      height: height*.12,width: height*.12,
                      decoration: BoxDecoration(
                          color: Colors.white,
                        image: DecorationImage(image: CachedNetworkImageProvider(cart.product![productImageUrl]),fit: BoxFit.fill),
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft:  Radius.circular(10),),
                      //  boxShadow:  [BoxShadow(color: Colors.black.withOpacity(.1),blurRadius: .1,spreadRadius: 3)],




                      ),
                    ),
                  ),
                  Center(child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*.01),
                    child: Text(cart.product![productName],style: TextStyle(fontSize: height*.018,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.visible),
                  )),
                 Padding(
                   padding:   EdgeInsets.symmetric(vertical:  height*.01),
                   child: Center(child: Text('${getLang(context, "waiting price")}',style: TextStyle(color: Colors.black.withOpacity(.5),fontWeight: FontWeight.w400,fontSize: height*.018),)),
                 ),

                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*.01),
                    child: Center(
                      child: EbottonI(
                          onpressed: ()async{
                            MyIndicator().loading(context);
                            await Cart().deleteCart(cartId: cart.id!);
                            await getMyCarts();
                            Navigator.pop(context);

                          },
                          icon: Icon(Icons.delete,size: height*.018,color: Colors.red.withOpacity(.7)),
                        elevation: 1,
                        borderRadius: 10,
                        overColor: Colors.red,
                        padding: height*.01,
                        backgroundcolor: Colors.white,
                        alignmentt: Alignment.center,
                        shadowcolor: Colors.black,
                        borderColor: Colors.black.withOpacity(.1),
                          child: Text('${getLang(context, "delete")}',style: TextStyle(fontSize: height*.012,color: Colors.black.withOpacity(.7))),



                      ),
                    ),
                  )
                ],
              ),

            )



        )





    );
  }



}
