
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/equipment.dart';
import 'package:urban/constants/images.dart';
import 'package:urban/constants/my_flush.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/providers/fireProvider.dart';
import 'package:urban/screens/equipments_screens/add_equipment.dart';
import 'package:urban/screens/material_screens/Company_Details_Screen.dart';

import '../../components/app_local.dart';
import 'equipments_details.dart';
class EquipmentsViewScreen extends StatefulWidget {
  static const String route ='EquipmentsViewScreen/';
  final String kind;
  final String company;
  const EquipmentsViewScreen({Key? key, required this.kind, required this.company}) : super(key: key);

  @override
  State<EquipmentsViewScreen> createState() => _EquipmentsViewScreenState();
}

class _EquipmentsViewScreenState extends State<EquipmentsViewScreen> {

  List<Equip>?myEquips;

  getEquips()async{
    var myEquips1=await Equip().getEquips(company: widget.company, kind: widget.kind);
    setState(() {
      myEquips=myEquips1;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEquips();
  }

  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }

    bool isAdmin=Provider.of<FireProvider>(context).isAdmin!;
    return  Scaffold(
      appBar: AppBar(title: Text('${getLang(context, widget.kind)}>>${widget.company}'),

        actions: [
          isAdmin? Padding(
            padding: const EdgeInsets.symmetric(horizontal:  8.0),
            child: InkWell(


              onTap: ()async{
                await  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    AddEquipmentScreen(kind: widget.kind, company: widget.company),)).then((value) =>getEquips() );


              },
              child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  elevation: 3,
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(Icons.add),
                  )),
            ),
          ):const SizedBox()
        ],

      ),




      body: myEquips==null?myShimmer(context):

      Stack(
        children: [
          CustomScrollView(
            slivers: [

              SliverAppBar(
                backgroundColor: Colors.white.withOpacity(0),
                floating: true,
                elevation: 10,
                toolbarHeight: height*.1,
                flexibleSpace: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Material(
                      elevation: 5,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyDetailsScreen(company: widget.company),));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: height*.1,
                              width: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage(images[widget.company]!),fit:BoxFit.fill
                                  )
                              ),






                            ),
                          )
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
                leading: const SizedBox(),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,

                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: .5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return _equipmentItem(height: height,equip: myEquips![index],kind: widget.kind,width: width,isAdmin: isAdmin);


                    },
                    childCount: myEquips!.length,
                  ),
                ),
              )
            ],

          ),
          Provider.of<FireProvider>(context,listen: false).isAdmin!?const NewFloatingAdmin(): const NewFloatingUser()
        ],
      ),









    );
  }

