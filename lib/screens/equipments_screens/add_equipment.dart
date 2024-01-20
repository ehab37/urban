import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/equipment.dart';
import 'package:urban/constants/my_flush.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/providers/fireProvider.dart';

class AddEquipmentScreen extends StatefulWidget {
  static const String route='AddEquipmentScreen/';

  final String kind;
  final String company;
  const AddEquipmentScreen({Key? key, required this.kind, required this.company}) : super(key: key);



  @override
  State<AddEquipmentScreen> createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddEquipmentScreen> {

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
      appBar: AppBar(title: const Text('add equipment')),

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

                _name(height: height),



                (widget.kind==mixerTruck||widget.kind==loader||widget.kind==excavator||widget.kind==mobileCrane)? _capacity(height: height):const SizedBox(),
                widget. kind==trailerConcretePump? _pressure(height: height):const SizedBox(),
                widget. kind==mobilePlacingBoom?  _lengthOfBoom(height: height):const SizedBox(),
                widget. kind==loader||widget.kind==bulldozer? _engine(height: height):const SizedBox(),
                widget. kind==bulldozer||widget.kind==excavator?  _weight(height: height):const SizedBox(),
                widget. kind==mixerTruck||widget.kind==mobileCrane||widget.kind==truckPump?  _brand(height: height):const SizedBox(),




                widget.kind==trailerConcretePump||widget.kind==truckPump? _output(height: height):const SizedBox(),
                widget. kind==mobilePlacingBoom? _numberOfBoom(height: height):const SizedBox(),
                widget. kind==trailerConcretePump||widget.kind==bulldozer||widget.kind==excavator? _power(height: height):const SizedBox(),
                widget. kind==truckPump? _reach(height: height):const SizedBox(),





                widget. kind==loader?  _load(height: height):const SizedBox(),
                widget. kind==mobileCrane?  _extendedBoom(height: height):const SizedBox(),



                SizedBox(height:height*.02,),
                _saveButton(height: height,context: context),
                SizedBox(height:height*.5,),



              ],
            ),
          ),
        ),
      ),
    );
  }




  double?price;
  _price({required double height}){
    return  SizedBox(
      // height: height*.1,
      width: height*.2,

      child: MyAddEquipmentPriceTextField(
          label: '${getLang(context, "price per day")}',
          icon: Icon(Icons.price_change,color: Theme.of(context).canvasColor.withOpacity(.5)),


          input: TextInputType.number,
          sFuntion: (String? s ){
            setState(() {price=double.parse(s!);});
            return null;},
          vFuntion: (String? v){if (v!.isEmpty){return'enter price';}
return null;}
      ),
    );
  }

  String?name;
  _name({required double height}){
    return
      Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.02),
        child: MyAddEquipmentTextField(
          icon: Icon(Icons.category,color: Theme.of(context).canvasColor.withOpacity(.5)),
          sFuntion: (s){setState(() {name=s!;});return null;},
          vFuntion: (v){if(v!.isEmpty){return'enter name';}return null;},
          label: '${getLang(context, "name")}',
          input: TextInputType.name,

        ),
      )
    ;
  }

  String?capacity;
  _capacity({required double height}){
    return
      Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.02),
        child: MyAddEquipmentTextField(
          icon: Icon(Icons.category,color: Theme.of(context).canvasColor.withOpacity(.5)),
          sFuntion: (s){setState(() {capacity=s!;});return null;},
          vFuntion: (v){if(v!.isEmpty){return'enter capacity';}return null;},
          label:'${getLang(context, "capacity")}' ,
          input: TextInputType.name,

        ),
      )
    ;
  }

  String?pressure;
  _pressure({required double height}){
    return
      Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.02),
        child: MyAddEquipmentTextField(
          icon: Icon(Icons.category,color: Theme.of(context).canvasColor.withOpacity(.5)),
          sFuntion: (s){setState(() {pressure=s!;});return null;},
          vFuntion: (v){if(v!.isEmpty){return'enter pressure';}return null;},
          label: '${getLang(context, "pressure")}',
          input: TextInputType.name,

        ),
      )
    ;
  }

  String?lengthOfBoom;
  _lengthOfBoom({required double height}){
    return
      Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.02),
        child: MyAddEquipmentTextField(
          icon: Icon(Icons.category,color: Theme.of(context).canvasColor.withOpacity(.5)),
          sFuntion: (s){setState(() {lengthOfBoom=s!;});return null;},
          vFuntion: (v){if(v!.isEmpty){return'enter length Of Boom';}return null;},
          label: '${getLang(context, "length Of Boom")}' ,
          input: TextInputType.name,

        ),
      )
    ;
  }

  String?engine;
  _engine({required double height}){
    return
      Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.02),
        child: MyAddEquipmentTextField(
          icon: Icon(Icons.category,color: Theme.of(context).canvasColor.withOpacity(.5)),
          sFuntion: (s){setState(() {engine=s!;});return null;},
          vFuntion: (v){if(v!.isEmpty){return'enter engine';}return null;},
          label: '${getLang(context, "engine")}' ,
          input: TextInputType.name,

        ),
      )
    ;
  }

  String?weight;
  _weight({required double height}){
    return
      Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.02),
        child: MyAddEquipmentTextField(
          icon: Icon(Icons.category,color: Theme.of(context).canvasColor.withOpacity(.5)),
          sFuntion: (s){setState(() {weight=s!;});return null;},
          vFuntion: (v){if(v!.isEmpty){return'enter weight';}return null;},
          label: '${getLang(context, "weight")}' ,
          input: TextInputType.name,

        ),
      )
    ;
  }


  String?brand;
  _brand({required double height}){
    return
      Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.02),
        child: MyAddEquipmentTextField(
          icon: Icon(Icons.category,color: Theme.of(context).canvasColor.withOpacity(.5)),
          sFuntion: (s){setState(() {brand=s!;});return null;},
          vFuntion: (v){if(v!.isEmpty){return'enter brand';}return null;},
          label: '${getLang(context, "brand")}' ,
          input: TextInputType.name,

        ),
      )
    ;
  }










  String?output;
  _output({required double height}){
    return
      Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.02),
        child: MyAddEquipmentTextField(
          icon: Icon(Icons.category,color: Theme.of(context).canvasColor.withOpacity(.5)),
          sFuntion: (s){setState(() {output=s!;});return null;},
          vFuntion: (v){if(v!.isEmpty){return'enter output';}return null;},
          label: '${getLang(context, "output")}' ,
          input: TextInputType.name,

        ),
      )
    ;
  }


  String?numberOfBoom;
  _numberOfBoom({required double height}){
    return
      Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.02),
        child: MyAddEquipmentTextField(
          icon: Icon(Icons.category,color: Theme.of(context).canvasColor.withOpacity(.5)),
          sFuntion: (s){setState(() {numberOfBoom=s!;});return null;},
          vFuntion: (v){if(v!.isEmpty){return'enter number Of Boom';}return null;},
          label: '${getLang(context, "number Of Boom")}' ,
          input: TextInputType.name,

        ),
      )
    ;
  }

  String?power;
  _power({required double height}){
    return
      Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.02),
        child: MyAddEquipmentTextField(
          icon: Icon(Icons.category,color: Theme.of(context).canvasColor.withOpacity(.5)),
          sFuntion: (s){setState(() {power=s!;});return null;},
          vFuntion: (v){if(v!.isEmpty){return'enter power';}return null;},
          label: '${getLang(context, "power")}' ,
          input: TextInputType.name,

        ),
      )
    ;
  }

  String?reach;
  _reach({required double height}){
    return
      Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.02),
        child: MyAddEquipmentTextField(
          icon: Icon(Icons.category,color: Theme.of(context).canvasColor.withOpacity(.5)),
          sFuntion: (s){setState(() {reach=s!;});return null;},
          vFuntion: (v){if(v!.isEmpty){return'enter reach ';}return null;},
          label: '${getLang(context, "reach")}' ,
          input: TextInputType.name,

        ),
      )
    ;
  }







  String?load;
  _load({required double height}){
    return
      Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.02),
        child: MyAddEquipmentTextField(
          icon: Icon(Icons.category,color: Theme.of(context).canvasColor.withOpacity(.5)),
          sFuntion: (s){setState(() {load=s!;});return null;},
          vFuntion: (v){if(v!.isEmpty){return'enter load';}return null;},
          label:'${getLang(context, "load")}' ,
          input: TextInputType.name,

        ),
      )
    ;
  }


  String?extendedBoom;
  _extendedBoom({required double height}){
    return
      Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.02),
        child: MyAddEquipmentTextField(
          icon: Icon(Icons.category,color: Theme.of(context).canvasColor.withOpacity(.5)),
          sFuntion: (s){setState(() {extendedBoom=s!;});return null;},
          vFuntion: (v){if(v!.isEmpty){return'enter extended Boom';}return null;},
          label: '${getLang(context, "pressure")}',
          input: TextInputType.name,

        ),
      )
    ;
  }





  File? imageFile;
  XFile? picked;


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
          child:  Text('إضافه المنتج',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: height*.018),
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
        MyFlush().showFlush(context: context, text: 'select image');
        return;}
      else{



        if(! await fire.uploadImage(imageFile: imageFile!,picked: picked!)) {
          Navigator.pop(context);
          MyFlush().showFlush(context: context, text: 'wrong try again');
          return;}

        else{

          String id= Random().nextInt(100000).toString();




          await Equip().addEquip(Equip(

            id: id,
            name: name,
            pricePerDay: price,

            imageUrl: fire.imageUrl,
            imageLoc:  fire.photoLoc,

            company: widget.company,
            kind: widget.kind,

            capacity: capacity,
            pressure: pressure,
            lengthOfBoom: lengthOfBoom,
            engine: engine,
            weight: weight,
            brand: brand,


            output: output,
            numberOfBoom: numberOfBoom,
            power: power,
            reach: reach,

            load: load,
            extendedBoom: extendedBoom,






          ));
          await fire.clearImages();
          Navigator.pop(context);
          Navigator.pop(context);

          MyFlush().showUploadingDoneFlush(context: context);




        }
      }






    }
    else{return;}


  }

  Widget bigImage({required double height}){
    if (imageFile==null){
      return Container(
          height: height*.2,
          width: height*.2,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Theme.of(context).canvasColor.withOpacity(.5),blurRadius: 5,spreadRadius: .1)]



          ),
          alignment: Alignment.center,
          child:
          EbottonI(
            icon: Icon(Icons.photo,color: Theme.of(context).iconTheme.color,size: height*.02,),
            elevation: 3,
            shadowcolor: Theme.of(context).canvasColor.withOpacity(.5)             ,
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

}
class MyAddEquipmentTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.deepOrange.withOpacity(1);
  Color fillColor = Colors.white.withOpacity(.1);
  double borderRadus = 5;


  TextEditingController? myController ;
  final String label;
  final Icon icon;
  final bool obsecure;
  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  MyAddEquipmentTextField({Key? key,
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
       maxLength: 20,
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


class MyAddEquipmentPriceTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.deepOrange.withOpacity(1);
  Color fillColor = Colors.white.withOpacity(.1);
  double borderRadus = 5;


  TextEditingController? myController ;
  final String label;
  final Icon icon;
  final bool obsecure;
  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  MyAddEquipmentPriceTextField({Key? key,
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
      maxLength: 5,
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