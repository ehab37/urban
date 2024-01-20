// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, camel_case_types, must_be_immutable, avoid_debugPrint

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/providers/fireProvider.dart';
import 'package:urban/screens/admin/admin_Orders_screen.dart';
import 'package:urban/screens/user/User_Orders_screen.dart';
import 'package:urban/screens/admin/admin_messages-list.dart';
import 'package:urban/screens/admin/admin_requests.dart';
import 'package:urban/screens/admin/admin_workers.dart';
import 'package:urban/screens/call_Center/carts.dart';
import 'package:urban/screens/user/User_profile.dart';
import 'package:urban/screens/user/carts_screen.dart';
import 'package:urban/screens/equipments_screens/kinds_screen.dart';
import 'package:urban/screens/home_screen.dart';
import 'package:urban/screens/user/user_experts.dart';
import 'package:urban/screens/user/user_workers.dart';

import '../screens/material_screens/section_screen.dart';
import 'data/main_info.dart';

Color color_y = const Color(0xffD19E28);
Color color_b = const Color(0xff1A3644);
Color color_r = const Color(0xffB94B3E);
Color color_b1 = const Color(0xff1B313F);

Color color_bl = const Color(0xff252525);
Color color_1 = const Color(0xff07523A);
Color color_2 = const Color(0x00a4a4a4);

Color backColor1 = const Color(0xff1B1B1B);

Color backColor2 = const Color(0xffA4A4A4);
Color backColor3 = const Color(0xffC24E4E);
Color backColor4 = const Color(0xff592C1C);

Color womenColor1 = const Color(0xffD984BB);
Color womenColor2 = const Color(0xff673875);
Color kidsColor = Colors.cyan;
Color kidsColor2 = const Color(0xff023535);

Color menColor1 = const Color(0xff26110C);
Color menColor2 = const Color(0xff592C1C);
Color menColor3 = const Color(0xff8C5042);
//0xA4A4A4

class EbottonI extends StatelessWidget {
  final VoidCallback onpressed;

  // final VoidCallback onlongpress;
  final Widget child;
  final Widget icon;

  // final FocusNode focusnode;
  final AlignmentGeometry alignmentt;
  final Color backgroundcolor;
  final Color shadowcolor;
  final Color forgroundcolor;
  final double padding;
  final double elevation;

  //final bool autofocuS;
  //final Clip clipbehavior;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final Color overColor;

  //final Key? key1;

  const EbottonI({
    required this.onpressed,
    required this.child,
    required this.icon,
    this.backgroundcolor = Colors.blue,
    this.padding = 1,
    this.elevation = 1,
    this.forgroundcolor = Colors.black,
    this.alignmentt = Alignment.center,
    //this.focusnode,
    // this.autofocuS ,
    // this.clipbehavior ,
    // this.key1,
    // this.onlongpress,
    this.shadowcolor = Colors.white,
    this.overColor = Colors.black,
    this.borderColor = Colors.white,
    this.borderRadius = 0,
    this.borderWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      // key: Keyy,
      onPressed: onpressed,
      //onLongPress: onlongpress,
      label: child,
      icon: icon,

      // focusNode: focusnode,
      // autofocus: autofocuS,
      // clipBehavior: clipbehavior,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundcolor),
        alignment: alignmentt,
        elevation: MaterialStateProperty.all(elevation),
        padding: MaterialStateProperty.all(EdgeInsets.all(padding)),
        shadowColor: MaterialStateProperty.all(shadowcolor),
        foregroundColor: MaterialStateProperty.all(forgroundcolor),
        overlayColor: MaterialStateProperty.all(overColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius))),
        side: MaterialStateProperty.all(
            BorderSide(width: borderWidth, color: borderColor.withOpacity(0))),
      ),
    );
  }
}

class Obotton extends StatelessWidget {
  final VoidCallback onpressed;

  // final VoidCallback? onlongpress;
  final Widget child;

  // final FocusNode? focusnode;
  final AlignmentGeometry? alignmentt;
  final Color backgroundcolor;
  final Color shadowcolor;
  final Color forgroundcolor;
  final double padding;
  final double elevation;

  // final bool? autofocuS;
  // final Clip? clipbehavior;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final Color overColor;

  //final Key? Keyy;

