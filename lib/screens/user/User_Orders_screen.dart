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


import '../order_details_screen.dart';
class UserOrdersScreen extends StatefulWidget {
  static const String route ='UserOrdersScreen/';
  const UserOrdersScreen({Key? key}) : super(key: key);

  @override
  State<UserOrdersScreen> createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {


  List<Cart>?myOrderedEquipmentsCarts;
  List<Cart>?myOrderingProductsCarts;
  List<Cart>?myOrderedProductsCarts;




  getMyCarts()async{
    String? myId=Provider.of<FireProvider>(context,listen: false).myId;
    try{
      List<Cart> myCarts1=await Cart().getMyCarts(myUserId: myId!);


      setState(() {

        //myOrderingProductsCarts=myCarts1.where((element) => element.status==ordering&&element.equip==null).toList();
        myOrderedProductsCarts=myCarts1.where((element) => element.status==ordered&&element.equip==null).toList();
        myOrderedEquipmentsCarts=myCarts1.where((element) =>element.equip!=null&&element.status==ordered).toList();



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
    return




      DefaultTabController(
        length: 2,
        child:  Scaffold(
          appBar: AppBar(
            title: Text('${getLang(context, "orders")}'),
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
                  child: Text('${getLang(context, "products")}',style: TextStyle(color: Theme.of(context).primaryColor)),


                ),

                Tab(height: 70,

                  icon: Icon(Icons.car_rental,color: Theme.of(context).primaryColor.withOpacity(.5)),
                  child: Text('${getLang(context, "Equipments")}',style: TextStyle(color: Theme.of(context).primaryColor)),),
              ],
            ),
          ),

          body:  TabBarView(

            children: [
              myOrderedProductsCarts==null?myShimmer(context):  CustomScrollView(
                slivers: [

                  SliverAppBar(
                    backgroundColor: Colors.teal.withOpacity(0),
                    floating: true,
                    flexibleSpace: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('${getLang(context, "we will contact with u")}',style: TextStyle(
                                color: Colors.white,
                                fontSize: height*.018
                            ),),
                          ),
                        ),
                        const SizedBox(),
                      ],
                    ),
                    leading: const SizedBox(),
                  ),

                  SliverPadding(
                    padding:EdgeInsets.all(height*.01) ,
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                            (context,index) {
                          return
                            _sellingCartItem(
                                height: height, cart: myOrderedProductsCarts![index]);


                        },
                        childCount: myOrderedProductsCarts!.length,


                      ),

                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:.6,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 30,
                        // mainAxisExtent: 400
                      ),



                    ),
                  ),
                ],

              ),
              myOrderedEquipmentsCarts==null?myShimmer(context): CustomScrollView(
                slivers: [

                  SliverAppBar(
                    backgroundColor: Colors.teal.withOpacity(0),
                    floating: true,
                    flexibleSpace: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('${getLang(context, "we will contact with u")}',style: TextStyle(
                                color: Colors.white,
                                fontSize: height*.018
                            ),),
                          ),
                        ),
                        const SizedBox(),
                      ],
                    ),
                    leading: const SizedBox(),
                  ),

                  SliverPadding(
                    padding:EdgeInsets.all(height*.01) ,
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                            (context,index) {
                          return
                            _equipmentCartItem(
                                height: height, cart: myOrderedEquipmentsCarts![index]);


                        },
                        childCount: myOrderedEquipmentsCarts!.length,


                      ),

                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:.6,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 30,
                        // mainAxisExtent: 400
                      ),



                    ),
                  ),
                ],

              ),
            ],
          ),

        ),
      );
  }


  _sellingCartItem({required double height,required Cart cart}){
    TextStyle nameStyle= TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.7),fontWeight: FontWeight.w400,fontSize: height*.012);
    TextStyle valueStyle= TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.7),fontWeight: FontWeight.w400,fontSize: height*.012);
    double price=cart.codePrice??cart.product![productPrice];

    return InkWell(
        onTap: (){
          if(cart.isAvailable!){ Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrderDetailsScreen(cart: cart),));}

        },
        child: Material(
            color: Theme.of(context).primaryColor,
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black,



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
                    child: Text(cart.product![productName],style: TextStyle(fontSize: height*.018,fontWeight: FontWeight.bold,color:Theme.of(context).textTheme.bodySmall!.color),maxLines: 1,overflow: TextOverflow.visible),
                  )),
                  Material(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(0),
                    elevation: 3,
                    child: Padding(
                      padding:   EdgeInsets.symmetric(horizontal: height*.01,vertical: height*.01),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('${getLang(context, "price")} : ',style: nameStyle,),
                              Text('$price',style: valueStyle)
                            ],
                          ),
                          Row(
                            children: [
                              Text('${getLang(context, "quantity")} : ',style:nameStyle,),
                              Text('${cart.quantity}',style:valueStyle)
                            ],
                          ),
                          cart.colorCode==null?const SizedBox():  Row(
                            children: [
                              Text('${getLang(context, "color code")} : ',style: nameStyle,),
                              Text('${cart.colorCode}',style: valueStyle)
                            ],
                          ),
                          Row(
                            children: [
                              Text('${getLang(context, "total price")} : ',style: TextStyle(color: Colors.green.withOpacity(1),fontWeight: FontWeight.bold,fontSize: height*.012),),
                              Text(

                                cart.totalPrice.toString()



                                ,style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontWeight: FontWeight.w400,fontSize: height*.018),),
                            ],
                          ),
                        ],
                      ),
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

                            await Cart().editCart(cartId: cart.id!, map: {cartStatus:selling,});

                            await getMyCarts();
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.cancel,size: height*.018,color: Colors.red.withOpacity(.7)),
                          elevation: 5,
                          borderRadius: 10,
                          overColor: Colors.red,
                          padding: height*.01,
                          backgroundcolor: Colors.white,
                          alignmentt: Alignment.center,
                          shadowcolor: Colors.black,
                          borderColor: Colors.black.withOpacity(.1),
                          child: Text('${getLang(context, "cancel")}',style: TextStyle(fontSize: height*.016,color: Colors.black.withOpacity(.7))),



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
  _equipmentCartItem({required double height,required Cart cart}){
    TextStyle nameStyle= TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.7),fontWeight: FontWeight.w400,fontSize: height*.012);
    TextStyle valueStyle= TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.7),fontWeight: FontWeight.w400,fontSize: height*.012);
    Equip equip=Equip.fromJson(cart.equip);


    bool isOrdered=false;
    return InkWell(
        onTap: (){
          if(cart.isAvailable!){  Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrderDetailsScreen(cart: cart),));}

        },
        child: Material(
            color: Colors.white,
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
                      child: const Text('not available'),



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
                  Material(
                    elevation: 2,
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding:   EdgeInsets.symmetric(horizontal: height*.01,vertical: height*.01),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('${getLang(context, "price per day")} : ',style: nameStyle,),
                              Text('${equip.pricePerDay}',style:nameStyle,),
                            ],
                          ),
                          Row(
                            children: [
                              Text('${getLang(context, "days")} : ',style:nameStyle,),
                              Text('${cart.days}',style:nameStyle,),
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
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EbottonI(
                          onpressed: ()async{
                            MyIndicator().loading(context);

                            await Cart().editCart(cartId: cart.id!, map: {cartStatus:selling});

                            await getMyCarts();
                            Navigator.pop(context);
                           // MyFlush().showSuccessFlush(context: context, text: 'تم إلغاء الطلب ');
                          },
                          icon: Icon(Icons.cancel,size: height*.018,color: Colors.red.withOpacity(.7)),
                          elevation: 5,
                          borderRadius: 10,
                          overColor: Colors.red,
                          padding: height*.01,
                          backgroundcolor: Colors.white,
                          alignmentt: Alignment.center,
                          shadowcolor: Colors.black,
                          borderColor: Colors.black.withOpacity(.1),
                          child: Text('cancel',style: TextStyle(fontSize: height*.016,color: Colors.black.withOpacity(.7))),



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
}
