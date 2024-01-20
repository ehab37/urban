import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/MyUser.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/my_flush.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/providers/fireProvider.dart';
import 'package:urban/screens/user/edit_Photo.dart';
class SettingScreen extends StatefulWidget {
  static const String route='SettingScreen/';
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  String? name;
  String? phone;
  String? password;
  final GlobalKey<FormState> _myKey=GlobalKey<FormState>();
  final GlobalKey<FormState> _myKey2=GlobalKey<FormState>();
  final GlobalKey<FormState> _myKey3=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return Scaffold(
      appBar: AppBar(title: Text(getLang(context, "settings"))),
      body: ListView(
        padding: const EdgeInsets.all(15),

        children: [
          InkWell(
            onTap: ()async{
             showDialog(context: context, builder: (BuildContext context)=>
             Dialog(
               backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              child: SizedBox(
                height: height*.2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Form(
                        key: _myKey,
                        child: MyEditTextField(
                            label: getLang(context, "name"),
                            sFuntion: (s){setState(() {name=s!;});return null;},
                            vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "name")}';}return null;},
                            input: TextInputType.text
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Ebotton(
                            onpressed: ()async{

                              if(!_myKey.currentState!.validate()){return;}
                              else{
                                MyIndicator().loading(context);
                                _myKey.currentState!.save();
                                await MyUser().editUser(
                                    userId:Provider.of<FireProvider>(context,listen: false).myId! ,
                                    key: userName,
                                  newValue: name

                                );

                                Navigator.pop(context);

                              }

                              Navigator.pop(context);
                              MyFlush().showDoneFlush(context: context, text: '${getLang(context, "update done")}');
                            },
                            elevation: 5,
                            borderRadius: 10,
                            backgroundcolor: Colors.white,
                            padding: 10,
                            overColor: Colors.white,
                            child:Text('${getLang(context, "done")}',style: const TextStyle(color: Colors.green),),
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
             )

             );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5,
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('${getLang(context, "change name")}',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color),)),
                ),
              ),
            ),
          ),//name
          InkWell(
            onTap: ()async{
              showDialog(context: context, builder: (BuildContext context)=>
                  Dialog(
                    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                    child: SizedBox(
                      height: height*.2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Form(
                              key: _myKey2,
                              child: MyEditTextField(
                                  label: getLang(context, "phone"),
                                  sFuntion: (s){setState(() {phone=s!;});return null;},
                                  vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "phone")}';}return null;},
                                  input: TextInputType.text
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Ebotton(
                                  onpressed: ()async{

                                    if(!_myKey2.currentState!.validate()){return;}
                                    else{
                                      MyIndicator().loading(context);
                                      _myKey2.currentState!.save();
                                      await MyUser().editUser(
                                          userId:Provider.of<FireProvider>(context,listen: false).myId! ,
                                          key: userPhone,
                                          newValue: phone

                                      );

                                      Navigator.pop(context);

                                    }

                                    Navigator.pop(context);
                                    MyFlush().showDoneFlush(context: context, text: '${getLang(context, "update done")}');
                                  },
                                  elevation: 5,
                                  borderRadius: 10,
                                  backgroundcolor: Colors.white,
                                  padding: 10,
                                  overColor: Colors.white,
                                  child:Text('${getLang(context, "done")}',style: const TextStyle(color: Colors.green),),
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
                  )

              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5,
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('${getLang(context, "change phone")}',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color),)),
                ),
              ),
            ),
          ),//phone
          InkWell(
            onTap: ()async{
              Navigator.pushNamed(context, EditUserPhoto.route);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5,
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('${getLang(context, "change photo")}',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color),)),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: ()async{
              showDialog(context: context, builder: (BuildContext context)=>
                  Dialog(
                    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                    child: SizedBox(
                      height: height*.2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Form(
                              key: _myKey3,
                              child: MyEditTextField(
                                  label: getLang(context, "password"),
                                  sFuntion: (s){setState(() {password=s!;});return null;},
                                  vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "password")}';}return null;},
                                  input: TextInputType.text
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Ebotton(
                                  onpressed: ()async{

                                    if(!_myKey3.currentState!.validate()){return;}
                                    else{
                                      MyIndicator().loading(context);
                                      _myKey3.currentState!.save();
                                     Provider.of<FireProvider>(context,listen: false).myUser!.updatePassword(password!);

                                      Navigator.pop(context);

                                    }

                                    Navigator.pop(context);
                                    MyFlush().showDoneFlush(context: context, text: '${getLang(context, "update done")}');
                                  },
                                  elevation: 5,
                                  borderRadius: 10,
                                  backgroundcolor: Colors.white,
                                  padding: 10,
                                  overColor: Colors.white,
                                  child:Text('${getLang(context, "done")}',style: const TextStyle(color: Colors.green),),
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
                  )

              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5,
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('${getLang(context, "change password")}',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color),)),
                ),
              ),
            ),
          ),//password

        ],
      ),



    );
  }


}
class MyEditTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.white.withOpacity(1);
  Color fillColor = Colors.white.withOpacity(.1);
  double borderRadus = 5;


  TextEditingController? myController ;
  final String label;
  //final Icon icon;
  final bool obsecure;
  final TextInputType input;
 // final int length;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  MyEditTextField({Key? key,
    required this.label,
    this.obsecure = false,
   // required this.icon,
    required this.vFuntion,
    required this.sFuntion,
    this.myController,
    required this.input,
    //required this.length



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
      style: TextStyle(color: Colors.white,fontSize:height*.019,fontWeight: FontWeight.bold ),
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

         // prefixIcon: icon,
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