  const Obotton({
    Key? key,
    required this.onpressed,
    required this.child,
    // this.onlongpress,
    this.backgroundcolor = Colors.blue,
    this.padding = 1,
    this.shadowcolor = Colors.white,
    this.elevation = 0,
    this.forgroundcolor = Colors.black,
    this.alignmentt = Alignment.center,
    //this.focusnode,
    // this.autofocuS =false,
    // this.clipbehavior = Clip.none,
    //this.Keyy,
    this.overColor = Colors.black,
    this.borderColor = Colors.white,
    this.borderRadius = 2,
    this.borderWidth = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      // key: Keyy,
      onPressed: onpressed,
      // focusNode: focusnode,
      // autofocus: autofocuS!,
      // clipBehavior: clipbehavior!,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundcolor),
        alignment: alignmentt,
        elevation: MaterialStateProperty.all(elevation),
        padding: MaterialStateProperty.all(EdgeInsets.all(padding)),
        shadowColor: MaterialStateProperty.all(shadowcolor),
        foregroundColor: MaterialStateProperty.all(forgroundcolor),
        overlayColor: MaterialStateProperty.all(overColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius))),
        side: MaterialStateProperty.all(
            BorderSide(width: borderWidth, color: borderColor)),
      ),
      // onLongPress: onlongpress,
      child: child,
    );
  }
}

class Tbotton extends StatelessWidget {
  final VoidCallback onpressed;

  final Widget child;

  final AlignmentGeometry alignmentt;
  final Color backgroundcolor;
  final Color shadowcolor;
  final Color forgroundcolor;
  final double padding;
  final double elevation;

  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final Color overColor;

// final bool? autofocuS;
  // final Clip? clipbehavior;
  // final FocusNode? focusnode;
  // final VoidCallback? onlongpress;
  //final Key? Keyy;

  const Tbotton({
    Key? key,
    required this.onpressed,
    required this.child,
    this.backgroundcolor = Colors.blue,
    this.padding = 1,
    this.shadowcolor = Colors.white,
    this.elevation = 0,
    this.forgroundcolor = Colors.white,
    this.alignmentt = Alignment.center,
    this.overColor = Colors.black,
    this.borderColor = Colors.white,
    this.borderRadius = 2,
    this.borderWidth = 1,
    //this.focusnode,
    // this.autofocuS =false,
    // this.clipbehavior = Clip.none,
    //this.Keyy,
    // this.onlongpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // key: Keyy,
      onPressed: onpressed,
      // focusNode: focusnode,
      //autofocus: autofocuS,
      // clipBehavior: clipbehavior,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundcolor),
        alignment: alignmentt,
        elevation: MaterialStateProperty.all(elevation),
        padding: MaterialStateProperty.all(EdgeInsets.all(padding)),
        shadowColor: MaterialStateProperty.all(shadowcolor),
        foregroundColor: MaterialStateProperty.all(forgroundcolor),
        overlayColor: MaterialStateProperty.all(overColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius))),
        side: MaterialStateProperty.all(
            BorderSide(width: borderWidth, color: borderColor)),
      ),
      // onLongPress: onlongpress,
      child: child,
    );
  }
}

class Ebotton extends StatelessWidget {
  final VoidCallback onpressed;

  // final VoidCallback onlongpress;
  final Widget child;

  // final FocusNode focusnode;
  final AlignmentGeometry alignmentt;
  final Color backgroundcolor;
  final Color shadowcolor;
  final Color forgroundcolor;
  final double padding;
  final double elevation;

  // final bool autofocuS;
  // final Clip clipbehavior;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final Color overColor;

  //final Key Keyy;

  const Ebotton(
      {required this.onpressed,
      required this.child,
      //  this.onlongpress,
      this.backgroundcolor = Colors.blue,
      this.padding = 0,
      this.shadowcolor = Colors.white,
      this.elevation = 0,
      this.forgroundcolor = Colors.white,
      this.alignmentt = Alignment.center,
      //  this.focusnode,
      // this.autofocuS = false,
      //  this.clipbehavior = Clip.none,
      //this.Keyy,
      this.overColor = Colors.black,
      this.borderColor = Colors.white,
      this.borderRadius = 0,
      this.borderWidth = 0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // key: Keyy,
      onPressed: onpressed,
      //focusNode: focusnode,
      // autofocus: autofocuS,
      // clipBehavior: clipbehavior,

      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundcolor),
        alignment: alignmentt,
        elevation: MaterialStateProperty.all(elevation),
        padding: MaterialStateProperty.all(EdgeInsets.all(padding)),
        shadowColor: MaterialStateProperty.all(shadowcolor),
        foregroundColor: MaterialStateProperty.all(forgroundcolor),
        overlayColor: MaterialStateProperty.all(overColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius))),
        side: MaterialStateProperty.all(
            BorderSide(width: borderWidth, color: borderColor)),
      ),
      // onLongPress: onlongpress,
      child: child,
    );
  }
}

