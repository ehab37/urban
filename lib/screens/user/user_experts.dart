import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/message_info.dart';
import 'package:urban/constants/my_flush.dart';
import 'package:urban/providers/fireProvider.dart';

import '../image_view_screen.dart';
class UserExpertsScreen extends StatefulWidget {
  static const String route='UserExpertsScreen/';
  const UserExpertsScreen({Key? key}) : super(key: key);

  @override
  State<UserExpertsScreen> createState() => _UserExpertsScreenState();
}

class _UserExpertsScreenState extends State<UserExpertsScreen> {

  TextEditingController textController=TextEditingController();
 List<Message> messages=[];


  userMakeChatSeen()async{
    var myId = Provider.of<FireProvider>(context, listen: false).myId;
    await Message().userMakeChatSeen(myUserId:myId! , );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userMakeChatSeen();

  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }


    var fire=Provider.of<FireProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('${getLang(context, "experts")}'),
      ),


      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                primary: true,
                reverse: true,
                child: StreamBuilder< QuerySnapshot<Map<String, dynamic>>>(
                  stream:  Message().streamUserGetMessages( myUserId: fire.myId!),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      QuerySnapshot<Map<String, dynamic>>? myStream = snapshot.data;

                      messages.clear();
                      var docs = myStream!.docs;
                      for (var doc in docs) {
                        var data = doc.data();
                        messages.add(Message.fromJson(data));
                        // messages.sort((a,b)=>a.date!.compareTo(b.date! ));
                      }
                    }

                    return Column(
                          children: messages.map((e) {
                            if(e.sender=='user'){return userMessage(message: e,height: height);}
                            else{return adminMessage(message: e,height: height);}

                          }

                          ).toList(),

                        );
                  }
                ),
              ),
            ),

            Material(
              elevation: 5,
              color: Colors.teal.shade50,

              child: Container(
                color: Colors.teal.shade50,
                height: height*.2,
                width: width,
                child: Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: height*.15,
                        width: width*.8,
                        child: Form(
                          key: _myKey,
                          child: MyMessageTextField(
                            sFuntion: (s){setState(() {message=s!;});return null;},
                            vFuntion: (v){if(v!.isEmpty){return'';}return null;},
                            controller: textController,

                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [


                        bigImage(height: height,width:width) ,
                        InkWell(
                          onTap: ()async{

                            var fire=Provider.of<FireProvider>(context,listen: false);

                            if(_myKey.currentState!.validate()){


                             // MyIndicator().loading(context);
                              _myKey.currentState!.save();
                              debugPrint ('save done');





                              textController.clear();

                              if(picked!=null){
                                if(! await fire.uploadImage(imageFile: imageFile!,picked: picked!)) {
                                  Navigator.pop(context);
                                  MyFlush().showFlush(context: context, text: 'wrong try again');
                                  return;}

                              }





                                  String id= Random().nextInt(100000).toString();
                              if(await Message().userSendMessage(Message(
                                text: message,
                                sender: 'user',
                                imageUrl: fire.imageUrl,
                                time:FieldValue.serverTimestamp(),
                                userId: fire.myId,
                                id: id
                              ))){


                                await fire.clearImages();
                                setState(() {
                                  picked=null;
                                  imageFile=null;
                                });



                              }
                              else{
                                MyFlush().showFlush(context: context, text: 'try again');
                              }





                                 













                            }
                            else{return;}

                          },
                          child: Material(
                            elevation: 3,
                            color: Theme.of(context).appBarTheme.backgroundColor,
                            borderRadius: BorderRadius.circular(5),
                            child:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.send,color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

 final GlobalKey<FormState> _myKey=GlobalKey<FormState>();
  String? message;
 File? imageFile;
 XFile? picked;



 Widget bigImage({required double height,required double width}){
   if (imageFile==null){
     return  InkWell(
         onTap: ()async{
           var fire=Provider.of<FireProvider>(context,listen: false);

           await fire.addImage();
           setState(() {
             imageFile=fire.imageFile;
             picked=fire.picked;


           });
         },
         child: Material(
             elevation: 3,
             color:Theme.of(context).appBarTheme.backgroundColor,
             borderRadius: BorderRadius.circular(5),

             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Icon(Icons.attachment_outlined,color: Theme.of(context).primaryColor,),
             )));}
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
       child: Material(
         borderRadius: BorderRadius.circular(10),
         color: Colors.white,
         elevation: 10,
         child: Container(
           height:  height*.08,width:  width*.15,
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
     );}
 }
 Widget adminMessage({required Message message,required double height}){
    return
      Padding(
        padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 50,right: 8),
        child: Container(
          alignment: Alignment.centerRight,
          child: Material(
            elevation: 20,
            color: Colors.teal.shade100,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft:  Radius.circular(20),
              topLeft:  Radius.circular(20),
            ),
            child: message.imageUrl==null?
            Container(
              padding: const EdgeInsets.all(12),
              child: Text(message.text!,style: const TextStyle(color: Colors.black)),
            ):Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPhoto(url: message.imageUrl!),));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      height: height*.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                         borderRadius: BorderRadius.circular(10)
                         //image: DecorationImage(image: CachedNetworkImageProvider(message.imageUrl!),fit: BoxFit.contain)
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Text(message.text!,style: TextStyle(color: Theme.of(context).canvasColor)),
                )

              ],
            ),
          ),
        ),
      )
      ;
  }
 Widget userMessage({required Message message,required double height}){
    return
      Padding(
        padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 8,right: 50),
        child: Container(
          alignment: Alignment.centerLeft,
          child: Material(
            elevation: 5,
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
             // bottomLeft:  Radius.circular(20),
              topLeft:  Radius.circular(20),
              topRight:   Radius.circular(20),
            ),
            child:  message.imageUrl==null?
            Container(
              padding: const EdgeInsets.all(12),
              child: Text(message.text!,style: TextStyle(color: Theme.of(context).canvasColor)),
            ):Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPhoto(url: message.imageUrl!),));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      height: height*.1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(image: CachedNetworkImageProvider(message.imageUrl!),fit: BoxFit.contain)
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Text(message.text!,style: TextStyle(color: Theme.of(context).canvasColor)),
                )

              ],
            ),
          ),
        ),
      )
      ;
  }
}



