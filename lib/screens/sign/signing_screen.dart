import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/MyUser.dart';
import 'package:urban/constants/cities.dart';
import 'package:urban/providers/lang_provider.dart';
import 'package:urban/screens/sign/forgetPassword/enter_email.dart';


import '../../constants/my_indicators.dart';
import '../../providers/authProvider.dart';
import '../../providers/fireProvider.dart';
import '../home_screen.dart';


class SigningScreen extends StatefulWidget {
  static const  String route='SigningScreen/';
  const SigningScreen({Key? key}) : super(key: key);

  @override
  State<SigningScreen> createState() => _SigningScreenState();
}

class _SigningScreenState extends State<SigningScreen> {

  bool login=true;

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }

    return  SafeArea(


      child: Scaffold(
       // appBar: AppBar(title: const Text('signing'),),


        body:   Stack(
          children: [
            const Positioned(
                right: 0,left: 0,bottom: 0,top: 0,

                child: SizedBox()),
          Positioned(
            right: 0,left: 0,top: 0,
            child: Container(
              height: height*.35,
              color: Theme.of(context).appBarTheme.backgroundColor,
              padding: EdgeInsets.symmetric(horizontal: height*.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: height*.05),
                  Text('${getLang(context, "welcome")}',style: TextStyle(color: Colors.white,fontSize: height*.038),),
                  SizedBox(height: height*.015),
                  Text('${getLang(context, "please login")}',style: TextStyle(color: Colors.white,fontSize: height*.018,fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          ),

            Positioned(
              right: 0,top: 0,bottom: 0,left: 0,
              child: ListView(
                children: [
                  SizedBox(height: height*.2),
                 login? _loginBox(height: height,width: width):_signUpBox(height: height,width: width),



                ],
              ),
            ),





          ],
        )




      ),
    );
  }

final Duration _duration=const Duration(milliseconds: 300,);
final GlobalKey<FormState> _myKey=GlobalKey<FormState>();

String? name;
String? phone;
String? email;
String? password;

  _loginBox({required double height,required double width}){
    return
      AnimatedContainer(
        duration:_duration,
        width: width,
        height: height*.7,
        child: Stack(

          children: [

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: height*.015),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                elevation: 10,
                child: AnimatedContainer(
                  duration:_duration,
                  height: height*.6,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),

                  ),

                  child: Column(
                    children: [
                      SizedBox(height: height*.01),
                      SizedBox(
                       // color: Colors.red.withOpacity(.1),

                        height:  height*.1,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal:  height*.02),
                              child: AnimatedContainer(
                                 duration: _duration,
                                height: height*.1,
                                width: width*.4,
                                padding: EdgeInsets.all(height*.001),
                                alignment: Alignment.center,
                                // color: Colors.red,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${getLang(context, "login")}',style: TextStyle(color: Theme.of(context).textTheme.titleMedium!.color,fontSize: height*.02,fontWeight: FontWeight.w500 ),
                                      textAlign: TextAlign.center),
                                    SizedBox(height: height*.01),
                                    AnimatedContainer(
                                      duration: _duration,
                                      height: height*.003,
                                      width:width*.17 ,
                                      decoration: BoxDecoration( color: Theme.of(context).textTheme.titleMedium!.color,
                                      borderRadius: BorderRadius.circular(10)),
                                    )

                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  login=false;
                                });
                              },
                              child: AnimatedContainer(
                                 duration:_duration,
                                height: height*.1,
                                width: width*.25,
                                padding: EdgeInsets.all(height*.001),
                                alignment: Alignment.center,
                                // color: Colors.red,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${getLang(context, "signUp")}',style: TextStyle(color: Theme.of(context).textTheme.titleMedium!.color,fontSize: height*.02,fontWeight: FontWeight.w500 ),
                                       textAlign: TextAlign.center),
                                    SizedBox(height: height*.01),


                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Form(
                        key: _myKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height*.01,horizontal:height*.03 ),
                          child: Column(
                            children: [
                              SizedBox(height: height*.05,),
                              SigningTextField(
                                label: '${getLang(context, "email")}',
                                vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "email")}';}return null;},
                                sFuntion: (s){setState(() {
                                  email=s;
                                });return null;},
                                input: TextInputType.emailAddress,
                                icon: const Icon(Icons.email_outlined),

                              ),//email
                              SizedBox(height: height*.025),
                              SigningTextField(
                                label: '${getLang(context, "password")}',
                                vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "password")}';}return null;},
                                sFuntion: (s){setState(() {password=s;});return null;},
                                input: TextInputType.name,
                                icon: const Icon(Icons. key_outlined),
                                obsecure: true,

                              ),//password
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                    Checkbox(
                                        value: remember,
                                        checkColor:Colors.white ,
                                        onChanged: (v){setState(() {remember=v!;});},
                                      fillColor: MaterialStateProperty.all(Theme.of(context).canvasColor),

                                    ),
                                      Text('${getLang(context, "remember me")}',style: TextStyle(
                                          color:Colors.black,fontWeight: FontWeight.w400,fontSize: height*.015
                                      ),)
                                    ],
                                  ),
                                  InkWell(
                                    onTap: (){Navigator.pushNamed(context, EnterEmailScreen.route);},
                                    child: Text('${getLang(context, "forget password")}',style: TextStyle(
                                      color: Theme.of(context).textTheme.titleMedium!.color,fontWeight: FontWeight.w500,fontSize: height*.014,
                                      decoration: TextDecoration.underline,


                                    ),

                                    ),
                                  )
                                ],
                              )


                            ],


                          ),
                        ),

                      )


                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: height*0.06,
                right: width*.42,

                child: InkWell(
                  onTap: ()async{

                    if(_myKey.currentState!.validate()){

                      MyIndicator().loading(context);
                      _myKey.currentState!.save();

                      var auth=Auth();
                      auth.email=email!;
                      auth.password=password!;
                      if ( await auth.logIn())
                      {


                        Navigator.pushNamedAndRemoveUntil(context, Home.route, (route) => false);




                      }
                      else{
                        Navigator.pop(context);
                        debugPrint('login error');
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(auth.error.toString()))
                        );
                      }


                    }
                    else{

                      return;}




                  },
                  child: Material(
                    color: Colors.white,
                    elevation: 3,


                    type: MaterialType.circle,
                    child: Container(
                      height: height*.08,width: height*.08,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,

                      ),
                      child: Icon(Icons.arrow_forward_ios,size: height*.04,color: Theme.of(context).appBarTheme.backgroundColor),
                    ),
                  ),
                )


            )
          ],
        ),
      );

  }
  _signUpBox({required double height,required double width}){
    return
      AnimatedContainer(
        duration:_duration,
        width: width,
        height: height*.7,
        child: Stack(

          children: [

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: height*.015),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                elevation: 10,
                child: AnimatedContainer(
                  duration:_duration,
                  height: height*.6,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),

                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(

                      child: Column(
                        children: [
                          SizedBox(height: height*.01),
                          SizedBox(
                           // color: Colors.red.withOpacity(.1),

                            height:  height*.1,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal:  height*.02),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        login=true;
                                      });
                                    },

                                    child: AnimatedContainer(
                                       duration: const Duration(seconds: 1),
                                      height: height*.1,
                                      width: width*.4,
                                      padding: EdgeInsets.all(height*.001),
                                      alignment: Alignment.center,
                                      // color: Colors.red,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('${getLang(context, "login")}',style: TextStyle(color: Theme.of(context).textTheme.titleMedium!.color,fontSize: height*.02,fontWeight: FontWeight.w500 ),
                                              textAlign: TextAlign.center),
                                          SizedBox(height: height*.01),


                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                AnimatedContainer(
                                   duration:_duration,
                                  height: height*.1,
                                  width: width*.25,
                                  padding: EdgeInsets.all(height*.001),
                                  alignment: Alignment.center,
                                  // color: Colors.red,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('${getLang(context, "signUp")}',style: TextStyle(color: Theme.of(context).textTheme.titleMedium!.color,fontSize: height*.02,fontWeight: FontWeight.w500 ),
                                         textAlign: TextAlign.center),
                                      SizedBox(height: height*.01),
                                      AnimatedContainer(
                                        duration: _duration,
                                        height: height*.003,
                                        width:width*.17 ,
                                        decoration: BoxDecoration( color: Theme.of(context).textTheme.titleMedium!.color,
                                            borderRadius: BorderRadius.circular(10)),
                                      )


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Form(
                            key: _myKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: height*.01,horizontal:height*.03 ),
                              child: Column(
                                children: [


                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                      children: const [





                                      ],
                                    ),
                                  ),
                                  SigningTextField(
                                    label: '${getLang(context, "name")}',
                                    vFuntion: (v){if(v!.isEmpty||v[0]==' '){return'${getLang(context, "wrong name")}';}return null;},
                                    sFuntion: (s){setState(() {name=s;});return null;},
                                    input: TextInputType.name,
                                    icon: const Icon(Icons. person_sharp),

                                  ),//name
                                  SizedBox(height: height*.01,),
                                  SigningTextField(
                                    label: '${getLang(context, "email")}',
                                    vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "email")}';}return null;},
                                    sFuntion: (s){setState(() {email=s;});return null;},
                                    input: TextInputType.emailAddress,
                                    icon: const Icon(Icons.email_outlined),

                                  ),//email


                                  SizedBox(height: height*.01),
                                  SigningTextField(
                                    label: '${getLang(context, "password")}',
                                    vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "password")} ';}return null;},
                                    sFuntion: (s){setState(() {password=s;});return null;},
                                    input: TextInputType.text,
                                    icon: const Icon(Icons. key_outlined),
                                    obsecure: true  ,

                                  ),//password
                                  SizedBox(height: height*.01),
                                  SigningTextField(
                                    label: '${getLang(context, "phone")}',
                                    vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "phone")}';}return null;},
                                    sFuntion: (s){setState(() {phone=s;});return null;},
                                    input: TextInputType.phone,
                                    icon: const Icon(Icons. phone),

                                  ),//phone
                                  SizedBox(height: height*.01),
                                  ChangeNotifierProvider(
                                    create: (_) =>LangProvider() ,
                                    child:  Consumer<LangProvider>(
                                      builder: (context,LangProvider lanNoty,child) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                          children: [

                                            Material(
                                              color: Colors.white,
                                              elevation: 5,
                                              borderRadius: BorderRadius.circular(10),
                                              child: DropdownButton(
                                                borderRadius: BorderRadius.circular(10),
                                                elevation: 5,
                                                alignment: Alignment.center,
                                                underline: const SizedBox(),
                                                dropdownColor: Colors.white,

                                                items:Governorate().getGovernorates() .map((e) =>
                                                    DropdownMenuItem(value: e.id,child: Text(lanNoty.isEn?e.en!:e.ar!,style: const TextStyle(fontSize: 12,color: Colors.black),),)).toList(),

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
                                              color: Colors.white,
                                              elevation: 5,
                                              borderRadius: BorderRadius.circular(10),
                                              child: DropdownButton(
                                                borderRadius: BorderRadius.circular(10),
                                                elevation: 5,
                                                alignment: Alignment.center,
                                                underline: const SizedBox(),
                                                dropdownColor: Colors.white,
                                                items: City().getCities(key: cityGovernId, value: myGovernorateId) .map((e) =>
                                                    DropdownMenuItem(value: e.id,child: Text(lanNoty.isEn?e.en!:e.ar!,style: const TextStyle(fontSize: 12,color: Colors.black),),)).toList(),

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



                                ],


                              ),
                            ),

                          )


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: height*0.06,
                right: width*.42,

                child: InkWell(
                  onTap: ()async{
                    var authProvider=Provider.of<AuthProvider>(context,listen: false);
                    var fire=Provider.of<FireProvider>(context,listen: false);


                    if(!_myKey.currentState!.validate()){return;}
                    else{
                      MyIndicator().loading(context);


                      _myKey.currentState!.save();}
                    authProvider.password=password!;
                    authProvider.email=email!;



                      if (await authProvider.register()) {




                          if (await MyUser().addUser(
                              MyUser(
                                name: name,
                                phone: phone,
                                email: email,
                                photo: null,
                                id:  authProvider.user!.uid,
                                cityId: myCityId,
                              ))) {
                            await authProvider.logIn();
                            Navigator.pushNamedAndRemoveUntil(context, Home.route, (route) => false);

                          }
                          else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                                content: Text(authProvider.error!)));
                          }

                      }
                      else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(authProvider.error!))
                        );
                      }



                  },
                  child: Material(
                    color: Colors.white,
                    elevation: 3,


                    type: MaterialType.circle,
                    child: Container(
                      height: height*.08,width: height*.08,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,

                      ),
                      child: Icon(Icons.arrow_forward_ios,size: height*.04,color: Theme.of(context).appBarTheme.backgroundColor),
                    ),
                  ),
                )


            )
          ],
        ),
      );

  }
  bool remember=false;

  String myGovernorateId='1';

  String myCityId='1';

  File? imageFile;
  XFile? picked;
  Widget bigImage({required double height}){
    if (imageFile==null){
      return Material(
        elevation: 3,
        color: Colors.white,
        type: MaterialType.circle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: height*.07,
              width: height*.07,

              alignment: Alignment.center,
            child: const Icon(Icons.person_sharp,size: 50,color: Colors.grey),

            //Image(image: AssetImage('assets/images/cover.png'),width: 100,height: 100,),

          ),
        ),
      );}
    else {return
      Material(
        //  borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        type: MaterialType.circle,
        elevation: 10,
        child: Container(
          height:  height*.07,width:  height*.07,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: FileImage(imageFile!,),
                  fit: BoxFit. fill
              )
          ),
        ),
      );}
  }
}



// ignore: must_be_immutable
class SigningTextField extends StatelessWidget {

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

  SigningTextField({Key? key,
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
      selectionControls: CupertinoTextSelectionControls(),

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