class Textt extends StatelessWidget {
  const Textt(
      {this.text = 'hello',
      this.color = Colors.black,
      this.size = 20,
      this.weight = true,
      //  this.backgroundcolor,
      this.shadowcolor = Colors.white,
      this.offsetx = 0,
      this.offsety = 0,
      this.blurradius = 0,
      this.italic = false});

  final String text;
  final Color color;
  final double size;
  final bool weight;

  // final Color backgroundcolor;
  final Color shadowcolor;
  final double offsetx;
  final double offsety;
  final double blurradius;
  final bool italic;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: weight ? FontWeight.bold : FontWeight.normal,
          //backgroundColor: backgroundcolor,
          shadows: [
            Shadow(
                color: shadowcolor,
                offset: Offset(offsetx, offsety),
                blurRadius: blurradius)
          ],
          fontStyle: italic ? FontStyle.italic : FontStyle.normal),
    );
  }
}

class myTextFormField extends StatelessWidget {
  double borderWidth = 0;
  Color borderColor = color_y.withOpacity(0.1);
  double borderRadus = 5;
  TextEditingController? myController;

  final String label;
  final Icon icon;
  final bool obsecure;
  final TextInputType input;
  final String? Function(String?) vFuntion;
  final String? Function(String?) sFuntion;

  //Function ontapFunction;

  myTextFormField(
      {Key? key,
      required this.label,
      this.obsecure = false,
      required this.icon,
      required this.vFuntion,
      required this.sFuntion,
      this.myController,
      required this.input})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
          fillColor: Colors.black.withOpacity(.8),
          filled: true,
          isCollapsed: true,
          contentPadding: const EdgeInsets.all(20),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: label,
          labelStyle: TextStyle(
            color: color_y,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
          prefixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          )),
      obscureText: obsecure,
      textInputAction: TextInputAction.done,
      keyboardType: input,
      enabled: true,

      validator: vFuntion,
      onSaved: sFuntion,
      // onTap: ontapFunction,
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

class MyPasswordTextField extends StatelessWidget {
  double borderWidth = .5;
  Color borderColor = Colors.black.withOpacity(0);

  double borderRadus = 5;

  TextEditingController? myController;

  final String label;
  final Icon prefIcon;
  final Widget sufIcon;
  final bool obsecure;
  final TextInputType input;

  final String? Function(String?) vFuntion;
  final String? Function(String?) sFuntion;

  //Function ontapFunction;

  MyPasswordTextField(
      {Key? key,
      required this.label,
      this.obsecure = false,
      required this.prefIcon,
      required this.sufIcon,
      required this.vFuntion,
      required this.sFuntion,
      this.myController,
      required this.input})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.height;
    }
    width = width;

    return Material(
      elevation: 3,
      shadowColor: Colors.deepOrange
      //Theme.of(context).canvasColor
      ,
      color: Colors.white.withOpacity(0),
      type: MaterialType.button,
      child: TextFormField(
        style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall!.color,
            fontSize: height * .02),
        decoration: InputDecoration(
            fillColor: Theme.of(context).primaryColor,
            filled: true,
            isCollapsed: true,
            contentPadding: const EdgeInsets.all(10),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: label,
            labelStyle: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .color!
                    .withOpacity(.7),
                fontSize: height * .02),
            prefixIcon: prefIcon,
            suffixIcon: sufIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadus),
              borderSide: BorderSide(color: borderColor, width: borderWidth),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadus),
              borderSide: BorderSide(color: borderColor, width: borderWidth),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadus),
              borderSide: BorderSide(color: borderColor, width: borderWidth),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadus),
              borderSide: BorderSide(color: borderColor, width: borderWidth),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadus),
              borderSide: BorderSide(color: borderColor, width: borderWidth),
            )),

        obscureText: obsecure,
        textInputAction: TextInputAction.go,
        keyboardType: input,
        enabled: true,
        // autovalidateMode:  AutovalidateMode.onUserInteraction,

        validator: vFuntion,
        onSaved: sFuntion,
        // onTap: ontapFunction,
        controller: myController,
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

class myFilterPriceTextField extends StatelessWidget {
  double borderWidth = 1;
  Color borderColor = Colors.black.withOpacity(1);
  Color fillColor = Colors.white.withOpacity(.2);
  double borderRadus = 0;

  TextStyle inputTextStyle = const TextStyle(color: Colors.white, fontSize: 10);
  TextStyle labelTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  TextEditingController? myController;

  //final String label;
  // final Icon icon;
  final bool obsecure;
  final TextInputType input;

  final String? Function(String?) vFuntion;
  final String? Function(String?) sFuntion;

  //Function ontapFunction;