_text({required String text}){
  double height=MediaQuery.of(context).size.height;
  double width=MediaQuery.of(context).size.width;
  if(MediaQuery.of(context).orientation==Orientation.landscape){
    height=MediaQuery.of(context).size.width;
    width=MediaQuery.of(context).size.height;
  }
    return
      SizedBox(
        width: width*.18,
        child: Text(text,style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontWeight: FontWeight.w400,fontSize: height*.015),

          overflow: TextOverflow.clip,maxLines: 1,),
      );
}
_textName({required String text}){
  double height=MediaQuery.of(context).size.height;
  double width=MediaQuery.of(context).size.width;
  if(MediaQuery.of(context).orientation==Orientation.landscape){
    height=MediaQuery.of(context).size.width;
    width=MediaQuery.of(context).size.height;
  }
    return
      SizedBox(
        width: width*.18,
        child: Text(text,style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontWeight: FontWeight.w400,fontSize: height*.015),

          overflow: TextOverflow.clip,maxLines: 1,),
      );
}
  _equipmentItem({required double height,required Equip equip,required String kind,required double width,required bool isAdmin}){

    return InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => EquipmentDetails(equip:equip),));
        },
        child: Material(
            color:  Theme.of(context).primaryColor,
            elevation: 5,
            borderRadius: BorderRadius.circular(20),



            child: Container(
              // color: Colors.white,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Center(
                    child: Container(
                      height: height*.14,width: width*.35,
                      decoration: BoxDecoration(
                       // color: Colors.white,
                        image: DecorationImage(image: CachedNetworkImageProvider(equip.imageUrl!),fit: BoxFit.fill),
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft:  Radius.circular(10),),
                        //  boxShadow:  [BoxShadow(color: Colors.black.withOpacity(.1),blurRadius: .1,spreadRadius: 3)],




                      ),
                    ),
                  ),
                  Center(child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*.02),
                    child: SizedBox(
                      width: width*.4,
                        child: Center(child: Text(equip.name!,style: TextStyle(fontSize: height*.022,fontWeight: FontWeight.normal,),maxLines: 1,overflow: TextOverflow.clip),)),
                  )),
                  Container(

                    color: Theme.of(context).appBarTheme.backgroundColor!.withOpacity(.2),
                    
                    child: Padding(
                      padding:   EdgeInsets.symmetric(horizontal: height*.01,vertical: height*.01),
                      child: Column(
                        children: [
                          (kind==mixerTruck||kind==loader||kind==excavator||kind==mobileCrane)?  Row(
                            children: [
                              _textName(text: '${getLang(context, "capacity")} : '),
                              _text(text:'${equip.capacity}' ),

                            ],
                          ):const SizedBox(),//capacity
                         kind==trailerConcretePump? Row(
                            children: [
                              _textName(text: '${getLang(context, "pressure")} : ',
                               ),
                              _text(text:'${equip.pressure}' ),

                            ],
                          ):const SizedBox(),//pressure
                          kind==mobilePlacingBoom?  Row(
                            children: [
                              _textName(text: '${getLang(context, "length Of Boom")} : ',),
                              _text(text:'${equip.lengthOfBoom}' ),

                            ],
                          ):const SizedBox(),//lengthOfBoom
                          kind==loader||kind==bulldozer? Row(
                            children: [
                              _textName(text: '${getLang(context, "engine")} : ',),
                              _text(text:'${equip.engine}' ),
                            ],
                          ):const SizedBox(),//engine
                          kind==bulldozer||kind==excavator? Row(
                            children: [
                              _textName(text: '${getLang(context, "weight")} : ',),
                              _text(text:'${equip.weight}' ),
                            ],
                          ):const SizedBox(),//weight
                         kind==mixerTruck||kind==mobileCrane||kind==truckPump? Row(
                            children: [
                              _textName(text: '${getLang(context, "brand")} : ',),
                              _text(text:'${equip.brand}' ),
                            ],
                          ):const SizedBox(),//brand




                          kind==trailerConcretePump||kind==truckPump?  Row(
                            children: [
                              _textName(text: '${getLang(context, "output")} : ',),
                              _text(text:'${equip.output}' ),
                            ],
                          ):const SizedBox(),//output
                         kind==mobilePlacingBoom? Row(
                            children: [
                              _textName(text: '${getLang(context, "number Of Boom")} : ',),
                              _text(text:'${equip.numberOfBoom}' ),
                            ],
                          ):const SizedBox(),//numberOfBoom
                          kind==trailerConcretePump||kind==bulldozer||kind==excavator?   Row(
                            children: [
                              _textName(text: '${getLang(context, "power")} : ',),
                              _text(text:'${equip.power}' ),
                            ],
                          ):const SizedBox(),//power
                          kind==truckPump? Row(
                            children: [
                              _textName(text: '${getLang(context, "reach")} : ',),
                              _text(text:'${equip.reach}' ),
                            ],
                          ):const SizedBox(),//reach



                        kind==loader?  Row(
                            children: [
                              _textName(text: '${getLang(context, "load")} : ',),
                              _text(text:'${equip.load}' ),
                            ],
                          ):const SizedBox(),//load
                         kind==mobileCrane? Row(
                            children: [
                                  _textName(text: '${getLang(context, "extended Boom")} : ',),
                              _text(text:'${equip.extendedBoom}' ),
                            ],
                          ):const SizedBox(),//extendedBoom







                          Row(
                            children: [
                              Text('${getLang(context, "price per day")} : ',
                                style: TextStyle(color: Colors.black.withOpacity(.7),fontWeight: FontWeight.bold,fontSize: height*.012),),
                              _text(text:'${equip.pricePerDay}' ),
                            ],
                          ),//price
                        ],
                      ),
                    ),
                  ),

                  isAdmin? Center(
                    child: EbottonI(
                        onpressed: ()async{




                           showDialog(context: context, builder: (BuildContext context)=>
                               Dialog(
                                 elevation: 5,
                                 backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                                 child: SizedBox(
                                   height: height*.2,
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: [
                                       Center(child: Text('${getLang(context, "are you sure")}',style: const TextStyle(fontWeight: FontWeight.w900,color: Colors.white ),)),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         children: [
                                           EbottonI(

                                             onpressed: ()async{
                                               MyIndicator().loading(context);
                                               await Equip().removeEquip(equip: equip);
                                               await getEquips();
                                               Navigator.pop(context);
                                               Navigator.pop(context);
                                               MyFlush().showDeletingDoneFlush(context: context);



                                             },
                                             icon: Icon(Icons.delete,color: Colors.red.withOpacity(.5),),
                                             elevation: 3,
                                             borderRadius: 10,
                                             backgroundcolor: Colors.white,
                                             padding: 10,
                                             overColor: Colors.red,
                                             shadowcolor: Colors.black,
                                             child: Text('${getLang(context, "yes")}',style: const TextStyle(color: Colors.black)),




                                           ),
                                           EbottonI(
                                             onpressed: ()async{

                                               Navigator.pop(context);
                                             },
                                             icon: Icon(Icons.keyboard_return,color: Colors.green.withOpacity(.5),),
                                             elevation: 3,
                                             borderRadius: 10,
                                             backgroundcolor: Colors.white,
                                             padding: 10,
                                             overColor: Colors.red,
                                             shadowcolor: Colors.black,
                                             child:  Text('${getLang(context, "no")}',style: const TextStyle(color: Colors.black)),




                                           ),
                                         ],
                                       )
                                     ],
                                   ),
                                 ),
                               )



                           );
                        },
                        icon:  Icon(Icons.delete,color: Colors.red.withOpacity(.5),size: 20),
                      padding: 6,
                      elevation: 5,
                      backgroundcolor: Colors.white,
                      borderRadius: 10,
                      alignmentt: Alignment.center,
                      shadowcolor: Colors.black,
                        child:  Text('${getLang(context, "delete")}',style:  TextStyle(color: Colors.red.withOpacity(.5))),







                    ),
                  ):const SizedBox()



                ],
              ),

            )



        )





    );
  }
}
