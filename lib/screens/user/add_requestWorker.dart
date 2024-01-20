import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/cities.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/my_flush.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/constants/request_worker.dart';
import 'package:urban/constants/worker.dart';
import 'package:urban/providers/fireProvider.dart';

import '../../providers/lang_provider.dart';
import 'payment_screen.dart';

class AddRequestWorker extends StatefulWidget {
  static const String route='AddRequestWorker/';
  const AddRequestWorker({Key? key}) : super(key: key);

  @override
  State<AddRequestWorker> createState() => _AddRequestWorkerState();
}

class _AddRequestWorkerState extends State<AddRequestWorker> {
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
    return Scaffold(
      appBar: AppBar(title: Text('${getLang(context, "request worker")}')),
      body: Center(
        child: SingleChildScrollView(

          child: Column(
            children: [
              SizedBox(height:height*.02,),
              bigImage(height: height),
              SizedBox(height:height*.02,),
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
                            elevation: 2,
                            shadowColor: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            child: DropdownButton(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 5,
                              alignment: Alignment.center,
                              underline: const SizedBox(),
                              dropdownColor: Theme.of(context).appBarTheme.backgroundColor,
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
                            elevation: 2,
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
                      ) ;
                    }
                ),
              ),

              SizedBox(height:height*.02,),

              Form(
                key: _myKey,
                child: Material(
                  color: Colors.white,
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  child: PhoneTextField(
                    sFuntion: (s){setState(() {phone=s;});return null;},
                    vFuntion: (v){if(v!.isEmpty){return'enter your phone';}return null;},
                    icon: const Icon(Icons.phone_iphone),
                    input: TextInputType.name,
                    value: Provider.of<FireProvider>(context,listen: false).myUserInfo!.phone,
                  ),
                ),
              ),
              SizedBox(height:height*.02,),

              Material(
                color: Theme.of(context).appBarTheme.backgroundColor,
                elevation: 2,
                borderRadius: BorderRadius.circular(10),
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 20,

                  alignment: Alignment.center,
                  underline: const SizedBox(),
                  dropdownColor:Theme.of(context).appBarTheme.backgroundColor,
                  iconEnabledColor: Colors.white,
                  items: workersCategories .map((e) =>
                      DropdownMenuItem(value: e,child: SizedBox(
                        width: width*.5,
                        child: Text('${getLang(context, e)}',style: const TextStyle(fontSize: 12,color: Colors.white),textAlign: TextAlign.center),

                      ),)).toList(),

                  value:myWorkerCategory,

                  onChanged: (Object? value) {



                    setState(() {
                      myWorkerCategory=value.toString();
                    });



                  } ,




                ),
              ),
              SizedBox(height:height*.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EbottonI(
                    icon: Icon(myDate==null?Icons.calendar_month:Icons.done_all_outlined,color: Colors.white),

                    padding: height*.02,
                    borderRadius: 20,
                    backgroundcolor:myDate==null? Colors.deepOrange.withOpacity(.5):Colors.green,
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
                    child: Text(myDate==null?'date':DateFormat.yMd().format(myDate!),style: TextStyle(color: myDate==null?Colors.black:Colors.white)),
                  ),
                  EbottonI(
                    icon: Icon(myTime==null?Icons.calendar_month:Icons.done_all_outlined,color: Colors.white),

                    padding: height*.02,
                    borderRadius: 20,
                    backgroundcolor:myTime==null? Colors.deepOrange.withOpacity(.5):Colors.green,
                    elevation: 5,
                    shadowcolor: Colors.black,


                    onpressed: ()async{

                      TimeOfDay? myTime1=await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        initialEntryMode: TimePickerEntryMode.dial,





                        // currentDate: myDate
                      );
                      setState(() {
                        myTime=myTime1;
                      });

                      print(myTime!.format(context));

                    },
                    child: Text(myTime==null?'time':myTime!.format(context).toString(),style: TextStyle(color: myTime==null?Colors.black:Colors.white)),
                  ),
                ],
              ),
              SizedBox(height:height*.02,),
              _saveButton(height: height,context: context),
            ],
          ),
        ),
      ),
    );
  }
  final GlobalKey<FormState> _myKey=GlobalKey<FormState>();
  String? myGovernorateId;

  String? myCityId;
  String? phone;
  String?myWorkerCategory=workersCategories[0];
  File? imageFile;
  XFile? picked;
  DateTime? myDate;
  TimeOfDay? myTime;



  Widget bigImage({required double height}){
    if (imageFile==null){
      return Material(
        elevation: 3,
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
            height: height*.2,
            width: height*.2,


            child:
            Center(
              child: EbottonI(
                icon: Icon(Icons.photo,color:Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.5),size: height*.02,),
                elevation: 5,
                shadowcolor: Theme.of(context).canvasColor             ,
                backgroundcolor: Colors.white,
                alignmentt: Alignment.center,
                borderRadius: 10,
                padding: height*.015,
                onpressed: ()async{
                  var fire=Provider.of<FireProvider>(context,listen: false);

                  await fire.addImage();
                  setState(() {
                    imageFile=fire.imageFile;
                    picked=fire.picked;


                  });
                },
                child: Text('إختر صوره',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize:height*.013 )),
              ),
            )
          //Image(image: AssetImage('assets/images/cover.png'),width: 100,height: 100,),

        ),
      );}
    else {return
      InkWell(
        onTap: ()async{
          var fire=Provider.of<FireProvider>(context,listen: false);

          await fire.addImage();
          setState(() {
            imageFile=fire.imageFile;
            picked=fire.picked;


          });
        },
        child: Stack(

          children: [
            Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              elevation: 10,
              child: Container(
                height:  height*.2,width:  height*.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: FileImage(imageFile!,),
                        fit: BoxFit. contain
                    )
                ),
              ),
            ),
            Positioned(
              bottom: 0,right: 0,
              child: Container(
                width: height*.08,
                height: height*.03,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.8),
                    borderRadius: const BorderRadius.only(
                      topLeft:  Radius.circular(10),
                      // topRight:  Radius.circular(10),

                    )
                ),
                child: Text('تغيير الصوره',style: TextStyle(color:Colors.white,fontSize: height*.014),textAlign: TextAlign.center),


              ),

            )
          ],
        ),
      );}
  }

  Widget _saveButton({required BuildContext context,required double height}){
    return InkWell(
        onTap: ()async{_save(context: context,);},

        child: Container(
          width: height*.25,
          height: height*.08,
          decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).canvasColor,width: .3),
              boxShadow: [BoxShadow(color: Theme.of(context).canvasColor,blurRadius: 5,spreadRadius: .1)]

          ),
          alignment: Alignment.center,
          child:  Text('${getLang(context, "request worker")}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: height*.018),
              ),


        )
    );
  }






  _save({required BuildContext context})async{
    var fire=Provider.of<FireProvider>(context,listen: false);


    if (myDate==null||myTime==null) {

      MyFlush().showFlush(context: context, text: 'select date');
      return;}

    if(_myKey.currentState!.validate()){


      MyIndicator().loading(context);
      _myKey.currentState!.save();
      debugPrint ('save done');





        String id= Random().nextInt(100000).toString();


        RequestWorker requestWorker=RequestWorker(
          id: id,

          phone: phone,
          category: myWorkerCategory,
          cityId: myCityId,
          date: DateFormat.yMMMd().format(myDate!),

          imageUrl: fire.imageUrl,
          imageLoc: fire.photoLoc,
          userId: Provider.of<FireProvider>(context,listen: false).myId!,
          status: requesting,
          time: myTime!.format(context),
          worker: null,
          details: null,

        );

        await RequestWorker().addRequest(requestWorker:  requestWorker);
        await fire.clearImages();
        Navigator.pop(context);
        Navigator.pop(context);
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen(category: widget.category,section: widget.section,company: widget.company,kind: widget.kind),));
        MyFlush().showorderedDoneFlush(context: context);











    }
    else{return;}


  }
}