  myFilterPriceTextField(
      {Key? key,
      //required this.label,
      this.obsecure = false,
      // required this.icon,
      required this.vFuntion,
      required this.sFuntion,
      this.myController,
      required this.input})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: inputTextStyle,
      decoration: InputDecoration(
          fillColor: fillColor,
          filled: true,
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
          errorStyle: const TextStyle(fontSize: 8),
          // floatingLabelBehavior: FloatingLabelBehavior.auto,
          //labelText: label,
          // labelStyle: labelTextStyle,
          // prefixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          )),

      obscureText: obsecure,
      textInputAction: TextInputAction.done,
      keyboardType: input,
      enabled: true,
      cursorColor: Colors.white,
      textAlign: TextAlign.center,

      validator: vFuntion,
      onSaved: sFuntion,
      // onTap: ontapFunction,
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

Widget editIcon(
    {required VoidCallback onTap,
    required double height,
    required BuildContext context}) {
  return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).canvasColor,
                    blurRadius: 2,
                    spreadRadius: 1,
                    blurStyle: BlurStyle.outer)
              ]),
          padding: EdgeInsets.all(height * .005),
          child: Icon(
            Icons.edit,
            color: Theme.of(context).iconTheme.color,
            size: height * .025,
          )));
}

class MyCloseButton extends StatelessWidget {
  final VoidCallback onpressed;

  final AlignmentGeometry alignmentt;
  final Color backgroundcolor;
  final Color shadowcolor;

  final double padding;
  final double elevation;

  final double borderRadius;

  final Color overColor;

  const MyCloseButton({
    required this.onpressed,
    this.backgroundcolor = Colors.blue,
    this.padding = 1,
    this.elevation = 1,
    this.alignmentt = Alignment.center,
    this.shadowcolor = Colors.white,
    this.overColor = Colors.black,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.height;
    }
    width = width;

    return ElevatedButton.icon(
      onPressed: onpressed,
      label: Text(
        'الغاء',
        style: TextStyle(
            color: Colors.white,
            fontSize: height * .016,
            fontWeight: FontWeight.w700),
      ),
      icon: Icon(Icons.close, color: Colors.white, size: height * .022),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red.withOpacity(.5)),
        alignment: alignmentt,
        elevation: MaterialStateProperty.all(elevation),
        padding: MaterialStateProperty.all(EdgeInsets.all(height * .01)),
        shadowColor: MaterialStateProperty.all(Theme.of(context).canvasColor),
        overlayColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius))),
      ),
    );
  }
}

class MySaveButton extends StatelessWidget {
  final VoidCallback onpressed;

  final AlignmentGeometry alignmentt;
  final Color backgroundcolor;
  final Color shadowcolor;

  final double padding;
  final double elevation;

  final double borderRadius;

  final Color overColor;

  const MySaveButton({
    required this.onpressed,
    this.backgroundcolor = Colors.blue,
    this.padding = 1,
    this.elevation = 1,
    this.alignmentt = Alignment.center,
    this.shadowcolor = Colors.white,
    this.overColor = Colors.black,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.height;
    }
    width = width;

    return ElevatedButton.icon(
      onPressed: onpressed,
      label: Text(
        'حفظ',
        style: TextStyle(
            color: Colors.white,
            fontSize: height * .016,
            fontWeight: FontWeight.w700),
      ),
      icon: Icon(Icons.done, color: Colors.white, size: height * .024),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Colors.green.withOpacity(.7)),
        alignment: alignmentt,
        elevation: MaterialStateProperty.all(elevation),
        padding: MaterialStateProperty.all(EdgeInsets.all(height * .01)),
        shadowColor: MaterialStateProperty.all(Theme.of(context).canvasColor),
        overlayColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius))),
      ),
    );
  }
}

class NewFloatingUser extends StatefulWidget {
  const NewFloatingUser({Key? key}) : super(key: key);

  @override
  NewFloatingUserState createState() => NewFloatingUserState();
}

class NewFloatingUserState extends State<NewFloatingUser> {
  double bottom1 = 0;
  double right1 = 10;

  double bottom2 = 0;
  double right2 = 10;

  double bottom3 = 0;
  double right3 = 10;

  double bottom4 = 0;
  double right4 = 10;

  double bottom5 = 0;
  double right5 = 10;

  double bottom6 = 0;
  double right6 = 10;
  double bottom7 = 0;
  double right7 = 10;
  double bottom8 = 0;
  double right8 = 10;
  double bottom9 = 0;
  double right9 = 10;
  double bottom10 = 0;
  double right10 = 10;

  double bottom0 = 10;
  double right0 = 10;

  double myBottom = 10;
  double myRight = 10;

