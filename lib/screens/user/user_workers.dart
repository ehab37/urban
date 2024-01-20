import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/cities.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/constants/request_worker.dart';
import 'package:urban/constants/worker.dart';
import 'package:urban/providers/fireProvider.dart';
import 'package:urban/providers/lang_provider.dart';

import 'add_requestWorker.dart';
class UserWorkersScreen extends StatefulWidget {
  static const String route='UserWorkersScreen/';
  const UserWorkersScreen({Key? key}) : super(key: key);

  @override
  State<UserWorkersScreen> createState() => _UserWorkersScreenState();
}

class _UserWorkersScreenState extends State<UserWorkersScreen> {

List<RequestWorker>?requestedList;
List<RequestWorker>?requestingList;
 getMyRequests()async{
   List<RequestWorker> myRequests1=await RequestWorker().getMyRequests(myId: Provider.of<FireProvider>(context,listen: false).myId!);
   setState(() {
     requestingList=myRequests1.where((element) => element.status==requesting).toList();
     requestedList=myRequests1.where((element) => element.status==requested).toList();
   });
   print(myRequests1.length);
   print(requestedList!.length);
   print(requestingList!.length);

 }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyRequests();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(title: Text('${getLang(context, "workers")}'),

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
                icon: Icon(Icons.cloud_done_rounded,color: Theme.of(context).primaryColor.withOpacity(.5)),
                child: Text('${getLang(context, "requested")}',style: TextStyle(color: Theme.of(context).primaryColor)),


              ),
              Tab(height: 70,

                icon: Icon(Icons.alarm,color: Theme.of(context).primaryColor.withOpacity(.5)),
                child: Text('${getLang(context, "waiting")}',style: TextStyle(color: Theme.of(context).primaryColor)),),

            ],
          ),

        ),
        body:Stack(
          children: [
            TabBarView(
              children: [
                requestedList==null?myShimmer(context): ListView.builder(
                  itemCount:requestedList!.length ,
                  itemBuilder: (context, index) => requestedItem(height: height,requestWorker:requestedList![index] ),),




                requestingList==null?myShimmer(context): ListView.builder(
                  itemCount:requestingList!.length ,
                  itemBuilder: (context, index) => requestingItem(height: height,requestWorker:requestingList![index] ),),
              ],
            ),
            Positioned(
              bottom: 10,right: width*.4,
              child: InkWell(

                onTap: ()async{

                  await Navigator.pushNamed(context, AddRequestWorker.route).then((value) =>  getMyRequests());

                },
                child: Material(
                  color: Colors.orange.shade900,
                  shadowColor: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 16),
                    child: Center(
                      child: Text('${getLang(context, "request worker")}',style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const NewFloatingUser()
          ],
        ),


      ),
    );
  }

  requestingItem({required double height,required RequestWorker  requestWorker}){
   var city=City().getCity(key: cityId, value: requestWorker.cityId!);
   var nameStyle= TextStyle(fontWeight: FontWeight.bold,fontSize: height*.014);
   var valueStyle= TextStyle(fontWeight: FontWeight.normal,fontSize: height*.014);
   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: Material(
       borderRadius: BorderRadius.circular(10),
       color: Colors.white,
       elevation: 5,
       child: Container(
         height: height*.22,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
           //color: Colors.yellow
         ),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${getLang(context, "category")} : ',style: nameStyle,),
                        Text('${getLang(context, requestWorker.category!)}',style:valueStyle,)
                      ],
                    ),
                    ChangeNotifierProvider(
                      create: (_) =>LangProvider() ,
                      child:  Consumer<LangProvider>(
                          builder: (context,LangProvider lanNoty,child) {
                            return Row(
                              children: [
                                Text('${getLang(context, "city")} : ',style:nameStyle,),
                                Text(lanNoty.isEn?city.en!:city.ar!,style:valueStyle,)
                              ],
                            ) ;
                          }
                      ),
                    ),
                    Row(
                      children: [
                        Text('${getLang(context, "phone")} : ',style: nameStyle,),
                        Text(requestWorker.phone!,style:valueStyle)
                      ],
                    ),
                    Row(
                      children: [
                        Text('${getLang(context, "date")} : ',style: nameStyle,),
                        Text(requestWorker.date!,style:valueStyle)
                      ],
                    ),
                    Row(
                      children: [
                        Text('${getLang(context, "time")} : ',style: nameStyle,),
                        Text(requestWorker.time!,style: valueStyle,)
                      ],
                    ),

                  ],
                ),
              ),
             Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 SizedBox(
                     height: height*.1,
                     child:  Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: Center(child: Text('${getLang(context, "requesting")}')),
                 )),
                 EbottonI(
                   onpressed: ()async{
                     await showDialog(context: context, builder: (BuildContext context){return

                       Dialog(
                         child: SizedBox(
                           height: height*.2,
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Text('${getLang(context, "are you sure")}'),

                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                     Ebotton(
                                       onpressed: ()async{
                                         await RequestWorker().removeRequest(requestId:requestWorker.id! );
                                         Navigator.pop(context);
                                       },
                                       elevation: 5,
                                       borderRadius: 10,
                                       backgroundcolor: Colors.white,
                                       padding: 10,
                                       overColor: Colors.red.withOpacity(.2),
                                       child:Text('${getLang(context, "delete")}',style: const TextStyle(color: Colors.redAccent),),
                                     ),
                                     Ebotton(
                                       onpressed: (){Navigator.pop(context);},
                                       elevation: 5,
                                       borderRadius: 10,
                                       backgroundcolor: Colors.white,
                                       padding: 10,
                                       overColor: Colors.red.withOpacity(.2),
                                       child:Text('${getLang(context, "cancel")}',style: const TextStyle(color: Colors.black),),
                                     ),
                                   ],

                                 )
                               ],
                             ),
                           ),
                         ),

                       );});

                     getMyRequests();

                   },
                   icon: Icon(Icons.delete_forever_sharp,color: Colors.red.withOpacity(.5),),
                   padding: 10,
                   backgroundcolor: Colors.white,
                   borderRadius: 10,
                   elevation: 5,
                   overColor: Colors.red.withOpacity(.2),
                   child: Text('${getLang(context, "delete")}',style: TextStyle(color: Colors.red.withOpacity(.5)),),



                 )
               ],
             )
           ],
         ),


       ),
     ),
   );

  }
  requestedItem({required double height,required RequestWorker  requestWorker}){
   var nameStyle= TextStyle(fontWeight: FontWeight.bold,fontSize: height*.014);
   var valueStyle= TextStyle(fontWeight: FontWeight.normal,fontSize: height*.014);
   var city=City().getCity(key: cityId, value: requestWorker.cityId!);
   Worker worker=Worker.fromJson(requestWorker.worker!);
   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: Material(
       borderRadius: BorderRadius.circular(10),
       color: Colors.white,
       elevation: 5,
       child: Container(
         height: height*.22,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
           //color: Colors.yellow
         ),
         padding: const EdgeInsets.all(8),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${getLang(context, "name")} : ',style: nameStyle,),
                        Text(worker.name!,style: valueStyle,)
                      ],
                    ),
                    Row(
                      children: [
                        Text('${getLang(context, "category")} : ',style:nameStyle,),
                        Text('${getLang(context, requestWorker.category!)}',style: valueStyle,)
                      ],
                    ),
                    ChangeNotifierProvider(
                      create: (_) =>LangProvider() ,
                      child:  Consumer<LangProvider>(
                          builder: (context,LangProvider lanNoty,child) {
                            return Row(
                              children: [
                                Text('${getLang(context, "city")} : ',style:nameStyle,),
                                Text(lanNoty.isEn?city.en!:city.ar!,style:valueStyle,)
                              ],
                            ) ;
                          }
                      ),
                    ),
                    Row(
                      children: [
                        Text('${getLang(context, "worker phone")} : ',style: nameStyle,),
                        Text(worker.phone!,style:valueStyle,)
                      ],
                    ),
                    Row(
                      children: [
                        Text('${getLang(context, "date")} : ',style: nameStyle,),
                        Text(requestWorker.date!,style:valueStyle,)
                      ],
                    ),
                    Row(
                      children: [
                        Text('${getLang(context, "time")} : ',style: nameStyle,),
                        Text(requestWorker.time!,style: valueStyle)
                      ],
                    ),

                  ],
                ),
              ),
             Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Material(
                       elevation: 5,
                       color: Colors.white,
                       type: MaterialType.circle,

                       child:Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: CircleAvatar(
                           backgroundImage: CachedNetworkImageProvider(worker.imageUrl!,),
                           radius: 40,
                         ),
                       )


                   ),
                 ),

                 EbottonI(
                   onpressed: ()async{
                     await showDialog(context: context, builder: (BuildContext context){return

                       Dialog(
                         child: SizedBox(
                           height: height*.2,
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Text('${getLang(context, "are you sure")}'),

                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                     Ebotton(
                                         onpressed: ()async{
                                          await RequestWorker().removeRequest(requestId:requestWorker.id! );
                                           Navigator.pop(context);
                                         },
                                     elevation: 5,
                                       borderRadius: 10,
                                       backgroundcolor: Colors.white,
                                       padding: 10,
                                       overColor: Colors.red.withOpacity(.2),
                                         child:Text('${getLang(context, "delete")}',style: const TextStyle(color: Colors.redAccent),),
                                     ),
                                     Ebotton(
                                         onpressed: (){Navigator.pop(context);},
                                     elevation: 5,
                                       borderRadius: 10,
                                       backgroundcolor: Colors.white,
                                       padding: 10,
                                       overColor: Colors.red.withOpacity(.2),
                                         child:Text('${getLang(context, "cancel")}',style: const TextStyle(color: Colors.black),),
                                     ),
                                   ],

                                 )
                               ],
                             ),
                           ),
                         ),

                       );});

                     getMyRequests();

                   },
                     icon: Icon(Icons.delete_forever_sharp,color: Colors.red.withOpacity(.5),),
                   padding: 10,
                   backgroundcolor: Colors.white,
                   borderRadius: 10,
                   elevation: 5,
                   overColor: Colors.red.withOpacity(.2),
                     child: Text('${getLang(context, "delete")}',style: TextStyle(color: Colors.red.withOpacity(.5)),),



                 )
               ],
             )
           ],
         ),


       ),
     ),
   );

  }

}