class MyMessageTextField extends StatelessWidget {

  double borderWidth = 0;
  Color borderColor = Colors.white.withOpacity(.0);
  Color fillColor = Colors.white.withOpacity(.0);
  double borderRadus = 5;









  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;
  final   TextEditingController  controller;



  MyMessageTextField({Key? key,



    required this.vFuntion,
    required this.sFuntion,
    required this.controller






  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }

    OutlineInputBorder outlineInputBorder= OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide:  BorderSide(color: Theme.of(context).appBarTheme.backgroundColor!, width: 1),
    );
    return TextFormField(

      obscureText: false,
      textInputAction: TextInputAction.newline,

      keyboardType: TextInputType.multiline,
      enabled: true,
      // minLines: 14,
      maxLines: 15,
     // maxLength: 1000,

      validator:vFuntion ,
      onSaved:sFuntion ,
      textDirection:TextDirection.ltr ,
      scrollController: ScrollController(),

      selectionControls:CupertinoTextSelectionControls(),
      controller: controller,







      style: TextStyle(
        color:
        Theme.of(context).textTheme.bodySmall!.color
        ,
        fontSize:height*.02 ,
        leadingDistribution: TextLeadingDistribution.even,
        textBaseline: TextBaseline.alphabetic,


      ),
      decoration: InputDecoration(
        // fillColor: Theme.of(context).primaryColor,
         // counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: height*.015),
          filled: true,
          isCollapsed: true,
          enabled: true,
          contentPadding:  EdgeInsets.all(height*.025),
          focusColor: Colors.yellow,
          hoverColor: Colors.red,
         // labelText:'details' ,
          labelStyle: TextStyle(color: Colors.black,fontSize: height*.025),
        //  floatingLabelBehavior: FloatingLabelBehavior.always,











          enabledBorder: outlineInputBorder,
          disabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          errorBorder: outlineInputBorder,
          focusedErrorBorder: outlineInputBorder
      ),










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