  Duration myDuration = const Duration(milliseconds: 300);

  double heightc = 60;
  double widthc = 60;
  double heightc1 = 50;
  double widthc1 = 50;
  BoxShape myShape = BoxShape.circle;
  int x = 100;
  Curve myCurve = Curves.easeOutSine;

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHieght = MediaQuery.of(context).size.height;

    return Positioned(
      bottom: 0, right: myRight,
      // curve: myCurve,duration: Duration(milliseconds: 1),

      child: Container(
        height: heightc,
        width: widthc,
        decoration: BoxDecoration(shape: myShape),
        child: Stack(children: [
          InkWell(
            child: SizedBox(
              width: myWidth,
              height: myHieght,
            ),

            /*     onTap: (){
                    setState(() {
                      myRight=10;
                      heightc=50;widthc=50;
                      bottom1=50;right1=10;
                      bottom2=0;right2=10;
                      bottom3=0;right3=10;
                      bottom4=100;right4=10;
                      bottom5=150;right5=10;
                      bottom6=0;right6=10;
                      bottom7=200;right7=10;
                    //  bottom8=250;right8=10;
                    //  bottom9=250;right9=10;
                    //  bottom10=250;right10=10;
                      bottom0=10;right0=10;
                      myShape=BoxShape.circle;

                    });
                  },*/
          ),

          Provider.of<FireProvider>(context, listen: false).myUserInfo == null
              ? const SizedBox()
              : item(
                  text: '${getLang(context, 'profile')}',
                  bottom: bottom9,
                  right: right9,
                  onTap: () {
                    Navigator.pushNamed(context, UserProfileScreen.route);
                  },
                  image: 'user',
                ), //UserWorkersScreen

          item(
            text: '${getLang(context, "experts")}',
            bottom: bottom3,
            right: right3,
            onTap: () {
              Navigator.pushNamed(context, UserExpertsScreen.route);
            },
            image: 'callCenter',
          ), //UserWorkersScreen

          item(
            text: '${getLang(context, "workers")}',
            bottom: bottom7,
            right: right7,
            onTap: () {
              Navigator.pushNamed(context, UserWorkersScreen.route);
            },
            image: 'userWorker',
          ), //UserWorkersScreen

          item(
            text: '${getLang(context, "orders")}',
            bottom: bottom2,
            right: right2,
            onTap: () {
              Navigator.pushNamed(context, UserOrdersScreen.route);
            },
            image: 'orders',
          ), //UserOrdersScreen

          item(
            text: '${getLang(context, "cart")}',
            bottom: bottom5,
            right: right5,
            onTap: () {
              Navigator.pushNamed(context, CartsScreen.route);
            },
            image: 'cart',
          ), //CartsScreen

          item(
            text: '${getLang(context, "Equipments")}',
            bottom: bottom1,
            right: right1,
            onTap: () {
              Navigator.pushNamed(context, EquipmentsKindScreen.route);
            },
            image: 'equipments',
          ), //Equipments

          item(
            text: '${getLang(context, "finishes")}',
            bottom: bottom8,
            right: right8,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MaterialSectionsScreen(category: finishes),
                  ));
            },
            image: 'finishes',
          ), //finishes

          item(
            text: '${getLang(context, "constructions")}',
            bottom: bottom6,
            right: right6,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MaterialSectionsScreen(category: constructions),
                  ));
            },
            image: 'constructions',
          ), //Material

          item(
            text: '${getLang(context, "home")}',
            bottom: bottom4,
            right: right4,
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, Home.route, (route) => false);
            },
            image: 'home',
          ), //home

          Positioned(
            bottom: bottom0, right: right0,
            // duration: Duration(milliseconds: 1),
            //curve: myCurve,
            child: InkWell(
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor!,
                child: const Image(
                    image: AssetImage('assets/images/homeIcons/logo.png'),
                    width: 40,
                    height: 40),
              ),
              onTap: () {
                if (heightc == 60) {
                  setState(() {
                    heightc = myHieght;
                    widthc = myWidth;
                    myShape = BoxShape.circle;
                  });
                } else {
                  setState(() {
                    heightc = 60;
                    widthc = 60;
                    myShape = BoxShape.circle;
                  });
                }

                //  if (bottom10==0){setState(() {bottom10=420;right10=10;});} else{setState(() {bottom10=0;right10=10;});}//AdminRequestsScreen

                if (bottom9 == 0) {
                  setState(() {
                    bottom9 = 550;
                    right9 = 10;
                  });
                } else {
                  setState(() {
                    bottom9 = 0;
                    right9 = 10;
                  });
                } //Admin_Orders

                if (bottom3 == 0) {
                  setState(() {
                    bottom3 = 490;
                    right3 = 10;
                  });
                } else {
                  setState(() {
                    bottom3 = 0;
                    right3 = 10;
                  });
                } //call-Center-Cart

                if (bottom7 == 0) {
                  setState(() {
                    bottom7 = 430;
                    right7 = 10;
                  });
                } else {
                  setState(() {
                    bottom7 = 0;
                    right7 = 10;
                  });
                } //UserWorkersScreen

                if (bottom2 == 0) {
                  setState(() {
                    bottom2 = 370;
                    right2 = 10;
                  });
                } else {
                  setState(() {
                    bottom2 = 0;
                    right2 = 10;
                  });
                } //Orders

                if (bottom5 == 0) {
                  setState(() {
                    bottom5 = 310;
                    right5 = 10;
                  });
                } else {
                  setState(() {
                    bottom5 = 0;
                    right5 = 10;
                  });
                } //carts

                if (bottom1 == 0) {
                  setState(() {
                    bottom1 = 250;
                    right1 = 10;
                  });
                } else {
                  setState(() {
                    bottom1 = 0;
                    right1 = 10;
                  });
                } //equipments

                if (bottom6 == 0) {
                  setState(() {
                    bottom6 = 190;
                    right6 = 10;
                  });
                } else {
                  setState(() {
                    bottom6 = 0;
                    right6 = 10;
                  });
                } //constructions

                if (bottom8 == 0) {
                  setState(() {
                    bottom8 = 130;
                    right8 = 10;
                  });
                } else {
                  setState(() {
                    bottom8 = 0;
                    right8 = 10;
                  });
                } //finishes

                if (bottom4 == 0) {
                  setState(() {
                    bottom4 = 70;
                    right4 = 10;
                  });
                } else {
                  setState(() {
                    bottom4 = 0;
                    right4 = 10;
                  });
                } //home

                if (right0 == 0) {
                  setState(() {
                    bottom0 = 10;
                    right0 = 10;
                  });
                } else {
                  setState(() {
                    bottom0 = 10;
                    right0 = 10;
                  });
                }
                // if(myShape==BoxShape.circle){setState(() {myShape=BoxShape.rectangle;});}else{setState(() {myShape=BoxShape.circle;});}
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget item(
      {required double bottom,
      required double right,
      required VoidCallback onTap,
      required String text,
      required String image}) {
    return AnimatedPositioned(
        bottom: bottom,
        right: right,
        curve: myCurve,
        duration: myDuration,
        child: InkWell(
          onTap: () {
            onTap();

            setState(() {
              heightc = 60;
              widthc = 60;
              bottom1 = 0;
              right1 = 10;
              bottom2 = 0;
              right2 = 10;
              bottom3 = 0;
              right3 = 10;
              bottom4 = 0;
              right4 = 10;
              bottom5 = 0;
              right5 = 10;
              bottom6 = 0;
              right6 = 10;
              bottom7 = 0;
              right7 = 10;
              bottom8 = 0;
              right8 = 10;
              bottom9 = 0;
              right9 = 10;
              //  bottom10=250;right10=10;
              bottom0 = 10;
              right0 = 10;
              myShape = BoxShape.circle;
            });
          },
          child: SizedBox(
            width: 150,
            height: 40,
            child: Material(
              borderRadius: BorderRadius.circular(20),
              elevation: heightc == 60 ? 0 : 5,
              color: heightc == 60
                  ? Colors.white.withOpacity(0)
                  : Theme.of(context).appBarTheme.backgroundColor!,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    heightc != 60
                        ? Text(
                            text,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          )
                        : const SizedBox(),
                    const SizedBox(width: 10),
                    heightc != 60
                        ? CircleAvatar(
                            // backgroundImage:  AssetImage('assets/images/homeIcons/$image.png'),
                            radius: 8,
                            backgroundColor: Colors.white.withOpacity(0),
                            child: Image(
                                image: AssetImage(
                                    'assets/images/homeIcons/$image.png')),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class NewFloatingAdmin extends StatefulWidget {
  const NewFloatingAdmin({Key? key}) : super(key: key);

  @override
  NewFloatingAdminState createState() => NewFloatingAdminState();
}

class NewFloatingAdminState extends State<NewFloatingAdmin> {
  double bottom1 = 0;
  double right1 = 10;

  double bottom2 = 0;
  double right2 = 10;

  double bottom3 = 0;
  double right3 = 10;

  double bottom4 = 0;
  double right4 = 10;

  double bottom5 = 0;
  double right5 = 10;

  double bottom6 = 0;
  double right6 = 10;
  double bottom7 = 0;
  double right7 = 10;
  double bottom8 = 0;
  double right8 = 10;
  double bottom9 = 0;
  double right9 = 10;
  double bottom10 = 0;
  double right10 = 10;

  double bottom0 = 10;
  double right0 = 10;

  double myBottom = 10;
  double myRight = 10;

  Duration myDuration = const Duration(milliseconds: 300);

  double heightc = 60;
  double widthc = 60;
  double heightc1 = 50;
  double widthc1 = 50;
  BoxShape myShape = BoxShape.circle;
  int x = 100;
  Curve myCurve = Curves.easeOutSine;

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHieght = MediaQuery.of(context).size.height;

    return Positioned(
      bottom: 0, right: myRight,
      // curve: myCurve,duration: Duration(milliseconds: 1),

      child: Container(
        height: heightc,
        width: widthc,
        decoration: BoxDecoration(shape: myShape),
        child: Stack(children: [
          InkWell(
            child: SizedBox(
              width: myWidth,
              height: myHieght,
            ),

            /*     onTap: (){
                    setState(() {
                      myRight=10;
                      heightc=50;widthc=50;
                      bottom1=50;right1=10;
                      bottom2=0;right2=10;
                      bottom3=0;right3=10;
                      bottom4=100;right4=10;
                      bottom5=150;right5=10;
                      bottom6=0;right6=10;
                      bottom7=200;right7=10;
                    //  bottom8=250;right8=10;
                    //  bottom9=250;right9=10;
                    //  bottom10=250;right10=10;
                      bottom0=10;right0=10;
                      myShape=BoxShape.circle;

                    });
                  },*/
          ),

          Provider.of<FireProvider>(context, listen: false).myUserInfo == null
              ? const SizedBox()
              : item(
                  text: '${getLang(context, 'profile')}',
                  bottom: bottom9,
                  right: right9,
                  onTap: () {
                    Navigator.pushNamed(context, UserProfileScreen.route);
                  },
                  image: 'user',
                ), //UserWorkersScreen

          item(
            text: '${getLang(context, "messages")}',
            bottom: bottom3,
            right: right3,
            onTap: () {
              Navigator.pushNamed(context, AdminMessagesList.route);
            },
            image: 'messages',
          ), //AdminMessagesList

          item(
            text: '${getLang(context, "requests")}',
            bottom: bottom10,
            right: right10,
            onTap: () {
              Navigator.pushNamed(context, AdminRequestsScreen.route);
            },
            image: 'requests',
          ), //AdminRequestsScreen

          item(
            text: '${getLang(context, "workers")}',
            bottom: bottom7,
            right: right7,
            onTap: () {
              Navigator.pushNamed(context, AdminWorkersScreen.route);
            },
            image: 'userWorker',
          ), //AdminWorkersScreen

          item(
            text: '${getLang(context, "orders")}',
            bottom: bottom2,
            right: right2,
            onTap: () {
              Navigator.pushNamed(context, AdminOrdersScreen.route);
            },
            image: 'orders',
          ), //AdminOrdersScreen

          item(
            text: '${getLang(context, "cart")}',
            bottom: bottom5,
            right: right5,
            onTap: () {
              Navigator.pushNamed(context, CallCenterCarts.route);
            },
            image: 'cart',
          ), //CallCenterCarts

          item(
            text: '${getLang(context, "Equipments")}',
            bottom: bottom1,
            right: right1,
            onTap: () {
              Navigator.pushNamed(context, EquipmentsKindScreen.route);
            },
            image: 'equipments',
          ), //Equipments

          item(
            text: '${getLang(context, "finishes")}',
            bottom: bottom8,
            right: right8,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MaterialSectionsScreen(category: finishes),
                  ));
            },
            image: 'finishes',
          ), //finishes

          item(
            text: '${getLang(context, "constructions")}',
            bottom: bottom6,
            right: right6,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MaterialSectionsScreen(category: constructions),
                  ));
            },
            image: 'constructions',
          ), //Material

          item(
            text: '${getLang(context, "home")}',
            bottom: bottom4,
            right: right4,
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, Home.route, (route) => false);
            },
            image: 'home',
          ), //home

          Positioned(
            bottom: bottom0, right: right0,
            // duration: Duration(milliseconds: 1),
            //curve: myCurve,
            child: InkWell(
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor!,
                child: const Image(
                    image: AssetImage('assets/images/homeIcons/logo.png'),
                    width: 40,
                    height: 40),
              ),
              onTap: () {
                if (heightc == 60) {
                  setState(() {
                    heightc = myHieght;
                    widthc = myWidth;
                    myShape = BoxShape.circle;
                  });
                } else {
                  setState(() {
                    heightc = 60;
                    widthc = 60;
                    myShape = BoxShape.circle;
                  });
                }

                if (bottom9 == 0) {
                  setState(() {
                    bottom9 = 610;
                    right9 = 10;
                  });
                } else {
                  setState(() {
                    bottom9 = 0;
                    right9 = 10;
                  });
                } //profile

                if (bottom3 == 0) {
                  setState(() {
                    bottom3 = 550;
                    right3 = 10;
                  });
                } else {
                  setState(() {
                    bottom3 = 0;
                    right3 = 10;
                  });
                } //messages

                if (bottom7 == 0) {
                  setState(() {
                    bottom7 = 490;
                    right7 = 10;
                  });
                } else {
                  setState(() {
                    bottom7 = 0;
                    right7 = 10;
                  });
                } //WorkersScreen

                if (bottom10 == 0) {
                  setState(() {
                    bottom10 = 430;
                    right10 = 10;
                  });
                } else {
                  setState(() {
                    bottom10 = 0;
                    right10 = 10;
                  });
                } //workers requests

                if (bottom2 == 0) {
                  setState(() {
                    bottom2 = 370;
                    right2 = 10;
                  });
                } else {
                  setState(() {
                    bottom2 = 0;
                    right2 = 10;
                  });
                } //orders

                if (bottom5 == 0) {
                  setState(() {
                    bottom5 = 310;
                    right5 = 10;
                  });
                } else {
                  setState(() {
                    bottom5 = 0;
                    right5 = 10;
                  });
                } //carts

                if (bottom1 == 0) {
                  setState(() {
                    bottom1 = 250;
                    right1 = 10;
                  });
                } else {
                  setState(() {
                    bottom1 = 0;
                    right1 = 10;
                  });
                } //equipments

                if (bottom6 == 0) {
                  setState(() {
                    bottom6 = 190;
                    right6 = 10;
                  });
                } else {
                  setState(() {
                    bottom6 = 0;
                    right6 = 10;
                  });
                } //constructions

                if (bottom8 == 0) {
                  setState(() {
                    bottom8 = 130;
                    right8 = 10;
                  });
                } else {
                  setState(() {
                    bottom8 = 0;
                    right8 = 10;
                  });
                } //finishes

                if (bottom4 == 0) {
                  setState(() {
                    bottom4 = 70;
                    right4 = 10;
                  });
                } else {
                  setState(() {
                    bottom4 = 0;
                    right4 = 10;
                  });
                } //home

                if (right0 == 0) {
                  setState(() {
                    bottom0 = 10;
                    right0 = 10;
                  });
                } else {
                  setState(() {
                    bottom0 = 10;
                    right0 = 10;
                  });
                }
                // if(myShape==BoxShape.circle){setState(() {myShape=BoxShape.rectangle;});}else{setState(() {myShape=BoxShape.circle;});}
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget item(
      {required double bottom,
      required double right,
      required VoidCallback onTap,
      required String text,
      required String image}) {
    return AnimatedPositioned(
        bottom: bottom,
        right: right,
        curve: myCurve,
        duration: myDuration,
        child: InkWell(
          onTap: () {
            onTap();

            setState(() {
              heightc = 60;
              widthc = 60;
              bottom1 = 0;
              right1 = 10;
              bottom2 = 0;
              right2 = 10;
              bottom3 = 0;
              right3 = 10;
              bottom4 = 0;
              right4 = 10;
              bottom5 = 0;
              right5 = 10;
              bottom6 = 0;
              right6 = 10;
              bottom7 = 0;
              right7 = 10;
              bottom8 = 0;
              right8 = 10;
              bottom9 = 0;
              right9 = 10;
              bottom10 = 0;
              right10 = 10;
              bottom0 = 10;
              right0 = 10;
              myShape = BoxShape.circle;
            });
          },
          child: SizedBox(
            width: 150,
            height: 40,
            child: Material(
              borderRadius: BorderRadius.circular(20),
              elevation: heightc == 60 ? 0 : 5,
              color: heightc == 60
                  ? Colors.white.withOpacity(0)
                  : Theme.of(context).appBarTheme.backgroundColor!,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    heightc != 60
                        ? Text(
                            text,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          )
                        : const SizedBox(),
                    const SizedBox(width: 10),
                    heightc != 60
                        ? CircleAvatar(
                            // backgroundImage:  AssetImage('assets/images/homeIcons/$image.png'),
                            radius: 8,
                            backgroundColor: Colors.white.withOpacity(0),
                            child: Image(
                                image: AssetImage(
                                    'assets/images/homeIcons/$image.png')),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
