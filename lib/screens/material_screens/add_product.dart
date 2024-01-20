// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/my_flush.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/constants/product.dart';

import '../../constants/constants.dart';
import '../../providers/fireProvider.dart';

class AddProductScreen extends StatefulWidget {
  static const String route='AddProductScreen/';
  final String kind;
  final String company;
  final String category;
  final String section;
  const AddProductScreen({Key? key, required this.kind, required this.company, required this.category, required this.section}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> myKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }

    return Scaffold(
      appBar: AppBar(),

      body: SingleChildScrollView(
        child: Form(
          key: myKey,
          child: Padding(
            padding:   EdgeInsets.all(height*.01),
            child: Column(
              children: [
                SizedBox(height: height*.02),
                Center(child: bigImage(height: height)),
                SizedBox(height:height*.03,),
                _price(height: height),
                SizedBox(height:height*.02,),
                _name(height: height),


                SizedBox(height:height*.02,),

                _details(height: height),
                SizedBox(height:height*.02,),
                _saveButton(height: height,context: context),
                SizedBox(height:height*.4,),



              ],
            ),
          ),
        ),
      ),
    );
  }




  File? imageFile;
  XFile? picked;



  Widget bigImage({required double height}){
    if (imageFile==null){
      return Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),

        child: Container(
            height: height*.2,
            width: height*.2,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              //  boxShadow: [BoxShadow(color: Theme.of(context).canvasColor.withOpacity(.5),blurRadius: 5,spreadRadius: .1)]



            ),
            alignment: Alignment.center,
            child:
            EbottonI(
              icon: Icon(Icons.photo,color: Colors.black.withOpacity(.5),size: height*.02,),
              elevation: 3,
              shadowcolor: Colors.black             ,
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
              child: Text('إختر صوره',style: TextStyle(color: Colors.black,fontSize:height*.013 )),
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

double?price;
  _price({required double height}){
    return  SizedBox(
     // height: height*.1,
     width: height*.2,

      child: MyAddProductTextField(
        label: getLang(context, "price"),
          icon: Icon(Icons.price_change,color: Theme.of(context).canvasColor.withOpacity(.5)),
          length: 5,


          input: TextInputType.number,
          sFuntion: (String? s ){setState(() {price=double.parse(s!);});
return null;},
          vFuntion: (String? v){if (v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "price")}';}return null;}
      ),
    );
  }

  String?name;
  _name({required double height}){
    return
      MyAddProductTextField(
        icon: Icon(Icons.category,color: Theme.of(context).canvasColor.withOpacity(.5)),
        sFuntion: (s){setState(() {name=s!;});return null;},
        vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "name")}';}return null;},
        label: getLang(context, "name"),
        input: TextInputType.name,
        length: 30,

      )
      ;
  }

  String?details;
  _details({required double height}){
    return
      MyAddProductDetailsTextField(

        sFuntion: (s){setState(() {details=s!;});return null;},
        vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "details")}';}return null;},


      )
    ;
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
          child:  Text('${getLang(context, "add product")}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: height*.018),
              textDirection: TextDirection.rtl),


        )
    );
  }






  _save({required BuildContext context})async{
    var fire=Provider.of<FireProvider>(context,listen: false);




    if(myKey.currentState!.validate()){


      MyIndicator().loading(context);
      myKey.currentState!.save();
      debugPrint ('save done');


      if (picked==null) {
        Navigator.pop(context);
        MyFlush().showFlush(context: context, text: '${getLang(context, "select image")}');
        return;}
      else{



        if(! await fire.uploadImage(imageFile: imageFile!,picked: picked!)) {
          Navigator.pop(context);
          MyFlush().showFlush(context: context, text:'${getLang(context, "wrong try again")}' );
          return;}

        else{

          String id= Random().nextInt(100000).toString();


          Product product=Product(
              category: widget.category,
              section: widget.section,
              company: widget.company,
              kind: widget.kind,
            imageUrl: fire.imageUrl,
            photoLoc: fire.photoLoc,
            name: name,
            price: price,
            details: details,
            productId: id









          );

          await Product().addProduct(product);
          await fire.clearImages();
          Navigator.pop(context);
          Navigator.pop(context);
          MyFlush().showUploadingDoneFlush(context: context);





        }
      }






    }
    else{return;}


  }

}




class MyAddProductDetailsTextField extends StatelessWidget {

  double borderWidth = 0;
  Color borderColor = Colors.white.withOpacity(.0);
  Color fillColor = Colors.white.withOpacity(.0);
  double borderRadus = 5;









  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;



  MyAddProductDetailsTextField({Key? key,



    required this.vFuntion,
    required this.sFuntion,






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
      borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 1),
    );
    return TextFormField(

      obscureText: false,
      textInputAction: TextInputAction.newline,

      keyboardType: TextInputType.multiline,
      enabled: true,
      // minLines: 14,
      maxLines: 15,
      maxLength: 1000,

      validator:vFuntion ,
      onSaved:sFuntion ,
      textDirection:TextDirection.ltr ,
      scrollController: ScrollController(),

      selectionControls:CupertinoTextSelectionControls(),







      style: TextStyle(
          color:
          Colors.black
          ,
          fontSize:height*.02 ,
          leadingDistribution: TextLeadingDistribution.even,
          textBaseline: TextBaseline.alphabetic,


      ),
      decoration: InputDecoration(
         // fillColor: Theme.of(context).primaryColor,
          counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: height*.015),
          filled: true,
          isCollapsed: true,
          enabled: true,
          contentPadding:  EdgeInsets.all(height*.025),
          focusColor: Colors.yellow,
          hoverColor: Colors.red,
          labelText:getLang(context, "details") ,
          labelStyle: TextStyle(color: Colors.black,fontSize: height*.025),
          floatingLabelBehavior: FloatingLabelBehavior.always,











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






class MyAddProductTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.deepOrange.withOpacity(1);
  Color fillColor = Colors.white.withOpacity(.1);
  double borderRadus = 5;


  TextEditingController? myController ;
  final String label;
  final Icon icon;
  final bool obsecure;
  final TextInputType input;
  final int length;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  MyAddProductTextField({Key? key,
    required this.label,
    this.obsecure = false,
    required this.icon,
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

          prefixIcon: icon,
          prefixIconColor: Colors.orangeAccent,
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